# git-wt bug: `wt.copy` が gitignored なシンボリックリンクをコピーしない

## 概要

`git-wt` の `wt.copy` ディレクティブは「gitignore されたファイルでもコピーする」と文書化されているが、コピー対象がシンボリックリンクの場合、worktree にコピーされない。

- **バージョン**: git-wt v0.26.2
- **プラットフォーム**: Linux (Ubuntu)、macOS でも同一コードパスの問題あり

## 再現条件

以下の **すべて** を満たすときに発生する:

1. ファイル/ディレクトリがシンボリックリンクである
2. そのシンボリックリンクが `.gitignore` で無視されている
3. `wt.copy` パターンでコピー対象に指定されている

※ git-tracked なシンボリックリンクは `git checkout` で復元されるため問題にならない。
※ gitignored でも通常ファイル（非シンボリックリンク）は正しくコピーされる。

## 再現手順

```bash
# ── セットアップ ──
mkdir -p /tmp/wt-symlink-bug/link-target
echo "hello" > /tmp/wt-symlink-bug/link-target/test.txt

cd /tmp/wt-symlink-bug
git init repo && cd repo
echo "initial" > README.md

# シンボリックリンクを2つ作成（gitignored / non-ignored）
ln -s /tmp/wt-symlink-bug/link-target .symlink-ignored
ln -s /tmp/wt-symlink-bug/link-target .symlink-not-ignored

# .symlink-ignored だけ gitignore に追加
echo ".symlink-ignored" > .gitignore

git add -A && git commit -m "init"

# 両方を wt.copy に登録
git config --add wt.copy ".symlink-ignored"
git config --add wt.copy ".symlink-not-ignored"

# ── 再現 ──
git wt test-branch

# ── 結果確認 ──
ls -la .worktrees/test-branch/.symlink-not-ignored
# => 存在する（git checkout により復元）

ls -la .worktrees/test-branch/.symlink-ignored
# => 存在しない（★バグ: wt.copy でコピーされるべき）

# ── 後片付け ──
git wt -d test-branch
cd / && rm -rf /tmp/wt-symlink-bug
```

### 期待する動作

`.symlink-ignored` が worktree にシンボリックリンクとしてコピーされる。

### 実際の動作

`.symlink-ignored` は worktree に存在しない。エラーメッセージも出力されない。

## 実際のユースケース

`.devcontainer` ディレクトリを外部リポジトリからシンボリックリンクで参照し、`.gitignore` に追加しているケース:

```
.devcontainer -> /home/user/devcontainer-images/my-project/_.devcontainer
```

`wt.copy = .devcontainer` を設定しても、worktree 作成時にコピーされない。

## 原因分析

### ファイル探索（正常に動作）

`internal/git/copy.go` の `listIgnoredFiles()` (L196-207) は `git ls-files --others --ignored --exclude-standard` でファイルを列挙する。この段階ではシンボリックリンクも正しくリストアップされる。

### コピー処理（ここにバグ）

`internal/git/copy_file.go` の `copyFile()` (L16-59):

```go
func copyFile(src, dst string) (err error) {
    srcInfo, err := os.Stat(src)  // ← ★ os.Stat はシンボリックリンクを辿る
    if err != nil {
        return err
    }

    if srcInfo.IsDir() {  // ← シンボリックリンク先がディレクトリの場合 true → skip
        return nil
    }

    in, err := os.Open(src)  // ← シンボリックリンク先を開く
    // ...
    io.Copy(out, in)  // ← 実体のコピー（シンボリックリンクは保持されない）
}
```

**問題点:**

1. `os.Stat()` はシンボリックリンクを辿ってリンク先の情報を返す。リンク先がディレクトリの場合、`srcInfo.IsDir()` が `true` になり `return nil` でスキップされる（**サイレントに無視**）
2. リンク先がファイルの場合でも、実体の中身がコピーされ、シンボリックリンクとしては保持されない
3. `os.Lstat()` / `os.Readlink()` / `os.Symlink()` によるシンボリックリンクのハンドリングが一切ない

同様のバグが `internal/git/copy_file_darwin.go` (L18-43) にも存在する。

### 対照的に正しく実装されている箇所

`internal/git/copy.go` の `wt.symlink` 処理 (L83-114) ではディレクトリのシンボリックリンク作成に `os.Lstat()` と `os.Symlink()` を正しく使用している。この知見が `copyFile()` には適用されていない。

## 修正案

### `internal/git/copy_file.go` (Linux)

```go
func copyFile(src, dst string) (err error) {
    // os.Stat ではなく os.Lstat を使い、シンボリックリンク自体の情報を取得
    srcInfo, err := os.Lstat(src)
    if err != nil {
        return err
    }

    // シンボリックリンクの場合: リンクを再作成
    if srcInfo.Mode()&os.ModeSymlink != 0 {
        target, err := os.Readlink(src)
        if err != nil {
            return err
        }
        if err := os.MkdirAll(filepath.Dir(dst), 0755); err != nil {
            return err
        }
        return os.Symlink(target, dst)
    }

    // ディレクトリはスキップ
    if srcInfo.IsDir() {
        return nil
    }

    // 以下、通常ファイルのコピー処理（既存コードと同じ）
    // ...
}
```

### `internal/git/copy_file_darwin.go` (macOS)

同様に `os.Stat` → `os.Lstat` に変更し、シンボリックリンク判定を追加。`unix.Clonefile` に `CLONE_NOFOLLOW` フラグが渡されているが、`os.Stat` で事前にディレクトリ判定してスキップしているため到達しない。

### テスト追加

`internal/git/copy_test.go` に以下のテストケースを追加:

- gitignored なシンボリックリンク（リンク先がディレクトリ）が `wt.copy` で worktree にシンボリックリンクとしてコピーされること
- gitignored なシンボリックリンク（リンク先がファイル）が `wt.copy` で worktree にシンボリックリンクとしてコピーされること
- リンク先が存在しない壊れたシンボリックリンクの場合のエラーハンドリング

# Global Codex Instructions
## 全般
- 複数のサブエージェント(terra)を使っても良い(必要なければ使わなくてもよい)
- ローカルの特定リポジトリのコードのpathを示す際は、そのリポジトリのrootからのpathを示すこと

## 調査タスク
- 調査結果を出す際には、根拠となるURLやドキュメント箇所を明示すること

## GitHub Handling
- ユーザーが GitHub の PR / Issue / commit / diff URL を渡した場合は、まず `gh` CLI で取得を試す。
- この環境では sandbox 内の `gh` が `error connecting to api.github.com`、DNS 解決失敗、network restriction などで失敗しやすいため、GitHub 取得目的の `gh` コマンドは最初から scoped な `require_escalated` で実行する。`prefix_rule` は `["gh", "pr", "view"]`、`["gh", "issue", "view"]`、`["gh", "api"]` など、実行する操作に必要な最小範囲にする。
- Web search やブラウザ取得は、`gh` で取れない、または公開ページ確認が必要な場合の fallback とする。
- ローカルに関連ブランチがあっても、PR 番号・title・head/base・files は可能な限り `gh pr view` で先に確認する。


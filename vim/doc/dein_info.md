# FUNCTIONS
## dein#add({repo}[, {options}])
プラグインを初期化する.
{repo}がgithubのユーザー名で始まる場合(ex: "Shougo/dein.vim")の場合,
deinはgithubプラグインをインストールします.
注意)dein#begin()ブロック内で呼び出すこと.

## dein#begin({base-path}, [{vimrcs}])
dein.vimの初期化とプラグイン設定のブロックを開始する.
{base-path}は,ダウンロードしたプラグインが置かれる場所.
("~/.cache/dein" または "~/.local/share/dein "が典型的な置き場所)
ex)「Shougo/dein.vim」は"{base-path}/repos/github.com/Shougo/dein.vim"ディレクトリ
にダウンロードされる.
{vimrcs}は,例えるなら.vimrcやその他の設定(TOML)ファイルのリストのようなものです.
デフォルトは |$MYVIMRC| です。
注意)"vim-starting"のブロックの中で呼び出さないこと
注意2) :filetype offで自動実行される(?)

## dein#build([{plugins}])
Build for {plugins}.
{plugins} is the plugins name list.

## dein#check_install({plugins})
{plugins}(プラグインのリスト)のインストール状況をチェックします.
もし {plugins} がインストールされていなければ, 0 以外の値が返されます.
{plugins}が無効な場合は-1を返します.
{plugins}を省略した場合は,すべてのプラグインのインストールをチェックします.
注意)メッセージは |:silent| で無効にすることができます

## dein#install([{plugins}])
非同期にプラグインをインストールします.
{plugins}を省略した場合,deinはすべてのプラグインをインストール
## dein#end()
dein設定ブロックを終了します.
|dein#begin()|のブロック内でプラグインを使ってはいけません.
注意)'runtimepath'は|dein#end()|の後に変更される.(?)

##dein#load_state({base-path}), dein#min#load_state({base-path})
deinの状態をキャッシュスクリプトから読み込み,
{base-path}はダウンロードしたプラグインが置かれる場所です.
ダウンロードしたプラグインが配置されます.
キャッシュスクリプトが古いか,無効か,見つからない場合は1を返します。
注意1) |dein#begin()| の前に呼び出さなければなりません.
これはdeinのすべての設定をクリアします.
注意2)'runtimeepath'を完全に上書きします.動的に'runtimeepath'を変更した後に
呼び出してはいけません.
注意3)deinの状態が読み込まれている場合,このブロックはスキップされます。
注意4)｜dein#min#load_state()｜は,少しだけ高速化しています.

```
if dein#min#load_state(path)
  call dein#begin(path)
  " My plugins here:
  " ...
  call dein#end()
  call dein#save_state()
endif
```

## dein#load_toml({filename}, [{options}])
TOML プラグインの設定を {filename} から読み込みます。 
注意1) TOML パーサーは低速です. |dein#load_state()| および |dein#save_state()| と併用してください.
注意2)｜dein#begin()｜の引数でTOMLファイルを指定する必要があります.
注意3) オプション {options}に設定するキーについては |dein-options| を参照してください。
```
let s:toml = '~/test_vim/lazy.toml'
if dein#load_state('~/test_vim/.cache/dein')
  call dein#begin('~/test_vim/.cache/dein')
  call dein#load_toml(s:toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
```

## dein#save_state()
deinの状態をキャッシュスクリプトに保存する.
|dein#end()| の後でなければならない.
注意1) .vimrc を読み込むときに利用
注意2) runtimepath を完全に保存するので動的に'runtimeepath'を変更した後
にこれを呼んではいけない.

## dein#source([{plugins}])
 {plugins}で指定されたプラグインを:sourceする.
省略した場合は,すべてのプラグインを:sourceします。
ソースとなるプラグインのリストを返します。

## dein#check_clean()
使っていないプラグインのディレクトリを返す.
コマンドをラップして削除できるゾ

# VARIABLES


# OPTIONS
## lazy
lazyをtrueにするとdeinはパスを'runtimepath'に自動的に追加しなくなる.
"plugin/"ディレクトリを持たないプラグインを遅延処理に指定してはいけない.
それには意味がないし,オーバーヘッドを増やすだけだから.
意味のない遅延プラグインを指定するには|dein#check_lazy_plugins()| を使用すること.

## on_ft (List) or (String)
filetypeが一致した時,deinは|dein#source()|をcallする.

# FAQ

- プラグインの削除方法
```
call map(dein#check_clean(), { _, val -> delete(val, 'rf') })
call dein#recache_runtimepath()
```

- dein.vimの削除

~/.cache/deinをまるごと削除すれば良い

# 宿題
- ${XDG_CONFIG_HOME:-~/.config}/nvim/init.vim
- @
れじすた？
- fzfの導入の意味

# モード用語
: exモード

# よく忘れる操作
移動前に戻す, 進む: <c-o><c-i>

# よく忘れる用語
- %
編集中ファイル名
-%:p
編集中ファイルの絶対パス(ファイル名含む)
-silent
処理の結果見たくない時
- "vim_starting"
vimrc に起動時のみに実行されるコードを書く
- &
&を付けるとsetで設定するvimのオプションにアクセス出来る
逆に言うとsetはvim内部への設定
- call
関数を呼び出す.引数はカッコで囲みコンマ(,)で区切る
- #
[autoload](https://mattn.kaoriya.net/software/vim/20111202085236.htm)
フォルダ階層で区切られたファイルが#でセパレートされたネームスペースで呼び出される


- autocmd, :au[tocmd]
:autocmd ＜イベント＞ ＜ファイルパターン＞ ＜実行コマンド＞
Vim で指定したイベントが起きた際に自動的に実行するコマンドを指定するコマンド.
イベント例)BufNewFile
:help {event}を参照
:source .vimrcするとautocmd は上書きされずに複数回定義されることに注意
.vimrc を読み込む際に autocmd! することで定義済みの autocmd が削除されこの問題は回避することができるが,想定していない autocmd の定義まで削除されてしまう恐れあり
=> augroupに頼ろう

- augroup
autocmd をグループ化する.
augroup内でのautocmd!は同じグループのautocmd定義のみ削除する.

# 参考情報
[Vim公式](https://vim-jp.org/vimdoc-ja/)

[vimrcをファイル分割する＆VimとNeoVimで共通化する](https://okayu-moka.hatenablog.com/entry/2017/10/12/223048)

[初心者が頑張るVim入門(基本の使い方とおすすめの拡張機能)](https://www.kuroshum.com/entry/2019/12/20/%E5%88%9D%E5%BF%83%E8%80%85%E3%81%8C%E9%A0%91%E5%BC%B5%E3%82%8BVim%E5%85%A5%E9%96%80%28%E5%9F%BA%E6%9C%AC%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%81%A8%E3%81%8A%E3%81%99%E3%81%99%E3%82%81%E3%81%AE%E6%8B%A1)

[vimスクリプトの変数](https://kaworu.jpn.org/vim/vim%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%AE%E5%A4%89%E6%95%B0)

[Vimメモ : filetypeの確認](https://wonderwall.hatenablog.com/entry/2016/03/20/222308)

[ファイルの拡張子によって、vimに自動でインデント幅を変えてもらおう！](https://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef)

[zenn記事 filetype毎の設定を関数単位で分ける](https://zenn.dev/rapan931/articles/081a302ed06789)

[Vim: 編集中のファイルの絶対パス名](https://kwakita.blog/2014/05/20/vim-absolute-pathname-of-file/)

[初心者向け設定説明](https://qiita.com/tsuyoshi_cho/items/a3752fec176199563d17)

[dein.vimでプラグイン管理の始め方](https://qiita.com/sugamondo/items/fcaf210ca86d65bcaca8)

[dein.vimによるプラグイン管理のマイベストプラクティス](https://qiita.com/kawaz/items/ee725f6214f91337b42b):.vimrcのruntimepathの設定みよ

[Vimを使う - 総まとめ](https://news.mynavi.jp/itsearch/article/hardware/5397)

[vimのgfコマンドで、縦分割版をやってみた](https://yuheikagaya.hatenablog.jp/entry/2012/12/03/202556)

[おさらい autocmd/augroup](https://qiita.com/s_of_p/items/b61e4c3a0c7ee279848a):かなり古い記事なのでその点注意

[dein.vim:tomlファイルでプラグイン管理する](https://leico.github.io/TechnicalNote/VimR/VimR-dein-toml)

[WindowsのNeovimにfzfを導入したい](https://teratail.com/questions/352438)

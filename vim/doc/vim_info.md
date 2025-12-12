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
- <leader>
[<leader>キーとは、複数キー入力に割り当てられる任意のキー](https://vim.blue/leader-key/)
let mapleader = "\<Space>"って感じで設定, それぞれのファイル内でしか有効じゃないっぽい?

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

- :bufdo
後続コマンドをすべてのバッファに対して実行

- :tab split
現在のバッファを新しいタブで開く

- :ba[ll]
バッファリストのすべてのバッファをウィンドウを開く

- :tab ba
ballコマンド

# vimの関数
- !は同名の関数がある場合は上書きします

- abortは関数内でエラーが発生した場合,そこで処理を終了します

- [<expr>](https://sasasa.org/vim/expr/)
マップや短縮入力を定義するときに "<expr>" 引数を指定すると,引数が式 (スクリプ
ト) として扱われます.マップが実行されたときに,式が評価され,その値が {rhs}
として使われます

- {rhs}
right-hand-side (右辺値) の略, 逆は{lhs}

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


[Vimを使う - 総まとめ](https://news.mynavi.jp/itsearch/article/hardware/5397)

[vimのgfコマンドで、縦分割版をやってみた](https://yuheikagaya.hatenablog.jp/entry/2012/12/03/202556)

[おさらい autocmd/augroup](https://qiita.com/s_of_p/items/b61e4c3a0c7ee279848a):かなり古い記事なのでその点注意


[WindowsのNeovimにfzfを導入したい](https://teratail.com/questions/352438)

[Vimでパターン検索するなら知っておいたほうがいいこと](https://deris.hatenablog.jp/entry/2013/05/15/024932):vim特有のメタ文字, とりあえずエスケープはバックスラッシュ\

[fzfを使おう](https://qiita.com/kompiro/items/a09c0b44e7c741724c80): TODO ripgrep, bat?

[vim バッファ入門](https://zenn.dev/sa2knight/articles/e0a1b2ee30e9ec22dea9)

[「実践Vim」を読んで得られた考えをまとめてみた3（コマンドラインモード）](https://qiita.com/sfp_waterwalker/items/22f30277de14fbb4ec4f)

[Vimですべてのバッファをタブ化する](https://qiita.com/kuwa72/items/deef2703af74d2d993ee)

[Vimが本来もつ力を掘り下げる](https://qiita.com/lighttiger2505/items/bf4755cd912f7272ba60)

[Vimでバッファなどに関する各種情報を表示してみる](https://yk5656.hatenadiary.org/entry/20131215/1387098750)

[vim-deviconsで格好いいvimを作ろう。](https://qiita.com/park-jh/items/4358d2d33a78ec0a2b5c)

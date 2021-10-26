# [Language Server](https://note.com/ktakayama/n/ne9d3bfd2eec4)
Microsoft が仕様を公開した Language Server Protocol の実装.

IDEに必要な基本機能である
(1)コード補完(2)ドキュメント,定義元の参照(3)エラーチェック(4)テキスト整形
上記機能の実現のため言語ごとに違う部分を抽象化して,
開発ツールから使えるようにするための仕様がLSPである.

ちなみに LSP 実装としては Ruby だと Solargraph、PHP だと php-language-server あたりが
有名?らしい.

## VimとLanguage Server
 LanguageClient-neovim や vim-lsp

# [vim-lsp-settings](https://qiita.com/mattn/items/e62b9f16bc487a271a7f)
vim-lsp の導入コストを下げるプラグイン

# 参考
[VimでLSPを使ってKotlinを書く](https://yyyank.blogspot.com/2020/12/vimlspkotlin.html)

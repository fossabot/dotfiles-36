# Fcitx + Mozc

## Requirement
* [Fcitx](https://fcitx-im.org/wiki/Special:MyLanguage/Fcitx)
* [Mozc](https://github.com/google/mozc)
* [AZIK](http://hp.vector.co.jp/authors/VA002116/azik/azikinfo.htm)
    * [romantable.txt](https://github.com/ghsable/dotfiles/blob/master/bin/fcitx_mozc/romantables/romantable.txt)
    * [aziktable.txt](https://github.com/ghsable/dotfiles/blob/master/bin/fcitx_mozc/romantables/aziktable.txt)

## Usage

change romantable:

    # OPEN Mozc(config_dialog)
    sh fcitx_mozc.sh mozc_a
    # 一般 > キー設定 > ローマ字テーブル > 編集... > 編集 > インポート > OK
    # > "~/bin/fcitx_mozc/romantables/aziktable.txt" > Open

other:

    sh fcitx_mozc.sh usage

this script : [fcitx_mozc.sh](https://github.com/ghsable/dotfiles/blob/master/bin/fcitx_mozc/fcitx_mozc.sh)

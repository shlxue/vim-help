# vim help

通过 vim2html 工具将 vim doc 目录转换成 html 后，由 xlstproc 工具生成电子书必要的 opf 与 toc 文件,
并最终由 kindlegen 生成电子书 vim-help.azw3

## Build

prepare tools:

* vim
* perl
* xlstproc
* kindlegen

Generate ebook: `make`

## Issue

Remove warning when build azw3 file.

```sh
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/insert.html#i_CTRL-R
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/repeat.html#:@
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/tags#help-tags
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/insert.html#i_CTRL-R_CTRL-R
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/insert.html#i_CTRL-R_CTRL-O
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/insert.html#i_CTRL-R_CTRL-P
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/term.html#<S-LeftMouse>
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/repeat.html#:star
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/mbyte.html#OnTheSpot
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/mbyte.html#OffTheSpot
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/mbyte.html#OverTheSpot
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/mbyte.html#Root
Warning(prcgen):W14001: Hyperlink not resolved:  .tmp/pi_netrw.html#netrw-:MT
```

check vim doc file, and remove unless content.

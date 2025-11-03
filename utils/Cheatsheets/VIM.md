Fundamentals:
"a = Use "a" register
"b = Use "b" register
"ayiw = Copy the current word into the "a" register
"ap = Paste what you've copied into "a" register

[count] [operation] [motion]
Examples of Operations:
  - d = delete
  - c = change
  - v = visualmode
  - zf = fold

examples of motions:
  - a = around
  - i = inside
  - t = tag

Ex: zfat = fz(fold) + a(around) + t(tag)
di" = d(delete) + i(inside) + "(quotes)
ci{ = c(change) + i(inside) + {(curly brackets)

[Vim]
zfat = Fold a <tag> -> To expand just press l
0 = Go to the beggining of the line
$ = Go to the end of the line
_ = Go to the first character of the line
gj = Move down in a line wrap
jk = Move up in a line wrap
[/<pattern>] + enter + cgn then . = Replace and apply to the next ones

[vim-surround]
cs[{ = Change what's surrounded by [] to {}
ssy" = Wrap the entire line with ""

[LunarVim]

leader = <Space>

<leader> + w = Write the current file
<leader> + q = Quit vim and ask confirmation if there's changes not saved
<Esc> or <C> + [ => Exiting modes

g? = Show mappings
R = Refresh


<A> + k j => Move current line up / down

Link Ref:
  - https://vimdoc.sourceforge.net/htmldoc/quickref.html#quickref
  - https://vim.rtorr.com/
  - https://devhints.io/vim

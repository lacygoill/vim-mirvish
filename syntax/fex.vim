vim9script

if exists('b:current_syntax')
    finish
endif

# Syntax {{{1

syntax match fexTreeOnlyLastComponent '─\s\zs.*/\ze.\{-}[^/]' conceal
syntax match fexTreeOnlyLastComponentBeforeWarning '─\s\zs.*/\ze.\{-}/\s\[.\{-}\]' conceal

syntax match fexTreeDirectory '\%(─\s.*/\)\@<=[^/]*/$'
syntax match fexTreeExecutable '[^/]*\*$'

syntax match fexTreeLinkPrefix '─\s\zs/.*/\ze[^/]*\s->\s' conceal
syntax match fexTreeLink '[^/]*\s->\s'
#                         ├───┘
#                         └ last path component of a symlink:
#
#                                   /proc/11201/exe -> /usr/lib/firefox/firefox*
#                                               ^-----^

syntax match fexTreeLinkFile       '\%(\s->\s\)\@4<=.*[^*/]$'
syntax match fexTreeLinkDirectory  '\%(\s->\s\)\@4<=.*/$'
syntax match fexTreeLinkExecutable '\%(\s->\s\)\@4<=.*\*$'

syntax match fexTreeWarning '[^/]*/\=\ze\s\[.\{-}\]'
syntax match fexTreeHelp '^"\s.*' contains=fexTreeHelpKey,fexTreeHelpTitle,fexTreeHelpCmd
syntax match fexTreeHelpKey '^"\s\zs\S\+\%(\s\S\+\)\=' contained
#                                             │
#                                             └ `f` in `C-w f`
syntax match fexTreeHelpTitle '===.*===' contained
syntax match fexTreeHelpCmd '^"\s$\stree.*' contained

# Colors {{{1

highlight def link fexTreeWarning        WarningMsg
highlight def link fexTreeHelp           Comment
highlight def link fexTreeHelpKey        Function
highlight def link fexTreeHelpTitle      Type
highlight def link fexTreeHelpCmd        WarningMsg

highlight def link fexTreeDirectory      Directory
# TODO: Without `def link`, this kind of HGs doesn't survive a change of color scheme.
highlight          fexTreeExecutable     ctermfg=darkgreen guifg=darkgreen

highlight          fexTreeLink           ctermfg=darkmagenta guifg=darkmagenta
highlight def link fexTreeLinkFile       Normal
highlight def link fexTreeLinkDirectory  Directory
highlight          fexTreeLinkExecutable ctermfg=darkgreen guifg=darkgreen

b:current_syntax = 'fex'


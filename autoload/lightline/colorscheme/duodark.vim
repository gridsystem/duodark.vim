" [duodark.vim](https://github.com/gridsystem/duodark.vim/)

" This is a [lightline.vim](https://github.com/itchyny/lightline.vim) colorscheme for use with
" the [duodark.vim](https://github.com/gridsystem/duodark.vim) colorscheme.

let s:colors = duodark#GetColors()

let s:term_red               = s:colors.red.cterm16
let s:term_one_darker        = s:colors.one_darker.cterm16
let s:term_one               = s:colors.one.cterm16
let s:term_one_lighter       = s:colors.one_lighter.cterm16
let s:term_one_lightest      = s:colors.one_lightest.cterm16
let s:term_two_darker        = s:colors.two_darker.cterm16
let s:term_two               = s:colors.two.cterm16
let s:term_two_lighter       = s:colors.two_lighter.cterm16
let s:term_two_lightest      = s:colors.two_lightest.cterm16
let s:term_neutral_lightest  = s:colors.neutral_lightest.cterm16
let s:term_neutral_lighter   = s:colors.neutral_lighter.cterm16
let s:term_neutral_darker    = s:colors.neutral_darker.cterm16
let s:term_neutral_darkest   = s:colors.neutral_darkest.cterm16
let s:term_transparent       = s:colors.transparent.cterm16

let s:red                    = [ '#000000', s:term_red              ]
let s:one_darker             = [ '#000000', s:term_one_darker       ]
let s:one                    = [ '#000000', s:term_one              ]
let s:one_lighter            = [ '#000000', s:term_one_lighter      ]
let s:one_lightest           = [ '#000000', s:term_one_lightest     ]
let s:two_darker             = [ '#000000', s:term_two_darker       ]
let s:two                    = [ '#000000', s:term_two              ]
let s:two_lighter            = [ '#000000', s:term_two_lighter      ]
let s:two_lightest           = [ '#000000', s:term_two_lightest     ]
let s:neutral_lightest       = [ '#000000', s:term_neutral_lightest ]
let s:neutral_lighter        = [ '#000000', s:term_neutral_lighter  ]
let s:neutral_darker         = [ '#000000', s:term_neutral_darker   ]
let s:neutral_darkest        = [ '#000000', s:term_neutral_darkest  ]
let s:transparent            = [ '#000000', s:term_transparent      ]

let s:p = {
	\ 'normal': {},
	\ 'inactive': {},
	\ 'insert': {},
	\ 'replace': {},
	\ 'visual': {},
	\ 'tabline': {}
\ }

let s:p.normal.left      = [ [ s:neutral_darkest, s:one_lighter ], [ s:neutral_darkest, s:one ] ]
let s:p.normal.middle    = [ [ s:neutral_darkest, s:one_darker ] ]
let s:p.normal.right     = [ [ s:one_lightest, s:transparent ],    [ s:neutral_lightest, s:one_darker ] ]
let s:p.normal.error     = [ [ s:neutral_darkest, s:red ] ]
let s:p.normal.warning   = [ [ s:neutral_darkest, s:one ] ]

let s:p.inactive.left    = [ [ s:neutral_lightest, s:neutral_darker ],  [ s:neutral_lightest, s:neutral_darker ] ]
let s:p.inactive.middle  = [ [ s:neutral_lightest, s:transparent ] ]
let s:p.inactive.right   = [ [ s:neutral_darkest, s:neutral_lightest ], [ s:neutral_darkest, s:neutral_lightest ] ]

let s:p.insert.left      = [ [ s:neutral_darkest, s:two ], [ s:neutral_lightest, s:neutral_darker ] ]
let s:p.insert.right     = [ [ s:neutral_darkest, s:two ], [ s:neutral_lightest, s:neutral_darker ] ]

let s:p.replace.left     = [ [ s:neutral_darkest, s:red ], [ s:neutral_lightest, s:neutral_darker ] ]
let s:p.replace.right    = [ [ s:neutral_darkest, s:red ], [ s:neutral_lightest, s:neutral_darker ] ]

let s:p.visual.left      = [ [ s:neutral_darkest, s:two_lighter ], [ s:neutral_lightest, s:neutral_darker ] ]
let s:p.visual.right     = [ [ s:neutral_darkest, s:two_lighter ], [ s:neutral_lightest, s:neutral_darker ] ]

let s:p.tabline.left     = [ [ s:neutral_lightest, s:neutral_darker ] ]
let s:p.tabline.tabsel   = [ [ s:neutral_darkest, s:neutral_lightest ] ]
let s:p.tabline.middle   = [ [ s:neutral_lightest, s:neutral_darkest ] ]
let s:p.tabline.right    = [ [ s:neutral_lightest, s:neutral_darker ] ]

let g:lightline#colorscheme#duodark#palette = lightline#colorscheme#flatten(s:p)

" fix for gap between panes

highlight StatusLine   ctermbg=none
highlight StatusLineNC ctermbg=none

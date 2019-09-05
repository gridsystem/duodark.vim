" [duodark.vim](https://github.com/gridsystem/duodark.vim/)

let s:overrides = get(g:, "duodark_color_overrides", {})

let s:colors = {
	\ "transparent": get(s:overrides,       "transparent",      { "cterm16": "none" }),
	\ "neutral_darkest": get(s:overrides,   "neutral_darkest",  { "cterm16": "0" }),
	\ "neutral_darker": get(s:overrides,    "neutral_darker",   { "cterm16": "8" }),
	\ "neutral_lighter": get(s:overrides,   "neutral_lighter",  { "cterm16": "7" }),
	\ "neutral_lightest": get(s:overrides,  "light_lightest",   { "cterm16": "15" }),
	\ "red": get(s:overrides,               "red",              { "cterm16": "1" }),
	\ "red_lighter": get(s:overrides,       "red_lighter",      { "cterm16": "9" }),
	\ "green": get(s:overrides,             "green",            { "cterm16": "2" }),
	\ "green_lighter": get(s:overrides,     "green_lighter",    { "cterm16": "10" }),
	\ "one_darker": get(s:overrides,        "one_darker",       { "cterm16": "3" }),
	\ "one": get(s:overrides,               "one",              { "cterm16": "4" }),
	\ "one_lighter": get(s:overrides,       "one-lighter",      { "cterm16": "5" }),
	\ "one_lightest": get(s:overrides,      "one_lightest",     { "cterm16": "6" }),
	\ "two_darker": get(s:overrides,        "two_darker",       { "cterm16": "11" }),
	\ "two": get(s:overrides,               "two",              { "cterm16": "12" }),
	\ "two_lighter": get(s:overrides,       "two_lighter",      { "cterm16": "13" }),
	\ "two_lightest": get(s:overrides,      "two_lightest",     { "cterm16": "14" }),
\ }

function! duodark#GetColors()
  return s:colors
endfunction

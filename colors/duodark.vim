" vim:fdm=marker
" Vim Color File
" Name:       duodark.vim
" Maintainer: https://github.com/gridsystem/duodark.vim/
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim/

highlight clear

if exists("syntax_on")
	syntax reset
endif

set t_Co=256

let g:colors_name="duodark"

" Not all terminals support italics properly. If yours does, opt-in.

if !exists("g:duodark_terminal_italics")
	let g:duodark_terminal_italics = 0
endif

let s:group_colors = {} " Cache of default highlight group settings, for later reference via `duodark#extend_highlight`

function! s:h(group, style, ...)

	if (a:0 > 0) " Will be true if we got here from duodark#extend_highlight
		let s:highlight = s:group_colors[a:group]
		for style_type in ["fg", "bg", "sp"]
			if (has_key(a:style, style_type))
				let l:default_style = (has_key(s:highlight, style_type) ? s:highlight[style_type] : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
				let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
			endif
		endfor
		if (has_key(a:style, "gui"))
			let s:highlight.gui = a:style.gui
		endif
	else
		let s:highlight = a:style
		let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
	endif

	if g:duodark_terminal_italics == 0
		if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
			unlet s:highlight.cterm
		endif
	endif

	let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
	let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")

	execute "highlight" a:group
		\ "ctermfg=" . l:ctermfg
		\ "ctermbg=" . l:ctermbg
		\ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")

endfunction

" public methods

function! duodark#set_highlight(group, style)
	call s:h(a:group, a:style)
endfunction

function! duodark#extend_highlight(group, style)
	call s:h(a:group, a:style, 1)
endfunction

" color definitions

let s:colors = duodark#GetColors()

let s:transparent    = s:colors.transparent

let s:neutral_darkest   = s:colors.neutral_darkest
let s:neutral_darker    = s:colors.neutral_darker
let s:neutral_lighter   = s:colors.neutral_lighter
let s:neutral_lightest  = s:colors.neutral_lightest

let s:red               = s:colors.red
let s:red_lighter       = s:colors.red_lighter

let s:green             = s:colors.green
let s:green_lighter     = s:colors.green_lighter

let s:one_darker        = s:colors.one_darker
let s:one               = s:colors.one
let s:one_lighter       = s:colors.one_lighter
let s:one_lightest      = s:colors.one_lightest

let s:two_darker        = s:colors.two_darker
let s:two               = s:colors.two
let s:two_lighter       = s:colors.two_lighter
let s:two_lightest      = s:colors.two_lightest

" Syntax Groups (descriptions and ordering from `:h w18`)

call s:h("Comment", { "fg": s:neutral_lighter, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:one_lighter }) " any constant
call s:h("String", { "fg": s:two }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:two }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:two }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:two }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:two }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:one }) " any variable name
call s:h("Function", { "fg": s:one_lightest }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:two_darker }) " any statement
call s:h("Conditional", { "fg": s:two_darker }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:two_darker }) " for, do, while, etc.
call s:h("Label", { "fg": s:two_darker }) " case, default, etc.
call s:h("Operator", { "fg": s:two_darker }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:one_lightest }) " any other keyword
call s:h("Exception", { "fg": s:two_darker }) " try, catch, throw
call s:h("PreProc", { "fg": s:two_lighter }) " generic Preprocessor
call s:h("Include", { "fg": s:one_lightest }) " preprocessor #include
call s:h("Define", { "fg": s:two_darker }) " preprocessor #define
call s:h("Macro", { "fg": s:two_darker }) " same as Define
call s:h("PreCondit", { "fg": s:two_lighter }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:two_lighter }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:two }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:two_lighter }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:two_lighter }) " A typedef
call s:h("Special", { "fg": s:one_lightest }) " any special symbol
call s:h("SpecialChar", {}) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:neutral_darker }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:two_darker }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:neutral_lightest }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:neutral_darkest, "bg": s:one_lightest }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:neutral_lightest }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
	" Don't change the background color in diff mode
	call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
	call s:h("CursorLine", { "bg": s:neutral_lightest }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:one_lightest }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:neutral_darkest }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:two_lighter, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:neutral_darkest }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:two_lighter, "fg": s:neutral_darkest }) " diff mode: Changed text within a changed line
call s:h("EndOfBuffer", { "fg": s:neutral_darkest }) " filler lines (~) after the last line in the buffer
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:one_darker }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:neutral_darker }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:one_lighter, "bg": s:neutral_darker }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:two_darker }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", { "fg": s:two_darker, "bg": s:two_lightest }) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:one_lightest, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:neutral_darker }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:one_lightest, "bg": s:transparent }) " normal text

call s:h("Pmenu",       { "fg": s:one,              "bg": s:transparent })   " Popup menu: normal item.
call s:h("PmenuSel",    { "fg": s:neutral_darkest,  "bg": s:one_lightest })  " Popup menu: selected item.
call s:h("PmenuSbar",   { "fg": s:one,              "bg": s:transparent  })  " Popup menu: scrollbar.
call s:h("PmenuThumb",  { "fg": s:transparent,      "bg": s:one          })  " Popup menu: scrollbar draggy bit

call s:h("Question", { "fg": s:two_darker }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:neutral_darkest, "bg": s:two_lighter }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:neutral_darkest, "bg": s:two_lighter }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:neutral_lightest }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:one_darker }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:one_darker }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:one_darker }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:neutral_lighter, "bg": s:neutral_lightest }) " status line of current window
call s:h("StatusLineNC", { "fg": s:neutral_darker }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:neutral_lighter, "bg": s:neutral_lightest }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:neutral_darker }) " status line of non-current :terminal window

call s:h("TabLine", { "fg": s:one }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:one_lightest }) " tab pages line, active tab page label

call s:h("Terminal", { "fg": s:neutral_lighter, "bg": s:neutral_darkest }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:two }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:neutral_darkest, "bg": s:neutral_lighter }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:neutral_lightest }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:two_lighter }) " warning messages
call s:h("WildMenu", { "fg": s:neutral_darkest, "bg": s:one_lightest }) " current match in 'wildmenu' completion

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:neutral_lightest }) " the current position
call s:h("debugBreakpoint", { "fg": s:neutral_darkest, "bg": s:one }) " a breakpoint

" Language-Specific Highlighting {{{

" CSS
call s:h("cssAttrComma",          { "fg": s:two_darker })
call s:h("cssAttributeSelector",  { "fg": s:two })
call s:h("cssBraces",             { "fg": s:neutral_lighter })
call s:h("cssClassName",          { "fg": s:one_darker })
call s:h("cssClassNameDot",       { "fg": s:one_darker })
call s:h("cssDefinition",         { "fg": s:two_darker })
call s:h("cssFontAttr",           { "fg": s:one_darker })
call s:h("cssFontDescriptor",     { "fg": s:two_darker })
call s:h("cssFunctionName",       { "fg": s:one_lightest })
call s:h("cssIdentifier",         { "fg": s:one_lightest })
call s:h("cssImportant",          { "fg": s:two_darker })
call s:h("cssInclude",            { "fg": s:neutral_lighter })
call s:h("cssIncludeKeyword",     { "fg": s:two_darker })
call s:h("cssMediaType",          { "fg": s:one_darker })
call s:h("cssProp",               { "fg": s:two })
call s:h("cssPseudoClassId",      { "fg": s:one_darker })
call s:h("cssSelectorOp",         { "fg": s:two_darker })
call s:h("cssSelectorOp2",        { "fg": s:two_darker })
call s:h("cssTagName",            { "fg": s:one })
call s:h("cssValueNumber",        { "fg": s:one })
" for css variables
call s:h("cssCustomProp",         { "fg": s:one })

" Fish Shell
call s:h("fishKeyword", { "fg": s:two_darker })
call s:h("fishConditional", { "fg": s:two_darker })

" Go
call s:h("goDeclaration", { "fg": s:two_darker })
call s:h("goBuiltins", { "fg": s:one_lighter })
call s:h("goFunctionCall", { "fg": s:one_lightest })
call s:h("goVarDefs", { "fg": s:one })
call s:h("goVarAssign", { "fg": s:one })
call s:h("goVar", { "fg": s:two_darker })
call s:h("goConst", { "fg": s:two_darker })
call s:h("goType", { "fg": s:two_lighter })
call s:h("goTypeName", { "fg": s:two_lighter })
call s:h("goDeclType", { "fg": s:one_lighter })
call s:h("goTypeDecl", { "fg": s:two_darker })

" HTML
call s:h("htmlTitle", { "fg": s:neutral_lighter })
call s:h("htmlArg", { "fg": s:one_darker })
call s:h("htmlEndTag", { "fg": s:neutral_lighter })
call s:h("htmlH1", { "fg": s:neutral_lighter })
call s:h("htmlLink", { "fg": s:two_darker })
call s:h("htmlSpecialChar", { "fg": s:one_darker })
call s:h("htmlSpecialTagName", { "fg": s:one })
call s:h("htmlTag", { "fg": s:neutral_lighter })
call s:h("htmlTagName", { "fg": s:one })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:neutral_lighter })
call s:h("javaScriptFunction", { "fg": s:two_darker })
call s:h("javaScriptIdentifier", { "fg": s:two_darker })
call s:h("javaScriptNull", { "fg": s:one_darker })
call s:h("javaScriptNumber", { "fg": s:one_darker })
call s:h("javaScriptRequire", { "fg": s:one_lighter })
call s:h("javaScriptReserved", { "fg": s:two_darker })
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:two_darker })
call s:h("jsClassKeyword", { "fg": s:two_darker })
call s:h("jsClassMethodType", { "fg": s:two_darker })
call s:h("jsDocParam", { "fg": s:one_lightest })
call s:h("jsDocTags", { "fg": s:two_darker })
call s:h("jsExport", { "fg": s:two_darker })
call s:h("jsExportDefault", { "fg": s:two_darker })
call s:h("jsExtendsKeyword", { "fg": s:two_darker })
call s:h("jsFrom", { "fg": s:one_lighter })
call s:h("jsFuncCall", { "fg": s:one_lightest })
call s:h("jsFunction", { "fg": s:two_darker })
call s:h("jsGenerator", { "fg": s:two_lighter })
call s:h("jsGlobalObjects", { "fg": s:two_lighter })
call s:h("jsImport", { "fg": s:one_lighter })
call s:h("jsModuleAs", { "fg": s:two_darker })
call s:h("jsModuleWords", { "fg": s:two })
call s:h("jsModuleKeyword", { "fg": s:two })
call s:h("jsModules", { "fg": s:two_darker })
call s:h("jsNull", { "fg": s:one_darker })
call s:h("jsOperator", { "fg": s:two_darker })
call s:h("jsStorageClass", { "fg": s:two_darker })
call s:h("jsSuper", { "fg": s:one_lightest })
call s:h("jsTemplateBraces", { "fg": s:one_darker })
call s:h("jsTemplateVar", { "fg": s:two })
call s:h("jsThis", { "fg": s:one_lightest })
call s:h("jsUndefined", { "fg": s:one_darker })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:two_darker })
call s:h("javascriptClassExtends", { "fg": s:two_darker })
call s:h("javascriptClassKeyword", { "fg": s:two_darker })
call s:h("javascriptDocNotation", { "fg": s:two_darker })
call s:h("javascriptDocParamName", { "fg": s:one_lightest })
call s:h("javascriptDocTags", { "fg": s:two_darker })
call s:h("javascriptEndColons", { "fg": s:neutral_lighter })
call s:h("javascriptExport", { "fg": s:two_darker })
call s:h("javascriptFuncArg", { "fg": s:neutral_lighter })
call s:h("javascriptFuncKeyword", { "fg": s:two_darker })
call s:h("javascriptIdentifier", { "fg": s:one_lightest })
call s:h("javascriptImport", { "fg": s:two_darker })
call s:h("javascriptMethodName", { "fg": s:neutral_lighter })
call s:h("javascriptObjectLabel", { "fg": s:neutral_lighter })
call s:h("javascriptOpSymbol", { "fg": s:one_lighter })
call s:h("javascriptOpSymbols", { "fg": s:one_lighter })
call s:h("javascriptPropertyName", { "fg": s:two })
call s:h("javascriptTemplateSB", { "fg": s:one_darker })
call s:h("javascriptVariable", { "fg": s:two_darker })

" JSON
call s:h("jsonCommentError", { "fg": s:neutral_lighter })
call s:h("jsonKeyword", { "fg": s:one })
call s:h("jsonBoolean", { "fg": s:one_darker })
call s:h("jsonNumber", { "fg": s:one_darker })
call s:h("jsonQuote", { "fg": s:neutral_lighter })
call s:h("jsonMissingCommaError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:two })
call s:h("jsonStringSQError", { "fg": s:red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:red, "gui": "reverse" })

" LESS
call s:h("lessVariable", { "fg": s:two_darker })
call s:h("lessAmpersandChar", { "fg": s:neutral_lighter })
call s:h("lessClass", { "fg": s:one_darker })

" Markdown
call s:h("markdownCode", { "fg": s:two })
call s:h("markdownCodeBlock", { "fg": s:two })
call s:h("markdownCodeDelimiter", { "fg": s:two })
call s:h("markdownHeadingDelimiter", { "fg": s:one })
call s:h("markdownRule", { "fg": s:neutral_darker })
call s:h("markdownHeadingRule", { "fg": s:neutral_darker })
call s:h("markdownH1", { "fg": s:one })
call s:h("markdownH2", { "fg": s:one })
call s:h("markdownH3", { "fg": s:one })
call s:h("markdownH4", { "fg": s:one })
call s:h("markdownH5", { "fg": s:one })
call s:h("markdownH6", { "fg": s:one })
call s:h("markdownIdDelimiter", { "fg": s:two_darker })
call s:h("markdownId", { "fg": s:two_darker })
call s:h("markdownBlockquote", { "fg": s:neutral_darker })
call s:h("markdownItalic", { "fg": s:two_darker, "gui": "italic", "cterm": "italic" })
call s:h("markdownBold", { "fg": s:one_darker, "gui": "bold", "cterm": "bold" })
call s:h("markdownListMarker", { "fg": s:one })
call s:h("markdownOrderedListMarker", { "fg": s:one })
call s:h("markdownIdDeclaration", { "fg": s:one_lightest })
call s:h("markdownLinkText", { "fg": s:one_lightest })
call s:h("markdownLinkDelimiter", { "fg": s:neutral_lighter })
call s:h("markdownUrl", { "fg": s:two_darker })

" Perl
call s:h("perlFiledescRead", { "fg": s:two })
call s:h("perlFunction", { "fg": s:two_darker })
call s:h("perlMatchStartEnd",{ "fg": s:one_lightest })
call s:h("perlMethod", { "fg": s:two_darker })
call s:h("perlPOD", { "fg": s:neutral_darker })
call s:h("perlSharpBang", { "fg": s:neutral_darker })
call s:h("perlSpecialString",{ "fg": s:one_lighter })
call s:h("perlStatementFiledesc", { "fg": s:one })
call s:h("perlStatementFlow",{ "fg": s:one })
call s:h("perlStatementInclude", { "fg": s:two_darker })
call s:h("perlStatementScalar",{ "fg": s:two_darker })
call s:h("perlStatementStorage", { "fg": s:two_darker })
call s:h("perlSubName",{ "fg": s:two_lighter })
call s:h("perlVarPlain",{ "fg": s:one_lightest })

" PHP
call s:h("phpVarSelector", { "fg": s:one })
call s:h("phpOperator", { "fg": s:neutral_lighter })
call s:h("phpParent", { "fg": s:neutral_lighter })
call s:h("phpMemberSelector", { "fg": s:neutral_lighter })
call s:h("phpType", { "fg": s:two_darker })
call s:h("phpKeyword", { "fg": s:two_darker })
call s:h("phpClass", { "fg": s:two_lighter })
call s:h("phpUseClass", { "fg": s:neutral_lighter })
call s:h("phpUseAlias", { "fg": s:neutral_lighter })
call s:h("phpInclude", { "fg": s:two_darker })
call s:h("phpClassExtends", { "fg": s:two })
call s:h("phpDocTags", { "fg": s:neutral_lighter })
call s:h("phpFunction", { "fg": s:one_lightest })
call s:h("phpFunctions", { "fg": s:one_lighter })
call s:h("phpMethodsVar", { "fg": s:one_darker })
call s:h("phpMagicConstants", { "fg": s:one_darker })
call s:h("phpSuperglobals", { "fg": s:one })
call s:h("phpConstants", { "fg": s:one_darker })

" Ruby
call s:h("rubyBlockParameter", { "fg": s:one})
call s:h("rubyBlockParameterList", { "fg": s:one })
call s:h("rubyClass", { "fg": s:two_darker})
call s:h("rubyConstant", { "fg": s:two_lighter})
call s:h("rubyControl", { "fg": s:two_darker })
call s:h("rubyEscape", { "fg": s:one})
call s:h("rubyFunction", { "fg": s:one_lightest})
call s:h("rubyGlobalVariable", { "fg": s:one})
call s:h("rubyInclude", { "fg": s:one_lightest})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:one})
call s:h("rubyInstanceVariable", { "fg": s:one})
call s:h("rubyInterpolation", { "fg": s:one_lighter })
call s:h("rubyInterpolationDelimiter", { "fg": s:one })
call s:h("rubyInterpolationDelimiter", { "fg": s:one})
call s:h("rubyRegexp", { "fg": s:one_lighter})
call s:h("rubyRegexpDelimiter", { "fg": s:one_lighter})
call s:h("rubyStringDelimiter", { "fg": s:two})
call s:h("rubySymbol", { "fg": s:one_lighter})

" Sass
" https://github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:one })
call s:h("sassClass", { "fg": s:one_darker })
call s:h("sassControl", { "fg": s:two_darker })
call s:h("sassExtend", { "fg": s:two_darker })
call s:h("sassFor", { "fg": s:neutral_lighter })
call s:h("sassFunction", { "fg": s:one_lighter })
call s:h("sassId", { "fg": s:one_lightest })
call s:h("sassInclude", { "fg": s:two_darker })
call s:h("sassMedia", { "fg": s:two_darker })
call s:h("sassMediaOperators", { "fg": s:neutral_lighter })
call s:h("sassMixin", { "fg": s:two_darker })
call s:h("sassMixinName", { "fg": s:one_lightest })
call s:h("sassMixing", { "fg": s:two_darker })
call s:h("sassVariable", { "fg": s:two_darker })
" https://github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:two_darker })
call s:h("scssImport", { "fg": s:two_darker })
call s:h("scssInclude", { "fg": s:two_darker })
call s:h("scssMixin", { "fg": s:two_darker })
call s:h("scssSelectorName", { "fg": s:one_darker })
call s:h("scssVariable", { "fg": s:two_darker })

" TeX
call s:h("texStatement", { "fg": s:two_darker })
call s:h("texSubscripts", { "fg": s:one_darker })
call s:h("texSuperscripts", { "fg": s:one_darker })
call s:h("texTodo", { "fg": s:one_darker })
call s:h("texBeginEnd", { "fg": s:two_darker })
call s:h("texBeginEndName", { "fg": s:one_lightest })
call s:h("texMathMatcher", { "fg": s:one_lightest })
call s:h("texMathDelim", { "fg": s:one_lightest })
call s:h("texDelimiter", { "fg": s:one_darker })
call s:h("texSpecialChar", { "fg": s:one_darker })
call s:h("texCite", { "fg": s:one_lightest })
call s:h("texRefZone", { "fg": s:one_lightest })

" TypeScript
call s:h("typescriptReserved", { "fg": s:two_darker })
call s:h("typescriptEndColons", { "fg": s:neutral_lighter })
call s:h("typescriptBraces", { "fg": s:neutral_lighter })

" XML
call s:h("xmlAttrib", { "fg": s:one_darker })
call s:h("xmlEndTag", { "fg": s:one })
call s:h("xmlTag", { "fg": s:one })
call s:h("xmlTagName", { "fg": s:one })

" Plugin Highlighting {{{

" airblade/vim-gitgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:one, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:two_lighter, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:one_darker, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:neutral_darker })

" mhinz/vim-signify
call s:h("SignifySignAdd", { "fg": s:green })
call s:h("SignifySignChange", { "fg": s:two_lighter })
call s:h("SignifySignDelete", { "fg": s:red })

" neomake/neomake
call s:h("NeomakeWarningSign", { "fg": s:two_lighter })
call s:h("NeomakeErrorSign", { "fg": s:red })
call s:h("NeomakeInfoSign", { "fg": s:one_lightest })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" neoclide/coc.nvim
"
call s:h("CocErrorHighlight", { "fg": s:red, "cterm": "underline" })
call s:h("CocUnusedHighlight", { "fg": s:red, "cterm": "underline" })

" Git Highlighting

call s:h("gitcommitComment", { "fg": s:neutral_darker })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:two_darker })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:one_lighter })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:two_lighter })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:neutral_lighter })
call s:h("gitcommitOverflow", { "fg": s:red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark

"""
" Name: Untitled.vim
"""

set background=dark
hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='Untitled'
set t_Co=256


" javascript

hi javaScriptLineComment      guisp=NONE guifg=#c7c736 guibg=#1c1c1c ctermfg=185 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptCommentSkip      guisp=NONE guifg=#eb8526 guibg=#1c1c1c ctermfg=208 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptComment          guisp=NONE guifg=#edadad guibg=#1c1c1c ctermfg=217 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptSpecial          guisp=NONE guifg=#38462a guibg=#1c1c1c ctermfg=237 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptStringD          guisp=NONE guifg=#ff243e guibg=#1c1c1c ctermfg=197 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptStringS          guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptStringT          guisp=NONE guifg=#000087 guibg=#1c1c1c ctermfg=18  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptEmbed            guisp=NONE guifg=#00d787 guibg=#1c1c1c ctermfg=42  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptSpecialCharacter guisp=NONE guifg=#5f5f5f guibg=#1c1c1c ctermfg=59  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptNumber           guisp=NONE guifg=#00ff00 guibg=#1c1c1c ctermfg=46  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptRegexpString     guisp=NONE guifg=#0000af guibg=#1c1c1c ctermfg=19  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptFunction         guisp=NONE guifg=#721a29 guibg=#1c1c1c ctermfg=52  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptFunctionFold     guisp=NONE guifg=#721a29 guibg=#1c1c1c ctermfg=52  ctermbg=234 gui=bold,italic cterm=bold,italic
hi javaScriptBraces           guisp=NONE guifg=#ff5faf guibg=#1c1c1c ctermfg=205 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptParens           guisp=NONE guifg=#ff5faf guibg=#1c1c1c ctermfg=205 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptCommentTodo      guisp=NONE guifg=#c7c736 guibg=#1c1c1c ctermfg=185 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptCharacter        guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptConditional      guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=bold,italic cterm=bold,italic
hi javaScriptRepeat           guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=bold,italic cterm=bold,italic
hi javaScriptBranch           guisp=NONE guifg=#1de01d guibg=#1c1c1c ctermfg=40  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptOperator         guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=bold,italic cterm=bold,italic
hi javaScriptType             guisp=NONE guifg=#a2b0a2 guibg=#1c1c1c ctermfg=248 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptStatement        guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=italic      cterm=italic
hi javaScriptError            guisp=NONE guifg=#ff5f00 guibg=#1c1c1c ctermfg=202 ctermbg=234 gui=NONE        cterm=NONE
hi javaScrParenError          guisp=NONE guifg=#ff5f00 guibg=#1c1c1c ctermfg=202 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptNull             guisp=NONE guifg=#0087d8 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptBoolean          guisp=NONE guifg=#00ff00 guibg=#1c1c1c ctermfg=46  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptIdentifier       guisp=NONE guifg=#5f5f5f guibg=#1c1c1c ctermfg=59  ctermbg=234 gui=bold,italic cterm=bold,italic
hi javaScriptLabel            guisp=NONE guifg=#721a29 guibg=#1c1c1c ctermfg=52  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptException        guisp=NONE guifg=#d7af00 guibg=#1c1c1c ctermfg=178 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptMessage          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptGlobal           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptMember           guisp=NONE guif=#5fff5f guibg=#1c1c1c ctermfg=83  ctermbg=234 gui=bold        cterm=bold
hi javaScriptDeprecated       guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptReserved         guisp=NONE guifg=#d7d7ff guibg=#1c1c1c ctermfg=189 ctermbg=234 gui=bold,italic cterm=bold,italic
hi javaScriptDebug            guisp=NONE guifg=#5faf00 guibg=#1c1c1c ctermfg=70  ctermbg=234 gui=NONE        cterm=NONE
hi javaScriptConstant         guisp=NONE guifg=#ffff87 guibg=#1c1c1c ctermfg=228 ctermbg=234 gui=NONE        cterm=NONE

" misc

hi ColorColumn      guisp=NONE guifg=#5faf87 guibg=#1c1c1c ctermfg=72  ctermbg=234 gui=NONE cterm=NONE
hi Conceal          guisp=NONE guifg=#808000 guibg=#1c1c1c ctermfg=100 ctermbg=234 gui=NONE cterm=NONE
hi Cursor           guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi lCursor          guisp=NONE guifg=#fba721 guibg=#1c1c1c ctermfg=214 ctermbg=234 gui=NONE cterm=NONE
hi CursorIM         guisp=NONE guifg=#808080 guibg=#1c1c1c ctermfg=244 ctermbg=234 gui=NONE cterm=NONE
hi CursorColumn     guisp=NONE guifg=#808080 guibg=#1c1c1c ctermfg=244 ctermbg=234 gui=NONE cterm=NONE
hi CursorLine       guisp=NONE guifg=#808080 guibg=#1c1c1c ctermfg=244 ctermbg=234 gui=NONE cterm=NONE
hi Directory        guisp=NONE guifg=#008000 guibg=#1c1c1c ctermfg=28  ctermbg=234 gui=NONE cterm=NONE
hi DiffAdd          guisp=NONE guifg=#00afaf guibg=#1c1c1c ctermfg=37  ctermbg=234 gui=NONE cterm=NONE
hi DiffChange       guisp=NONE guifg=#808000 guibg=#1c1c1c ctermfg=100 ctermbg=234 gui=NONE cterm=NONE
hi DiffDelete       guisp=NONE guifg=#ffaf87 guibg=#1c1c1c ctermfg=216 ctermbg=234 gui=NONE cterm=NONE
hi DiffText         guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi EndOfBuffer      guisp=NONE guifg=#800000 guibg=#1c1c1c ctermfg=88  ctermbg=234 gui=NONE cterm=NONE
hi ErrorMsg         guisp=NONE guifg=#ff0000 guibg=#1c1c1c ctermfg=196 ctermbg=234 gui=NONE cterm=NONE
hi VertSplit        guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=NONE cterm=NONE
hi Folded           guisp=NONE guifg=#5f00ff guibg=#1c1c1c ctermfg=57  ctermbg=234 gui=NONE cterm=NONE
hi FoldColumn       guisp=NONE guifg=#ffff00 guibg=#1c1c1c ctermfg=226 ctermbg=234 gui=NONE cterm=NONE
hi SignColumn       guisp=NONE guifg=#ffff00 guibg=#1c1c1c ctermfg=226 ctermbg=234 gui=NONE cterm=NONE
hi IncSearch        guisp=NONE guifg=#008000 guibg=#1c1c1c ctermfg=28  ctermbg=234 gui=NONE cterm=NONE
hi LineNr           guisp=NONE guifg=#ffd7ff guibg=#1c1c1c ctermfg=225 ctermbg=234 gui=NONE cterm=NONE
hi LineNrAbove      guisp=NONE guifg=#5fafff guibg=#1c1c1c ctermfg=75  ctermbg=234 gui=NONE cterm=NONE
hi LineNrBelow      guisp=NONE guifg=#00afff guibg=#1c1c1c ctermfg=39  ctermbg=234 gui=NONE cterm=NONE
hi CursorLineNr     guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=NONE cterm=NONE
hi MatchParen       guisp=NONE guifg=#000087 guibg=#1c1c1c ctermfg=18  ctermbg=234 gui=NONE cterm=NONE
hi ModeMsg          guisp=NONE guifg=#0087d7 guibg=#1c1c1c ctermfg=32  ctermbg=234 gui=NONE cterm=NONE
hi MoreMsg          guisp=NONE guifg=#0000ff guibg=#1c1c1c ctermfg=21  ctermbg=234 gui=NONE cterm=NONE
hi NonText          guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi Pmenu            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE cterm=NONE
hi PmenuSel         guisp=NONE guifg=#5f0000 guibg=#1c1c1c ctermfg=52  ctermbg=234 gui=NONE cterm=NONE
hi PmenuSbar        guisp=NONE guifg=#d7d7d7 guibg=#1c1c1c ctermfg=188 ctermbg=234 gui=NONE cterm=NONE
hi PmenuThumb       guisp=NONE guifg=#8787d7 guibg=#1c1c1c ctermfg=104 ctermbg=234 gui=NONE cterm=NONE
hi Question         guisp=NONE guifg=#00af5f guibg=#1c1c1c ctermfg=35  ctermbg=234 gui=NONE cterm=NONE
hi QuickFixLine     guisp=NONE guifg=#00d700 guibg=#1c1c1c ctermfg=40  ctermbg=234 gui=NONE cterm=NONE
hi Search           guisp=NONE guifg=#d7ff00 guibg=#1c1c1c ctermfg=190 ctermbg=234 gui=NONE cterm=NONE
hi SpecialKey       guisp=NONE guifg=#d7ff00 guibg=#1c1c1c ctermfg=190 ctermbg=234 gui=NONE cterm=NONE
hi SpellBad         guisp=NONE guifg=#800000 guibg=#1c1c1c ctermfg=88  ctermbg=234 gui=NONE cterm=NONE
hi SpellCap         guisp=NONE guifg=#800000 guibg=#1c1c1c ctermfg=88  ctermbg=234 gui=NONE cterm=NONE
hi SpellLocal       guisp=NONE guifg=#800000 guibg=#1c1c1c ctermfg=88  ctermbg=234 gui=NONE cterm=NONE
hi SpellRare        guisp=NONE guifg=#808000 guibg=#1c1c1c ctermfg=100 ctermbg=234 gui=NONE cterm=NONE
hi StatusLine       guisp=NONE guifg=#808080 guibg=#1c1c1c ctermfg=244 ctermbg=234 gui=NONE cterm=NONE
hi StatusLineNC     guisp=NONE guifg=#808080 guibg=#1c1c1c ctermfg=244 ctermbg=234 gui=NONE cterm=NONE
hi StatusLineTerm   guisp=NONE guifg=#00d700 guibg=#1c1c1c ctermfg=40  ctermbg=234 gui=NONE cterm=NONE
hi StatusLineTermNC guisp=NONE guifg=#00d700 guibg=#1c1c1c ctermfg=40  ctermbg=234 gui=NONE cterm=NONE
hi TabLine          guisp=NONE guifg=#800000 guibg=#1c1c1c ctermfg=88  ctermbg=234 gui=NONE cterm=NONE
hi TabLineFill      guisp=NONE guifg=#008000 guibg=#1c1c1c ctermfg=28  ctermbg=234 gui=NONE cterm=NONE
hi TabLineSel       guisp=NONE guifg=#c0c0c0 guibg=#1c1c1c ctermfg=250 ctermbg=234 gui=NONE cterm=NONE
hi Terminal         guisp=NONE guifg=#87d700 guibg=#1c1c1c ctermfg=112 ctermbg=234 gui=NONE cterm=NONE
hi Title            guisp=NONE guifg=#ffaf00 guibg=#1c1c1c ctermfg=214 ctermbg=234 gui=NONE cterm=NONE
hi Visual           guisp=NONE guifg=#5f0087 guibg=#1c1c1c ctermfg=54  ctermbg=234 gui=NONE cterm=NONE
hi VisualNOS        guisp=NONE guifg=#d75fd7 guibg=#1c1c1c ctermfg=170 ctermbg=234 gui=NONE cterm=NONE
hi WarningMsg       guisp=NONE guifg=#ffd7d7 guibg=#1c1c1c ctermfg=224 ctermbg=234 gui=NONE cterm=NONE
hi WildMenu         guisp=NONE guifg=#ffd7d7 guibg=#1c1c1c ctermfg=224 ctermbg=234 gui=NONE cterm=NONE

" major

hi Normal     guisp=NONE guifg=#fafafa guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi Comment    guisp=NONE guifg=#edadad guibg=#1c1c1c ctermfg=217 ctermbg=234 gui=NONE        cterm=NONE
hi Constant   guisp=NONE guifg=#00ff00 guibg=#1c1c1c ctermfg=46  ctermbg=234 gui=NONE        cterm=NONE
hi Identifier guisp=NONE guifg=#a2bfa2 guibg=#1c1c1c ctermfg=145 ctermbg=234 gui=bold,italic cterm=bold,italic
hi Statement  guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=bold,italic cterm=bold,italic
hi PreProc    guisp=NONE guifg=#d7af00 guibg=#1c1c1c ctermfg=178 ctermbg=234 gui=NONE        cterm=NONE
hi Type       guisp=NONE guifg=#00d700 guibg=#1c1c1c ctermfg=40  ctermbg=234 gui=NONE        cterm=NONE
hi Special    guisp=NONE guifg=#00d75f guibg=#1c1c1c ctermfg=41  ctermbg=234 gui=bold,italic cterm=bold,italic
hi Underlined guisp=NONE guifg=#276927 guibg=#1c1c1c ctermfg=237 ctermbg=234 gui=NONE        cterm=NONE
hi Ignore     guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi Error      guisp=NONE guifg=#f20707 guibg=#1c1c1c ctermfg=196 ctermbg=234 gui=NONE        cterm=NONE
hi Todo       guisp=NONE guifg=#008000 guibg=#1c1c1c ctermfg=28  ctermbg=234 gui=NONE        cterm=NONE

" minor

hi String         guisp=NONE guifg=#000087 guibg=#1c1c1c ctermfg=18  ctermbg=234 gui=NONE        cterm=NONE
hi Character      guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=NONE        cterm=NONE
hi Number         guisp=NONE guifg=#00af00 guibg=#1c1c1c ctermfg=34  ctermbg=234 gui=NONE        cterm=NONE
hi Boolean        guisp=NONE guifg=#00af00 guibg=#1c1c1c ctermfg=34  ctermbg=234 gui=NONE        cterm=NONE
hi Float          guisp=NONE guifg=#00af00 guibg=#1c1c1c ctermfg=34  ctermbg=234 gui=NONE        cterm=NONE
hi Function       guisp=NONE guifg=#721a29 guibg=#1c1c1c ctermfg=52  ctermbg=234 gui=NONE        cterm=NONE
hi Conditional    guisp=NONE guifg=#008080 guibg=#1c1c1c ctermfg=30  ctermbg=234 gui=NONE        cterm=NONE
hi Repeat         guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=NONE        cterm=NONE
hi Label          guisp=NONE guifg=#871a22 guibg=#1c1c1c ctermfg=88  ctermbg=234 gui=NONE        cterm=NONE
hi Operator       guisp=NONE guifg=#875fff guibg=#1c1c1c ctermfg=99  ctermbg=234 gui=NONE        cterm=NONE
hi Keyword        guisp=NONE guifg=#24ad7b guibg=#1c1c1c ctermfg=36  ctermbg=234 gui=bold,italic cterm=bold,italic
hi Exception      guisp=NONE guifg=#d7af00 guibg=#1c1c1c ctermfg=178 ctermbg=234 gui=NONE        cterm=NONE
hi Include        guisp=NONE guifg=#0087af guibg=#1c1c1c ctermfg=31  ctermbg=234 gui=NONE        cterm=NONE
hi Define         guisp=NONE guifg=#ffaf87 guibg=#1c1c1c ctermfg=216 ctermbg=234 gui=NONE        cterm=NONE
hi Macro          guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=NONE        cterm=NONE
hi PreCondit      guisp=NONE guifg=#00afd7 guibg=#1c1c1c ctermfg=38  ctermbg=234 gui=NONE        cterm=NONE
hi StorageClass   guisp=NONE guifg=#721a29 guibg=#1c1c1c ctermfg=52  ctermbg=234 gui=NONE        cterm=NONE
hi Structure      guisp=NONE guifg=#5f00ff guibg=#1c1c1c ctermfg=57  ctermbg=234 gui=NONE        cterm=NONE
hi Typedef        guisp=NONE guifg=#0000d7 guibg=#1c1c1c ctermfg=20  ctermbg=234 gui=bold,italic cterm=bold,italic
hi SpecialChar    guisp=NONE guifg=#5f5f5f guibg=#1c1c1c ctermfg=59  ctermbg=234 gui=NONE        cterm=NONE
hi Tag            guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi Delimiter      guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi SpecialComment guisp=NONE guifg=#ffffff guibg=#1c1c1c ctermfg=231 ctermbg=234 gui=NONE        cterm=NONE
hi Debug          guisp=NONE guifg=#5faf00 guibg=#1c1c1c ctermfg=70  ctermbg=234 gui=NONE        cterm=NONE


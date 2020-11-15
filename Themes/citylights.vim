" Name:     Citylights vim colorscheme
" Author:   Jeff Heaton <jeff@jgheaton.com>
"           (adapted from Yummygum's citylights <citylights.xyz>)
" URL:      http://github.com/saltdotac/citylights.vim
" License:  OSI approved MIT license (see end of this file)
" Created:  In neon dreams
" Modified: 2020 May 30
"
" ---------------------------------------------------------------------
" COLOR VALUES
" ---------------------------------------------------------------------
" Hex values are canonical because it's what's provided by YG. The VSCode
" version of the colorscheme provides 8 terminal colors, a terminal bg and fg,
" and an additional 24 colors across the app (for a total of 34 colors). I have
" selected from the additional colors to fill out 16 ANSI colors for a
" 256-color environment, but 24-bit color is what the authors had in mind.
"
" You can use the following table to fill out your terminal settings:
"
" CITYLIGHTS HEX      XTERM/HEX    X11 Name             
" ---------- -------  -----------  ---------------------
" black      #171d23  235 #262626  Grey15               
" brblack    #41505e  239 #708090  SlateGray            
" white      #b7c5d3  254 #b0c4de  LightSteelBlue       
" brwhite    #ffffff  244 #ffffff  White                
" cyan       #008b94   30 #008787  Turquoise4           
" brcyan     #70e1e8   80 #5fd7d7  MediumTurquoise      
" blue       #539afc   69 #5f87ff  CornflowerBlue       
" brblue     #5ec4ff   81 #87cefa  LightSkyBlue         
" red        #ee3a43    9 #ff0000  Red                  
" brred      #d95468  211 #ff87af  PaleVioletRed1       
" magenta    #b62d65  125 #af005f  DeepPink4            
" brmagenta  #e27e8d  204 #db7093  PaleVioletRed        
" yellow     #d98e48  172 #cd853f  Peru/Orange3         
" bryellow   #ebbf83  180 #deb887  BurlyWood/Tan        
" green      #8bd49c  119 #90ee90  LightGreen           
" brgreen    #3ad900   82 #7cfc00  LawnGreen/Chartreuse2

" Colorscheme initialization
" " ---------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "citylights"

" GUI hexadecimal palettes
" ---------------------------------------------------------------------
"
" Neovim terminal colours
if has("nvim")
  let g:terminal_color_0 =  "#1D252C" " black
  let g:terminal_color_1 =  "#D95468" " red
  let g:terminal_color_2 =  "#8BD49C" " green
  let g:terminal_color_3 =  "#D98E48" " orangelt
  let g:terminal_color_4 =  "#539AFC" " blue
  let g:terminal_color_5 =  "#B62D65" " reddk
  let g:terminal_color_6 =  "#008B94" " cyan
  let g:terminal_color_7 =  "#718CA1" " white
  let g:terminal_color_8 =  "#333F4A" " brblack
  let g:terminal_color_9 =  "#D95468" " brred
  let g:terminal_color_10 = "#8BD49C" " brgreen
  let g:terminal_color_11 = "#EBBF83" " brorangelt
  let g:terminal_color_12 = "#5EC4FF" " brblue
  let g:terminal_color_13 = "#B62D65" " brreddk
  let g:terminal_color_14 = "#70E1E8" " brcyan
  let g:terminal_color_15 = "#B7C5D3" " brwhite
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_15
  if &background == "light"
    let g:terminal_color_background = g:terminal_color_15
    let g:terminal_color_foreground = g:terminal_color_8
  endif
elseif has('terminal')
  let g:terminal_ansi_colors = [
        \"#1D252C",
        \"#D95468",
        \"#8BD49C",
        \"#D98E48",
        \"#539AFC",
        \"#B62D65",
        \"#008B94",
        \"#718CA1",
        \"#333F4A",
        \"#D95468",
        \"#8BD49C",
        \"#EBBF83",
        \"#5EC4FF",
        \"#B62D65",
        \"#70E1E8",
        \"#B7C5D3",
        \ ]
endif

" Prefer neovim termguicolors, but support gui_running
if (has('termguicolors') && &termguicolors) || has('gui_running')

" Basic highlighting"{{{
" ---------------------------------------------------------------------
" note that link syntax, to avoid duplicate configuration, doesn't work with the
" exe compiled formats

hi! Normal         guifg=#B7C5D3 guibg=#1D252C

hi! Comment        gui=italic guifg=#41505E guibg=None
"   *Comment       any comment

hi! Constant       guifg=#e27e8d guibg=None
"   *Constant        this groups is overwritten by type
"    Character       a character constant: 'c', '\n'
"    Number          a number constant: 234, 0xff
"    Boolean         a boolean constant: TRUE, false
"    Float           a floating point constant: 2.3e10

hi! String         guifg=#68A1F0 guibg=None
"   String          a string constant: "this is a string"

hi! Identifier     guifg=#718CA1 guibg=None
"   *Identifier      any variable name
"
hi! Function       guifg=#70E1E8 guibg=None
"    Function        function name (also: methods for classes)
"
hi! Statement      guifg=#5ec4ff guibg=None
"   *Statement       any statement
"    Conditional     if, then, else, endif, switch, etc.
"    Repeat          for, do, while, etc.
"    Label           case, default, etc.
"    Operator        "sizeof", "+", "*", etc.
"    Keyword         any other keyword
"    Exception       try, catch, throw

" VSCode citylights appears to make no reference to preproc
hi! PreProc        guifg=#5ec4ff guibg=None
"   *PreProc         generic Preprocessor
"    Include         preprocessor #include
"    Define          preprocessor #define
"    Macro           same as Define
"    PreCondit       preprocessor #if, #else, #endif, etc.

hi! Type           guifg=#008B94 guibg=None
"   *Type            int, long, char, etc.
"    StorageClass    static, register, volatile, etc.
"    Structure       struct, union, enum, etc.
"    Typedef         A typedef

hi! Special       guifg=#718CA1 guibg=None
"   *Special         any special symbol
"    SpecialChar     special character in a constant
"    Tag             you can use CTRL-] on this
"    Delimiter       character that needs attention
"    SpecialComment  special things inside a comment
"    Debug           debugging statements

hi! Underlined     gui=underline guifg=#539afc guibg=None
"   *Underlined      text that stands out, HTML links

hi! Ignore         gui=None guifg=None guibg=None
"   *Ignore          left blank, hidden  |hl-Ignore|

hi! Error          gui=undercurl guifg=#e27e8d guibg=None
"   *Error           any erroneous construct

hi! Todo           gui=None guifg=None guibg=None
"   *Todo            anything that needs extra attention; mostly the
"                    keywords TODO FIXME and XXX
"
"}}}

" Extended highlighting "{{{
" ---------------------------------------------------------------------
"  TODO Improve diff settings
"  TODO Add linenr gutter border
"hi! ColorColumn    .s:fmt_none   .s:fg_none   .s:bg_base02
"hi! Conceal        .s:fmt_none   .s:fg_blue   .s:bg_none
hi! Cursor         guifg=#953B01 guibg=#77c3fa
hi! link iCursor Cursor
hi! link lCursor Cursor
"hi! CursorColumn   .s:fmt_none   .s:fg_none   .s:bg_base02
hi! CursorLine     guifg=None guibg=#28313a
hi! CursorLineNR   gui=None guifg=#41505e guibg=None
hi! DiffAdd        guifg=None guibg=#2A462C
hi! link DiffChange DiffAdd
hi! DiffDelete     guifg=None guibg=#562D32
"hi! DiffText       .s:fmt_bold   .s:fg_base01  .s:bg_none
"hi! Directory      .s:fmt_none   .s:fg_green  .s:bg_none
hi! ErrorMsg       gui=None guifg=#e27e8d guibg=None
hi! EndOfBuffer    gui=None guifg=#1D252C guibg=None
"hi! FoldColumn     .s:fmt_none   .s:fg_base0   .s:bg_base02
"hi! Folded         .s:fmt_undb   .s:fg_base01  .s:bg_base02  .s:sp_base03
hi! IncSearch      gui=None guifg=None guibg=#707B87
hi! LineNr         gui=None guifg=#41505E guibg=None
hi! MatchParen     gui=None guifg=None guibg=#4e6e99
"hi! ModeMsg        .s:fmt_none   .s:fg_blue   .s:bg_none
"hi! MoreMsg        .s:fmt_none   .s:fg_blue   .s:bg_none
"hi! NonText        .s:fmt_none   .s:fg_base01 .s:bg_none
hi! Pmenu          gui=None guifg=#B7C5D3 guibg=#15232d
hi! PmenuSbar      gui=None guifg=#2B3945 guibg=#15232d
hi! PmenuSel       gui=None guifg=None    guibg=#28323a
"hi! PmenuThumb     .s:fmt_none   .s:fg_base0  .s:bg_base03
"hi! Question       .s:fmt_bold   .s:fg_cyan   .s:bg_none
hi! Search         gui=None guifg=None guibg=#3A434C
hi! link SignColumn Normal
"hi! SpecialKey     .s:fmt_none   .s:fg_base01 .s:bg_none
hi! SpellBad       gui=undercurl guisp=#e27e8d
hi! link SpellCap SpellBad
hi! link SpellLocal SpellBad
hi! link SpellRare SpellBad
hi! StatusLine     gui=None guifg=#b7c5d3 guibg=#171d23
hi! link StatusLineNC StatusLine
hi! TabLine        gui=underline guifg=#b7c5d3 guibg=#171d23 guisp=#171d23
hi! TabLineFill    gui=underline guifg=None guibg=#171d23 guisp=#171d23
hi! TabLineSel     gui=None guifg=#fff guibg=#1D252C
hi! TermCursor      gui=None guifg=#008B94 guibg=#008B94
hi! Title          gui=bold guifg=#70E1E8 guibg=None
hi! VertSplit      gui=None guifg=#1D252C guibg=None
hi! link Visual CursorLine
"hi! VisualNOS      .s:fmt_stnd   .s:fg_none    .s:bg_base02 .s:fmt_revb
"hi! WarningMsg     .s:fmt_bold   .s:fg_red     .s:bg_none
hi! link WildMenu PmenuSel

hi Terminal        guifg=#B7C5D3 guibg=#171d23
autocmd TermOpen * setlocal winhighlight=Normal:Terminal

endif

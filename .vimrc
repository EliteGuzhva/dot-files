" ==========================================================================
" @brief Minimal vim config (no plugins)
" @author elit3guzhva
" ==========================================================================
" ==========================================================================
" Settings
syntax enable
filetype plugin on

set exrc
set nocompatible
set wildmenu
set path+=**
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set smartindent
set splitbelow
set splitright

set omnifunc=syntaxcomplete#Complete

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set termguicolors
colorscheme desert

highlight EndOfBuffer ctermfg=black ctermbg=black

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_liststyle=3

function! SmartTabComplete()
    let line = getline('.')
    let substr = strpart(line, -1, col('.') + 1)
    let substr = matchstr(substr, "[^ \t]*$")

    if (strlen(substr) == 0)
        return "\<tab>"
    endif

    if (pumvisible())
        return "\<C-N>"
    endif

    let has_period = match(substr, '\.') != -1
    let has_slash = match(substr, '\/') != -1
    if (!has_period && !has_slash)
        return "\<C-N>"
    elseif (has_slash)
        return "\<C-X>\<C-F>"
    else
        return "\<C-X>\<C-O>"
    endif
endfunction

inoremap <tab> <c-r>=SmartTabComplete()<CR>

map <C-b> :20Lex<CR>:wincmd p<CR>
map <C-p> :find<space>
map <C-\> :terminal<CR>

tnoremap <Esc> <C-\><C-n>

command! MakeTags !ctags -R .

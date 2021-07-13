" Settings
set exrc
set secure

syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set relativenumber
set splitbelow
set backup
set undofile

if has('mac')
    set guifont=Menlo:h12
else
    set guifont=FiraCode:h12
endif

set backupdir=~/.vim/backup//,.
set directory=~/.vim/swp//,.
set undodir=~/.vim/undo//,.

autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2
autocmd Filetype h setlocal tabstop=2 shiftwidth=2
autocmd Filetype hpp setlocal tabstop=2 shiftwidth=2
autocmd Filetype py setlocal tabstop=4 shiftwidth=4

" Key bindings
let mapleader = "\<Space>"

nnoremap <leader>t :botright split term://zsh<CR>
tnoremap <Esc> <C-\><C-n>

nmap <leader>so :so %<CR>
nmap <leader>q :q<CR>
nmap <leader>x :xa<CR>
nmap <leader>ss :mks!<CR>
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>
map - <C-W>-
map + <C-W>+
map < <C-W><
map > <C-W>>
nmap r :redo<CR>

" automatic package management
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" packages
call plug#begin(stdpath('data') . '/plugged')

" themes
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'ayu-theme/ayu-vim'
Plug 'adrian5/oceanic-next-vim'
Plug 'morhetz/gruvbox'

" project tree viewer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" status line
Plug 'itchyny/lightline.vim'

" additionals
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'christoomey/vim-system-copy'
Plug 'szw/vim-maximizer'
Plug 'lyokha/vim-xkbswitch'
Plug 'JamshedVesuna/vim-markdown-preview'

" ide features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" debugging
Plug 'puremourning/vimspector'

" language-specific plugins
Plug 'cdelledonne/vim-cmake'
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'

" icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp", "cmake", "python", "json", "yaml", "bash", "cuda", "dockerfile" },
  highlight = {
    enable = true,
  },
}
EOF

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#ebcb8b' gui=underline ctermfg=3 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#bf616a' gui=underline ctermfg=1 cterm=underline
augroup END

" theme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set background=dark

set termguicolors
colorscheme nord

highlight Visual cterm=reverse ctermbg=NONE

" xkbswitch
let g:XkbSwitchEnabled = 1
if has('linux')
  let g:XkbSwitchLib = '/usr/local/lib/libg3kbswitch.so'
endif

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
    \ "colorscheme": "nord",
    \ }

" vim-easy-align
au FileType markdown vmap <leader>gc :EasyAlign*<Bar><Enter>

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nmap <leader>ff :Files<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>fs :Rg<CR>
nmap <leader>fh :History<CR>

" gitgutter
nmap <leader>v[ <Plug>(GitGutterPrevHunk)
nmap <leader>v] <Plug>(GitGutterNextHunk)
nmap <leader>vp <Plug>(GitGutterPreviewHunk)
nmap <leader>vu <Plug>(GitGutterUndoHunk)
nmap <leader>va <Plug>(GitGutterStageHunk)

" vim-fugitive
nmap <leader>vs :G<CR>
nmap <leader>vf :diffget //2<CR>
nmap <leader>vj :diffget //3<CR>

" maximizer
nnoremap <leader>m :MaximizerToggle!<CR>
fun GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" md preview
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<leader>vm'
if has('mac')
    let vim_markdown_preview_browser='Safari'
else
    let vim_markdown_preview_browser='Firefox'
endif

" vimspector
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nnoremap <leader>dj :call vimspector#StepInto()<CR>
nnoremap <leader>dn :call vimspector#StepOver()<CR>
nnoremap <leader>dk :call vimspector#StepOut()<CR>
nnoremap <leader>dr :call vimspector#Restart()<CR>
nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dcb :call vimspector#ToggleConditionalBreakpoint()<CR>

nnoremap <leader>dgc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dgv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dgs :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>dgo :call GotoWindow(g:vimspector_session_windows.output)<CR>

" goyo
map <C-f> :Goyo<CR>

" limelight
map <C-l> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = 'gray'

" NERDTree
" Open on enter
autocmd vimenter * NERDTreeFind | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" keybindings
nnoremap <silent> <leader>pt :NERDTreeToggle<CR>
nnoremap <silent> <leader>pf :NERDTreeFind<CR>

" custom options
let g:NERDTreeGitStatusUseNerdFonts = 1

" Coc
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gtd <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>g] <Plug>(coc-diagnostic-next)

" Show documentation in preview window.
nnoremap <silent> <leader>gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>gn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>gc <Plug>(coc-format-selected)
nmap <leader>gc <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nnoremap <leader>gf :CocFix<CR>

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END


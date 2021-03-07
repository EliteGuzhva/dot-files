" Settings
set exrc
set secure

syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
" set guifont=FiraCode:h12
set guifont=Meno:h12
set number
set relativenumber
set splitbelow
set backup
set undofile

set backupdir=~/.vim/backup//,.
set directory=~/.vim/swp//,.
set undodir=~/.vim/undo//,.

autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2
autocmd Filetype h setlocal tabstop=2 shiftwidth=2
autocmd Filetype hpp setlocal tabstop=2 shiftwidth=2
autocmd Filetype py setlocal tabstop=4 shiftwidth=4

" Key bindings
:let mapleader = "\<Space>"
" :nnoremap <leader>t :wincmd b \| bel terminal<CR>
:nnoremap <leader>t :botright split term://bash<CR>
:tnoremap <Esc> <C-\><C-n>
:nmap <silent> <leader>so :so %<CR>
:nmap <silent> <leader>v :vsp ~/.vimrc<CR>
:nmap <leader>s :w<CR>
:nmap <leader>q :q<CR>
:nmap <leader>a :wq<CR>
:nmap <leader>x :xa<CR>
:nmap <leader>r :setl rnu!<CR> 
:nmap <leader>w :mks!<CR>
:nmap <leader>h :wincmd h<CR>
:nmap <leader>j :wincmd j<CR>
:nmap <leader>k :wincmd k<CR>
:nmap <leader>l :wincmd l<CR>
map - <C-W>-
map + <C-W>+
map < <C-W><
map > <C-W>>

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'arcticicestudio/nord-vim'
Plugin 'ayu-theme/ayu-vim'
Plugin 'adrian5/oceanic-next-vim'

Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'

Plugin 'neoclide/coc.nvim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'jackguo380/vim-lsp-cxx-highlight'

Plugin 'rust-lang/rust.vim'
Plugin 'dart-lang/dart-vim-plugin'

Plugin 'skywind3000/asyncrun.vim'
Plugin 'fisadev/FixedTaskList.vim'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'christoomey/vim-system-copy'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'puremourning/vimspector'
Plugin 'szw/vim-maximizer'

Plugin 'JamshedVesuna/vim-markdown-preview'

call vundle#end()
filetype plugin indent on

" theme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set background=dark

" set termguicolors
" let ayucolor="light"
" colorscheme ayu

colorscheme nord

highlight Visual cterm=reverse ctermbg=NONE

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
    \ "colorscheme": "nord",
    \ }

" maximizer
nnoremap <leader>m :MaximizerToggle!<CR>
fun GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" md preview
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<leader>vm'
let vim_markdown_preview_browser='Safari'

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

" CtrlP and Ag
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor\ --column
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0
endif

" goyo
map <C-f> :Goyo<CR>

" limelight
map <C-l> :Limelight!!<CR>
let g:limelight_conceal_ctermfg = 'gray'

" nerdtree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader>pv :NERDTreeFind<CR>

" YCM
" nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
" nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
" nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
" nnoremap <silent> <leader>vd :YcmCompleter GetDoc<CR>
" nnoremap <silent> <leader>ft :YcmCompleter Format<CR>
" nnoremap <leader>rr :YcmCompleter RefactorRename 

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
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>g] <Plug>(coc-diagnostic-next)

" Show documentation in preview window.
nnoremap <silent> <leader>vd :call <SID>show_documentation()<CR>

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
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>gf  <Plug>(coc-fix-current)

" lsp-cxx
let g:lsp_cxx_hl_use_text_props = 1

" tags
:nnoremap <leader>i :AsyncRun ctags -R<CR>

" default
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


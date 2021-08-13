" ==========================================================================
" @brief Vim config
" @author elit3guzhva
" ==========================================================================
" ==========================================================================
" Settings
set exrc
set secure
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set relativenumber
set splitbelow
syntax on

" guifont
if has('mac')
    set guifont=Menlo:h12
else
    set guifont=FiraCode:h12
endif

" Backup and undo
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

set backupdir=~/.vim/backup//,.
set directory=~/.vim/swp//,.
set undodir=~/.vim/undo//,.

" file-specific options
autocmd FileType text setlocal textwidth=78
autocmd Filetype dart setlocal tabstop=2 shiftwidth=2
autocmd Filetype h    setlocal tabstop=2 shiftwidth=2
autocmd Filetype hpp  setlocal tabstop=2 shiftwidth=2
autocmd Filetype c    setlocal tabstop=2 shiftwidth=2
autocmd Filetype cc   setlocal tabstop=2 shiftwidth=2
autocmd Filetype cpp  setlocal tabstop=2 shiftwidth=2
autocmd Filetype py   setlocal tabstop=4 shiftwidth=4

" ==========================================================================
" Key bindings
let mapleader = "\<Space>"

nmap <leader>so :so %<CR>
tnoremap <Esc> <C-\><C-n>

map - <C-W>-
map + <C-W>+
map < <C-W><
map > <C-W>>
nmap r :redo<CR>

" ==========================================================================
" automatic package management
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==========================================================================
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
Plug 'unblevable/quick-scope'
Plug 'christoomey/vim-system-copy'
Plug 'szw/vim-maximizer'
Plug 'lyokha/vim-xkbswitch'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
Plug 'voldikss/vim-floaterm'

" vcs
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/vim-svngutter'
Plug 'juneedahamed/vc.vim'

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

" ==========================================================================
" Which Key
" keybindings
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" custom options
let g:which_key_map =  {}
let g:which_key_sep = '→'

let g:which_key_use_floating_win = 0

set timeoutlen=500

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

call which_key#register('<Space>', "g:which_key_map")

" basics
let g:which_key_map['q'] = [ ':q', 'quit' ]
let g:which_key_map['x'] = [ ':xa', 'save & quit all' ]
let g:which_key_map['h'] = [ ':wincmd h', 'go to left window' ]
let g:which_key_map['j'] = [ ':wincmd j', 'go to bottom window' ]
let g:which_key_map['k'] = [ ':wincmd k', 'go to upper window' ]
let g:which_key_map['l'] = [ ':wincmd l', 'go to right window' ]
let g:which_key_map['='] = [ ':wincmd =', 'balance windows' ]
" let g:which_key_map['t'] = [ '::botright split term://zsh', 'open terminal' ]

" ==========================================================================
" Floaterm
" keybindings
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=30'       , 'floating terminal'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'],
      \ 'h' : [':FloatermNew htop'                              , 'htop'],
      \ 'p' : [':FloatermNew python3'                           , 'python'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 's' : ['::botright split term://zsh'                    , 'terminal split'],
      \ }

" custom options
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

" ==========================================================================
" Startify
" keybindings
let g:which_key_map.s = {
      \ 'name' : '+session',
      \ 's' : [':SSave', 'save'],
      \ 'l' : [':SLoad', 'load'],
      \ 'd' : [':SDelete', 'delete'],
      \ 'c' : [':SClose', 'close'],
      \ }

" custom options
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1

" ==========================================================================
" QuickScope
" keybindings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" custom options
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#ebcb8b' gui=underline ctermfg=3 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#bf616a' gui=underline ctermfg=1 cterm=underline
augroup END

" ==========================================================================
" theme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set background=dark

set termguicolors
colorscheme nord

highlight Visual cterm=reverse ctermbg=NONE

" ==========================================================================
" Lightline
" custom options
set laststatus=2
set noshowmode
let g:lightline = {
    \ "colorscheme": "nord",
    \ }

" ==========================================================================
" TreeSitter
" custom options
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "cpp", "cmake", "python", "json", "yaml", "bash", "cuda", "dockerfile", "dart", "go", "rust", "java", "kotlin" },
  highlight = {
    enable = true,
  },
}
EOF

" ==========================================================================
" XkbSwitch
" custom options
let g:XkbSwitchEnabled = 1
if has('linux')
  let g:XkbSwitchLib = '/usr/local/lib/libg3kbswitch.so'
endif

" ==========================================================================
" EasyAlign
" keybindings
au FileType markdown vmap <leader>gc :EasyAlign*<Bar><Enter>

" ==========================================================================
" fzf
" custom options
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" keybindings
nmap <leader>ff :Files<CR>
nmap <leader>fl :BLines<CR>
nmap <leader>fs :Rg<CR>
nmap <leader>fh :History<CR>
let g:which_key_map.f = {
      \ 'name' : '+find',
      \ 'f' : [':Files', 'files'],
      \ 'l' : [':BLines', 'lines'],
      \ 's' : [':Rg', 'symbols'],
      \ 'h' : [':History', 'history'],
      \ }

" ==========================================================================
" VCS
" keybindings
let g:which_key_map.v = {
      \ 'name' : '+vcs',
      \ '[' : ['<Plug>(GitGutterPrevHunk)', 'previous hunk'],
      \ ']' : ['<Plug>(GitGutterNextHunk)', 'next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)', 'previous hunk'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)', 'next hunk'],
      \ 'p' : ['<Plug>(GitGutterPreviewHunk)', 'preview hunk'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)', 'undo hunk'],
      \ 'a' : ['<Plug>(GitGutterStageHunk)', 'stage hunk'],
      \ 's' : [':G', 'status'],
      \ 'l' : [':VCLog', 'log'],
      \ 'd' : [':VCDiff', 'diff'],
      \ 'r' : [':VCRevert', 'revert'],
      \ 'b' : [':VCBlame', 'blame'],
      \ 'v' : {
        \ 'name' : '+svn',
        \ '[' : ['<Plug>(SvnGutterPrevHunk)', 'previous hunk'],
        \ ']' : ['<Plug>(SvnGutterNextHunk)', 'next hunk'],
        \ 'k' : ['<Plug>(SvnGutterPrevHunk)', 'previous hunk'],
        \ 'j' : ['<Plug>(SvnGutterNextHunk)', 'next hunk'],
        \ 's' : [':VCStatus', 'status'],
        \ } 
      \ }

" ==========================================================================
" Maximizer
" keybindings
nnoremap <leader>m :MaximizerToggle!<CR>
let g:which_key_map['m'] = [ ':MaximizerToggle!', 'maximize window toggle' ]

" helper function (go to window and maximize it)
fun GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" ==========================================================================
" Markdown Preview
" keybindings
let vim_markdown_preview_hotkey='<leader>vm'

"custom options
let vim_markdown_preview_github=1
if has('mac')
    let vim_markdown_preview_browser='Safari'
else
    let vim_markdown_preview_browser='Firefox'
endif

" ==========================================================================
" VimSpector
" custom options
let g:vimspector_enable_mappings='VISUAL_STUDIO'

" keybindings
let g:which_key_map.d = {
      \ 'name' : '+debug',
      \ 's' : ['<Plug>VimspectorStop', 'stop'],
      \ 'r' : ['<Plug>VimspectorRestart', 'restart'],
      \ 'c' : ['<Plug>VimspectorContinue', 'continue'],
      \ 'f' : ['<Plug>VimspectorRunToCursor', 'run to cursor (follow)'],
      \ 'b' : ['<Plug>VimspectorToggleBreakpoint', 'toggle breakpoint'],
      \ 'n' : ['<Plug>VimspectorStepOver', 'step over (next)'],
      \ 'j' : ['<Plug>VimspectorStepInto', 'step into (down)'],
      \ 'k' : ['<Plug>VimspectorStepOut', 'step out (up)'],
      \ 'h' : ['<Plug>VimspectorUpFrame', 'up frame (left)'],
      \ 'l' : ['<Plug>VimspectorDownFrame', 'down frame (right)'],
      \ 'i' : ['<Plug>VimspectorBalloonEval', 'inspect element under cursor'],
      \ 'd' : [':call vimspector#Launch()', 'debug (launch)'],
      \ 'e' : [':call vimspector#Reset()', 'reset'],
      \ 'x' : [':call vimspector#ClearBreakpoints()', 'clear breakpoints'],
      \ 'g' : {
        \ 'name' : '+go to window',
        \ 'c' : [':call GotoWindow(g:vimspector_session_windows.code', 'code'],
        \ 'v' : [':call GotoWindow(g:vimspector_session_windows.variables', 'variables'],
        \ 's' : [':call GotoWindow(g:vimspector_session_windows.stack_trace', 'stack trace'],
        \ 'o' : [':call GotoWindow(g:vimspector_session_windows.output', 'output'],
        \ } 
      \ }

" ==========================================================================
" Zen mode
" keybindings
let g:which_key_map.z = {
      \ 'name' : '+zen',
      \ 'f' : [':Goyo', 'focus'],
      \ 'l' : [':Limelight!!', 'toggle limelight'],
      \ }

" custom options
let g:limelight_conceal_ctermfg = 'gray'

" ==========================================================================
" NERDTree
" Open on enter
autocmd VimEnter * NERDTreeFind | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" keybindings
let g:which_key_map.p = {
      \ 'name' : '+project tree',
      \ 't' : [':NERDTreeToggle', 'toggle'],
      \ 'f' : [':NERDTreeFind', 'find current file in project tree'],
      \ }

" custom options
let g:NERDTreeGitStatusUseNerdFonts = 1

" ==========================================================================
" Coc
" functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" use tab for completions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" keybindings
nnoremap <silent> <leader>gh :call <SID>show_documentation()<CR>
let g:which_key_map.g = {
      \ 'name' : '+lsp',
      \ 'd' : ['<Plug>(coc-definition)', 'go to definition'],
      \ 't' : ['<Plug>(coc-type-definition)', 'go to type definition'],
      \ 'i' : ['<Plug>(coc-implementation)', 'go to implementation'],
      \ 'r' : ['<Plug>(coc-references)', 'go to references'],
      \ 'k' : ['<Plug>(coc-diagnostic-prev)', 'go to previous error'],
      \ 'j' : ['<Plug>(coc-diagnostic-next)', 'go to next error'],
      \ '[' : ['<Plug>(coc-diagnostic-prev)', 'go to previous error'],
      \ ']' : ['<Plug>(coc-diagnostic-next)', 'go to next error'],
      \ 'n' : ['<Plug>(coc-rename)', 'rename'],
      \ 'c' : ['<Plug>(coc-format-selected)', 'format selected'],
      \ 'f' : [':CocFix', 'fix'],
      \ 'h' : 'show documentation (hover)',
      \ }


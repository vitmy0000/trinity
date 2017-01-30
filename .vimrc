"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Automatically executes filetype plugin indent on and syntax enable
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

" MuComplete
Plug 'lifepillar/vim-mucomplete'

" AutoPairs
Plug 'jiangmiao/auto-pairs'

" Nerdcommenter
Plug 'scrooloose/nerdcommenter'

" lightline
Plug 'itchyny/lightline.vim'

" theme
Plug 'flazz/vim-colorschemes'

" Initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" encoding
set encoding=utf-8
" reload after external modification
set autoread
" cancel backup
set nobackup
" cancel swap file
set noswapfile
" enable mouse
set mouse=a
" use relative line number by default
set relativenumber
" save on buffer switch
set autowriteall
" spell check
set spell
" leader
let mapleader = "\<Space>"
" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" stay visual mode after shifting
vnoremap < <gv
vnoremap > >gv
" stop auto comment inserting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" remove trailing space when saving buffer
autocmd BufWritePre * %s/\s\+$//e


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show line number
set number
" do not wrap line
set nowrap
" show line and column number
set ruler
" show typing command in status line
set showcmd
" show mode in status line
set noshowmode
" enable parentheses match
set showmatch
" highlight current line
set cursorline
" highlight column at 80
set colorcolumn=80
" theme
set background=dark
colorscheme gruvbox
" no banner for netrw
let g:netrw_banner=0
" statusline
set laststatus=2
" lightline
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste', 'spell'],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \ },
    \ 'component': {
    \   'readonly': '%{&readonly?"\ue0a2":""}',
    \   'spell': '%{&spell?"SPELL":""}',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" smart indent
set smartindent
set autoindent
" change tab to space, enter Tab by Ctrl-V + Tab
set expandtab
set smarttab
set shiftround
" change indent based on file type
set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType cpp,scala set tabstop=2 shiftwidth=2 softtabstop=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto complete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set completeopt=menuone,noinsert,noselect
let g:mucomplete#enable_auto_at_startup = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlight search
set hlsearch
" incremental search
set incsearch
" case insensitive
set ignorecase
" case sensitive when uppercase letter appear
set smartcase


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra functionality
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change cursor type based on mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" auto set paste
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif
    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"
    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

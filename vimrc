if isdirectory(@%)
    echo "dir"
else
    echo "file"
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Automatically executes filetype plugin indent on and syntax enable
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'Chiel92/vim-autoformat'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-expand-region'
Plug 'nelstrom/vim-visual-star-search'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'haya14busa/incsearch.vim'
Plug 'machakann/vim-highlightedyank'
if !&diff
    Plug 'mhinz/vim-signify'
endif

" Initialize plugin system
call plug#end()
" }}}
let python_highlight_all = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults {{{
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
" save on buffer switch
set autowriteall
" spell check
set spell
" no bell
set belloff=all
" wildmenu
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" stop auto comment inserting
augroup disable_auto_comment
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
" remove trailing space when saving buffer
augroup remove_trailing_space
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keys  {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" leader
let mapleader = "\<Space>"
" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" stay visual mode after shifting
vnoremap < <gv
vnoremap > >gv
" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '
" y$ -> Y Make Y behave like other capitals
map Y y$
" vertical help
cnoreabbrev H vert h
" quick save
noremap <Leader>s :update<CR>
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show line number
set number
" use relative line number
set relativenumber
" do not wrap line
set nowrap
" show line and column number
set ruler
" show typing command in status line
set showcmd
" enable parentheses match
set showmatch
" scrolloff
set scrolloff=3
" highlight current line
set cursorline
" highlight column at 80
set colorcolumn=80
" invisible character
set listchars=tab:▸\ ,eol:¬,space:·
" theme
set background=dark
colorscheme gruvbox
" no banner for netrw
let g:netrw_banner=0
" statusline
set laststatus=2
" fold
set foldcolumn=3
set foldopen-=search foldopen-=mark
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent and search {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" smart indent
set smartindent
set autoindent
" change tab to space, enter Tab by Ctrl-V + Tab
set expandtab
set smarttab
set shiftround
" highlight search
set hlsearch
" incremental search
set incsearch
" case insensitive
set ignorecase
" case sensitive when uppercase letter appear
set smartcase
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set updatetime=500
"-- ale -- {{{
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" }}}

"-- mucomplete -- {{{
set shortmess+=c
set completeopt=menuone,noinsert
" let g:mucomplete#enable_auto_at_startup = 1
" }}}

"-- incsearch.vim -- {{{
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}

"-- ctrlp -- {{{
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_depth = 0
" }}}

"-- lightline -- {{{
" get rid of the extraneous default vim mode
set noshowmode
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
" }}}

"-- vim-smooth-scroll -- {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" }}}

"-- vim-sneak -- {{{
let g:sneak#label = 1
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
" }}}

"-- vim-highlightedyank -- {{{
map y <Plug>(highlightedyank)
" }}}

"-- tcomment -- {{{
let g:tcommentMapLeaderOp1 = '<Leader>c'
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lang {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim
augroup file_vim
    autocmd!
    autocmd FileType vim set tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType vim set foldmethod=marker
augroup END
" python
augroup file_python
    autocmd!
    autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4
augroup END
let g:ale_linters = {
            \   'python': ['pylint'],
            \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra functionality {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leave insert mode quickly
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=2000
    augroup END
endif

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

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" }}}

" TODO {{{
" ctrlp: file, grep, mru, buffer, mark, register, snippet,
" tagbar, ale, youcompleteme, target.vim
" vim, python, c++, scala, java
" }}}


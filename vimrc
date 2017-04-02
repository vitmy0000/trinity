"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

if !&diff
    Plug 'itchyny/lightline.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'justinmk/vim-sneak'
    Plug 'lifepillar/vim-mucomplete'
    Plug 'machakann/vim-highlightedyank'
    Plug 'mhinz/vim-signify'
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'tomtom/tcomment_vim'
    Plug 'henrik/vim-indexed-search'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
endif
Plug 'morhetz/gruvbox'
Plug 'terryma/vim-smooth-scroll'

" Initialize plugin system
call plug#end()
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic
set nocompatible
syntax on
filetype plugin indent on
" encoding
set encoding=utf-8
scriptencoding utf-8
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
set wildmode=list:longest,full
" timeout to send CursorHold
set updatetime=500
" auto change dir
set autochdir
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
" let g:mapleader = "\<Space>"
" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" stay visual mode after shifting
vnoremap < <gv
vnoremap > >gv
" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line,
" ` jumps to the marked line and column, so swap them
nnoremap ' `
nnoremap ` '
" y$ -> Y Make Y behave like other capitals
map Y y$
" vertical help
cnoreabbrev vh vert h
" quick save, workaround for sneak spell bug
noremap s :set spell<CR>:write<CR>
" quick leave
noremap Q :quit<CR>
" remap U to <C-r> for easier redo
nnoremap U <C-r>
" word move
nnoremap W b
nnoremap E ge
" esc to turn off search highlight
noremap g/ :let @/=''<CR>
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>
" star search for partial word
nnoremap * g*
nnoremap # g#
" emacs key mappings
inoremap <C-E> <C-O>$
inoremap <C-A> <C-O>0
cnoremap <C-E> <C-E>
cnoremap <C-A> <C-B>
noremap! <ESC>f <s-right>
noremap! <ESC>b <s-left>
noremap! <ESC><BS> <C-W>
noremap! <C-D> <Del>
noremap! <C-W> <C-W>
noremap! <C-U> <C-U>
" forward delete word and line are not feasible in command-line editing
" however, they are not very commonly used
inoremap <ESC>d <C-O>de
inoremap <C-K> <C-O>D
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show line number
set number
" use relative line number
set relativenumber
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
set foldopen-=search foldopen-=mark
set foldcolumn=1
set foldlevel=20
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent and search {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent
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
" <CR> inside parentheses
function! MyCR()
    if pumvisible()
        return "\<CR>"
    endif
    if col('.') < 2
        return "\<CR>"
    endif
    let l:prevChar = getline(line('.'))[col('.') - 2]
    let l:currChar = getline(line('.'))[col('.') - 1]
    if l:prevChar == '[' && l:currChar == ']'
        return "\<CR>\<BS>\<UP>\<C-o>\o"
    elseif l:prevChar == '{' && l:currChar == '}'
        return "\<CR>\<BS>\<UP>\<C-o>\o"
    endif
    return "\<CR>"
endfunction
inoremap <silent><expr> <CR> MyCR()
" my simple indent settings {{{
" indent one more after ( [ { :
" indent back after )
filetype indent off
function GetMyIndent(lnum)
    " Search backwards for the previous non-empty line.
    " TODO: skip comment lines
    let l:plnum = prevnonblank(a:lnum - 1)
    if l:plnum == 0
        " This is the first non-empty line, use zero indent.
        return 0
    endif

    let l:pline = getline(l:plnum)
    " if previous line end up with ...
    if l:pline =~ '[([{:]\s*$'
        return indent(l:plnum) + &shiftwidth
    endif
    if l:pline =~ '[)]\s*$'
        return indent(l:plnum) - &shiftwidth
    endif
    return -1
endfunction
set indentkeys=o
set indentexpr=GetMyIndent(v:lnum)
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- auto-pairs -- {{{
" turn on this may cause indent problem
let g:AutoPairsMapCR = 0
" }}}

"-- signify -- {{{
let g:signify_sign_show_count = 0
let g:signify_sign_change = '*'
" }}}

"-- lightline -- {{{
" get rid of the extraneous default vim mode
set noshowmode
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste', 'spell'],
            \             [ 'readonly', 'filename', 'modified', 'syntax'] ],
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
noremap <silent> K :call smooth_scroll#up(&scroll, 0, 1)<CR>
noremap <silent> J :call smooth_scroll#down(&scroll, 0, 1)<CR>
" }}}

"-- vim-surround -- {{{
xmap s <Plug>VSurround
"}}}

"-- vim-sneak -- {{{
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" sneak#wrap(op, inputlen, reverse, inclusive, label)
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
nnoremap <silent> t :<C-U>call sneak#wrap('',           1, 0, 0, 1)<CR>
nnoremap <silent> T :<C-U>call sneak#wrap('',           1, 1, 0, 1)<CR>
xnoremap <silent> t :<C-U>call sneak#wrap(visualmode(), 1, 0, 0, 1)<CR>
xnoremap <silent> T :<C-U>call sneak#wrap(visualmode(), 1, 1, 0, 1)<CR>
onoremap <silent> t :<C-U>call sneak#wrap(v:operator,   1, 0, 0, 1)<CR>
onoremap <silent> T :<C-U>call sneak#wrap(v:operator,   1, 1, 0, 1)<CR>
nnoremap <silent> b :<C-U>call sneak#wrap('',           2, 0, 2, 1)<CR>
nnoremap <silent> B :<C-U>call sneak#wrap('',           2, 1, 2, 1)<CR>
xnoremap <silent> b :<C-U>call sneak#wrap(visualmode(), 2, 0, 2, 1)<CR>
xnoremap <silent> B :<C-U>call sneak#wrap(visualmode(), 2, 1, 2, 1)<CR>
onoremap <silent> b :<C-U>call sneak#wrap(v:operator,   2, 0, 2, 1)<CR>
onoremap <silent> B :<C-U>call sneak#wrap(v:operator,   2, 1, 2, 1)<CR>
" }}}

"-- vim-highlightedyank -- {{{
map y <Plug>(highlightedyank)
" }}}

"-- mucomplete -- {{{
set shortmess+=c
set complete-=t
set completeopt=menuone,noinsert
let g:mucomplete#no_mappings = 1
let g:mucomplete#enable_auto_at_startup = 1
" add trigger path
let g:mucomplete#trigger_auto_pattern = { 'default' : '\k\k$\|[\.\w~]/$' }
let g:mucomplete#chains = { 'default' : ['file', 'keyn'] }
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lang {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim
augroup file_vim
    autocmd!
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" python
augroup file_py
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType python setlocal foldmethod=indent
augroup END
" java
augroup file_java
    autocmd!
    autocmd FileType java setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType java setlocal foldmethod=indent
augroup END
" javascript
augroup file_js
    autocmd!
    autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType javascript setlocal foldmethod=indent
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra functionality {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leave insert mode quickly
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=0
    autocmd InsertLeave * set timeoutlen=3000
augroup END

" change cursor type based on mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" auto set paste
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif
    let l:tmux_start = "\<Esc>Ptmux;"
    let l:tmux_end = "\<Esc>\\"
    return l:tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . l:tmux_end
endfunction
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ''
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" jump to last postion when reopen
augroup last_position
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" }}}


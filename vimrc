" note {{{
" waiting:
"   * jedi vim duplicate signature
"     https://github.com/davidhalter/jedi-vim/pull/349
" todo:
"   * ycm for c-family
"   * completion may slow down typing, define a way to toggle off
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Automatically executes filetype plugin indent on and syntax enable
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

if !&diff
    Plug 'Chiel92/vim-autoformat'
    Plug 'SirVer/ultisnips'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'davidhalter/jedi-vim'
    Plug 'honza/vim-snippets'
    Plug 'itchyny/lightline.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'justinmk/vim-sneak'
    Plug 'lifepillar/vim-mucomplete'
    Plug 'machakann/vim-highlightedyank'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-signify'
    Plug 'mileszs/ack.vim'
    Plug 'nelstrom/vim-visual-star-search'
    Plug 'scrooloose/nerdtree'
    Plug 'terryma/vim-expand-region'
    Plug 'tomtom/tcomment_vim'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'w0rp/ale'
endif
Plug 'morhetz/gruvbox'
Plug 'terryma/vim-smooth-scroll'

" Initialize plugin system
call plug#end()
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" timeout to send CursorHold
set updatetime=500
" change dir based on editing file
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
let g:mapleader = "\<Space>"
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
cnoreabbrev vh vert h
" print file context for easy copy
cnoreabbrev pp w !tee
" quick save
noremap <Leader>s :update<CR>
" quick quit
noremap <Leader>q :quit<CR>
" tagbar
noremap <Leader>t :TagbarToggle<CR>
" nerdtree
noremap <Leader>n :NERDTreeToggle<CR>
" autoformat
noremap <Leader>f :Autoformat<CR>
" esc to turn off search highlight
noremap <Leader>/ :let @/=''<CR>
" comment
let g:tcommentMapLeaderOp1 = '<Leader>c'
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>
" star search
nnoremap * g*
nnoremap # g#
" fix meta-keys which generate <Esc>a .. <Esc>z
let g:m_char='a'
while g:m_char <=# 'z'
  exec 'set <M-'.toupper(g:m_char).">=\<ESC>".g:m_char
  exec "imap \<ESC>".g:m_char.' <M-'.toupper(g:m_char).'>'
  let g:m_char = nr2char(1 + char2nr(g:m_char))
endw
" emacs mapping in insert mode
noremap! <C-E>  <C-O>$
noremap! <C-A>  <C-O>0
noremap! <M-B>  <S-left>
noremap! <M-F>  <S-right>
noremap! <C-D>  <C-O>x
noremap! <M-D>  <C-O>de
noremap! <C-K>  <C-O>D
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
"-- ale -- {{{
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" }}}

"-- ctrlp -- {{{
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
if isdirectory(@%)
    "dir
    let g:ctrlp_cmd = 'CtrlP '.getcwd()
    echom 'OK, set project root: '.getcwd()
else
    "file
    let g:ctrlp_max_depth = 0
endif
" }}}

"-- signify -- {{{
let g:signify_sign_show_count = 0
let g:signify_sign_change = '*'
" }}}

"-- ack -- {{{
" stop jump to the first result automatically
cnoreabbrev ack Ack!
" }}}

"-- lightline -- {{{
" get rid of the extraneous default vim mode
set noshowmode
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste', 'spell'],
            \             [ 'readonly', 'filename', 'modified', 'syntax'] ],
            \ },
            \ 'component': {
            \   'readonly': '%{&readonly?"\ue0a2":""}',
            \   'spell': '%{&spell?"SPELL":""}',
            \   'syntax': '%{ALEGetStatusLine()}',
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
let g:sneak#use_ic_scs = 1
" resolve sneak surround mangle
xmap a <Plug>VSurround
augroup surround_remap_S
    autocmd VimEnter * xmap S <Plug>SneakLabel_S
augroup END
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

"-- mucomplete -- {{{
set shortmess+=c
set complete-=t
set completeopt=menuone,noinsert
let g:mucomplete#enable_auto_at_startup = 1
" add trigger path
let g:mucomplete#trigger_auto_pattern = { 'default' : '\k\k$\|[\.\w]/$' }
let g:mucomplete#chains = {
            \ 'vim'     : ['file', 'cmd', 'keyn'],
            \ 'python'  : ['file', 'ulti', 'omni', 'keyn'],
            \ }
" }}}

"-- jedi-vim -- {{{
let g:jedi#show_call_signatures = 2
" }}}

"-- ultisnips -- {{{
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lang {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim
augroup file_vim
    autocmd!
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType vim setlocal foldmethod=marker foldcolumn=3 foldlevel=20
augroup END
" python
augroup file_python
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType python let python_highlight_all = 1
    autocmd FileType python let g:ycm_python_binary_path = 'python'
augroup END

let g:ale_linters = {
            \   'python': ['pylint'],
            \   'vim'   : ['vint'],
            \}
let g:formatters_python = ['yapf']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra functionality {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leave insert mode quickly
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=3000
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


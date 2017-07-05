"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

let g:completor = 'mu'
let g:install_external_dependent_plugin = 0
if !&diff
  Plug 'scrooloose/nerdtree'
  Plug 'unkiwii/vim-nerdtree-sync'
  Plug 'itchyny/lightline.vim'
  Plug 'taohex/lightline-buffer'
  Plug 'artnez/vim-rename'
  Plug 'szw/vim-maximizer'
  Plug 'Raimondi/delimitMate'
  Plug 'justinmk/vim-sneak'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'vim-scripts/mru.vim'
  Plug 'svermeulen/vim-easyclip'
  Plug 'tpope/tpope-vim-abolish'
  Plug 'wellle/targets.vim'
  Plug 'kshenoy/vim-signature'
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  if (g:completor == 'mu')
    Plug 'lifepillar/vim-mucomplete'
  endif
  if (g:install_external_dependent_plugin == 1)
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-signify'
    Plug 'w0rp/ale'
    Plug 'Chiel92/vim-autoformat'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    if (g:completor == 'ycm')
      Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    endif
  endif
endif
Plug 'morhetz/gruvbox'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-anzu'

" Initialize plugin system
call plug#end()
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults {{{...
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
" => Keys  {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" timeout
set timeout timeoutlen=3000 ttimeoutlen=30
augroup FastEscape
  autocmd!
  autocmd InsertEnter * set timeoutlen=10
  autocmd InsertLeave * set timeoutlen=3000
augroup END
" leader
let g:mapleader = "\<Space>"
" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
" stay visual mode after shifting
xnoremap < <gv
xnoremap > >gv
" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line,
" ` jumps to the marked line and column, so swap them
nnoremap ' `
nnoremap ` '
" y$ -> Y Make Y behave like other capitals
map Y y$
" help
nnoremap ? :vert help<Space>
cnoreabbrev vh vert help
" range search
xmap / <Esc>/\%V
" change window layout
cnoreabbrev wh windo wincmd H
cnoreabbrev wv windo wincmd K
" force write
cnoreabbrev ww w ! sudo tee %
" eol
set virtualedit=onemore
" HML
nnoremap L $l
xnoremap L $h
noremap H ^
nmap M <Plug>MoveMotionEndOfLinePlug
nnoremap gh H
nnoremap gl L
nnoremap gm M
" jump
xnoremap gy y']
nnoremap gp p']
nnoremap gP P']
" quick save, workaround for sneak spell bug
nnoremap s :set spell<CR>:write<CR>
nnoremap S :set spell<CR>:wa<CR>
" quick leave
nnoremap q :quit<CR>
nnoremap Q q
" tab to shift, force covert UtilSnips mapping
autocmd VimEnter * xnoremap <Tab> >gv
xnoremap <S-Tab> <gv
" S-tab to toggle all folds
" remap U to <C-r> for easier redo
nnoremap U <C-r>
" turn off search highlight
noremap <leader>/ :let @/=''<CR>:windo call clearmatches()<CR>
" join
noremap <leader>j :join<CR>
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>
" buffer
nnoremap + :bn<CR>
nnoremap _ :bp<CR>
nnoremap - :bd<CR>
" emacs key mappings
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
cnoremap <C-e> <C-e>
cnoremap <C-a> <C-b>
set <M-f>=f
noremap! <M-f> <s-right>
set <M-b>=b
noremap! <M-b> <s-left>
" <M-BS> not available, <M-\> as a workaround
set <M-\>=
noremap! <M-\> <C-w>
noremap! <C-d> <Del>
noremap! <C-w> <C-w>
noremap! <C-u> <C-u>
" forward delete word and line are not feasible in command-line editing
" however, they are not very commonly used
set <M-d>=d
inoremap <M-d> <C-o>de
inoremap <C-k> <C-o>D
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI {{{...
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
set scrolloff=5
" highlight current line
set cursorline
" highlight column at 80
set colorcolumn=80
" invisible character
set listchars=tab:▸\ ,eol:¬,space:·
" theme
set background=dark
colorscheme gruvbox
" statusline
set laststatus=2
" fold
set foldopen-=search foldopen-=mark
set foldcolumn=1
set foldlevel=20
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent and search {{{...
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
" my simple indent settings {{{...
filetype indent off
function! NumCharInStr(char, str)
  return strlen(substitute(a:str, "[^".a:char."]", "","g"))
endfunction
function! GetMyIndent(lnum)
  " Search backwards for the previous non-empty line.
  " TODO: skip comment lines
  let l:plnum = prevnonblank(a:lnum - 1)
  if l:plnum == 0
    " This is the first non-empty line, use zero indent.
    return 0
  endif
  let l:pline = getline(l:plnum)
  " if previous line end up with ...
  if &filetype == 'python'
    if NumCharInStr('(', l:pline) > NumCharInStr(')', l:pline)
      if l:pline =~# '(\s*\(#.*\)\?\s*$'
        if l:pline =~# '^\s*\(def\|while\|for\|with\|elif\).*(\s*\(#.*\)\?\s*$'
          return indent(l:plnum) + &shiftwidth + &shiftwidth
        else
          return indent(l:plnum) + &shiftwidth
        endif
      else
        if l:pline =~# '^\s*if'
          return indent(l:plnum) + &shiftwidth + &shiftwidth
        else
          execute 'normal! [('
          return col('.')
        endif
      endif
    elseif NumCharInStr(')', l:pline) > NumCharInStr('(', l:pline)
      let l:check_linenum = l:plnum - 1
      let l:left_cnt = NumCharInStr('(', l:pline)
      let l:right_cnt = NumCharInStr(')', l:pline)
      while l:check_linenum > l:plnum - 10 && l:check_linenum > 0
        let l:check_line = getline(l:check_linenum)
        let l:left_cnt += NumCharInStr('(', l:check_line)
        let l:right_cnt += NumCharInStr(')', l:check_line)
        if l:left_cnt == l:right_cnt
          if l:check_line =~# '^\s*\(if\|elif\|def\|while\|for\|with\)'
            return indent(l:check_linenum) + &shiftwidth
          else
            return indent(l:check_linenum)
          endif
        endif
        let l:check_linenum -= 1
      endwhile
    elseif l:pline =~# '[[{:]\s*\(#.*\)\?\s*$'
      return indent(l:plnum) + &shiftwidth
    elseif l:pline =~# '^\s*return'
      return indent(l:plnum) - &shiftwidth
    endif
  elseif &filetype == 'cpp'
    if NumCharInStr('(', l:pline) > NumCharInStr(')', l:pline)
      if l:pline =~# '(\s*\(#.*\)\?\s*$'
        return indent(l:plnum) + &shiftwidth + &shiftwidth
      else
        execute 'normal! [('
        return col('.')
      endif
    elseif NumCharInStr(')', l:pline) > NumCharInStr('(', l:pline)
      let l:check_linenum = l:plnum - 1
      let l:left_cnt = NumCharInStr('(', l:pline)
      let l:right_cnt = NumCharInStr(')', l:pline)
      while l:check_linenum > l:plnum - 10 && l:check_linenum > 0
        let l:check_line = getline(l:check_linenum)
        let l:left_cnt += NumCharInStr('(', l:check_line)
        let l:right_cnt += NumCharInStr(')', l:check_line)
        if l:left_cnt == l:right_cnt
          echom "equal"
          if l:pline =~# '[[{]\s*\(\/\/.*\)\?\s*$'
            return indent(l:check_linenum) + &shiftwidth
          else
            return indent(l:check_linenum)
          endif
        endif
        let l:check_linenum -= 1
      endwhile
    elseif l:pline =~# '[[{]\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum) + &shiftwidth
    endif
  else "other filetypes
    if l:pline =~# '[[{]\s*$'
      return indent(l:plnum) + &shiftwidth
    endif
  endif
  return -1
endfunction
set indentkeys=o
set indentexpr=GetMyIndent(v:lnum)
" grep
highlight GrepHighlight ctermbg=Green ctermfg=Black
augroup grep_cmd
  autocmd!
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>:cclose<CR>:windo call clearmatches()<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> J :cn<CR>:copen<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> K :cp<CR>:copen<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> // :windo call matchadd("GrepHighlight", "<C-r>g")<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> <leader>/ :windo call clearmatches()<CR>
  autocmd BufReadPost quickfix setlocal nocursorline
  autocmd BufReadPost quickfix :let g:quickfix_window_number = winnr()
augroup END
function! MyGrepOperator(type, ...)
  let l:search_term = ''
  if a:0 == 0
    if a:type ==# 'v'
      normal! `<v`>"gy
    elseif a:type ==# 'char'
      normal! `[v`]"gy
    else
      return
    endif
    let l:search_term = shellescape(@g)
  elseif a:0 == 1
    let l:search_term = shellescape(a:1)
  else
    return
  endif
  execute "silent grep -Irn --exclude-dir={.git,.hg} " . l:search_term . " ."
  copen
  execute "redraw!"
  execute "windo call matchadd(\"GrepHighlight\", " . l:search_term . ")"
endfunction
xnoremap <leader>g :<c-u>call MyGrepOperator(visualmode())<cr>
nnoremap <leader>g :set operatorfunc=MyGrepOperator<cr>g@
nnoremap <leader>gg :call MyGrepOperator(mode(), input("grep: "))<cr>
" substitute
function! MySubstituteOperator(type)
  if a:type ==# 'v'
    normal! `<v`>"sy
  elseif a:type ==# 'char'
    normal! `[v`]"sy
  else
    return
  endif
  call feedkeys(":%s/\<C-r>s/\<C-r>s/gc\<left>\<left>\<left>")
endfunction
xnoremap <leader>s :<c-u>call MySubstituteOperator(visualmode())<cr>
nnoremap <leader>s :set operatorfunc=MySubstituteOperator<cr>g@
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- tomtom/tcomment_vim -- {{{...
let g:tcommentMapLeaderOp1 = '<Leader>c'
let g:tcommentMapLeaderOp2 = '<Leader>C'
" }}}

"-- itchyny/lightline.vim -- {{{...
" get rid of the extraneous default vim mode
set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', 'spell' ],
  \             [ 'readonly', 'pwd' ],
  \             [ 'lint'] ],
  \   'right': [ [ 'lineinfo', 'winnr' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ "inactive" : {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo', 'winnr' ],
  \              [ 'percent' ] ]
  \ },
  \ 'component': {
  \   'winnr': '%{"❐ " . winnr()}',
  \   'pwd': '%<%{LightlinePWD()}',
  \   'readonly': '%{&readonly?"\ue0a2":""}',
  \   'lint': '%{LinterStatus()}',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ 'tabline': {
  \   'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
  \   'right': [ [ 'close' ], ],
  \ },
  \ 'component_expand': {
  \   'buffercurrent': 'lightline#buffer#buffercurrent2',
  \ },
  \ 'component_type': {
  \   'buffercurrent': 'tabsel',
  \ },
  \ 'component_function': {
  \   'lineinfo': 'LightlineLineinfo',
  \   'percent': 'LightlinePercent',
  \   'spell': 'LightlineSpell',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'bufferbefore': 'lightline#buffer#bufferbefore',
  \   'bufferafter': 'lightline#buffer#bufferafter',
  \   'bufferinfo': 'lightline#buffer#bufferinfo',
  \ },
\ }
function! LightlinePWD()
  return "Dir: " . expand('%:p:h')
endfunction
function! LightlineSpell()
  return winwidth(0) > 70 ? (&spell ? 'SPELL' : '') : ''
endfunction
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
function! LightlinePercent()
  return winwidth(0) > 70 ? ((line(".") * 100) / line("$")) . '%' : ''
endfunction
function! LightlineLineinfo()
  return winwidth(0) > 70 ? (line(".") . ':' . col(".")) : ''
endfunction

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = '✭ '
let g:lightline_buffer_modified_icon = '+'
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = ' '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20
" }}}

"-- terryma/vim-smooth-scroll -- {{{...
let g:smooth_scroll_steps = &scroll
let g:smooth_scroll_speed = 2
nnoremap <silent> K :call SmoothScroll('u', 'm', g:smooth_scroll_steps, g:smooth_scroll_speed)<CR>
nnoremap <silent> J :call SmoothScroll('d', 'm', g:smooth_scroll_steps, g:smooth_scroll_speed)<CR>
nnoremap <silent> <C-e> :call SmoothScroll('u', 'f', 5, g:smooth_scroll_speed)<CR>
nnoremap <silent> <C-y> :call SmoothScroll('d', 'f', 5, g:smooth_scroll_speed)<CR>
" }}}

"-- tpope/vim-surround -- {{{...
xmap s <Plug>VSurround
xmap S <Plug>VgSurround
"}}}

"-- justinmk/vim-sneak -- {{{...
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" sneak#wrap(op, inputlen, reverse, inclusive, label)
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
nnoremap <silent> e :<C-U>call sneak#wrap('',           2, 0, 1, 1)<CR>
nnoremap <silent> E :<C-U>call sneak#wrap('',           2, 1, 1, 1)<CR>
xnoremap <silent> e :<C-U>call sneak#wrap(visualmode(), 2, 0, 1, 1)<CR>
xnoremap <silent> E :<C-U>call sneak#wrap(visualmode(), 2, 1, 1, 1)<CR>
onoremap <silent> e :<C-U>call sneak#wrap(v:operator,   2, 0, 1, 1)<CR>
onoremap <silent> E :<C-U>call sneak#wrap(v:operator,   2, 1, 1, 1)<CR>
map e <Plug>Sneak_s
map E <Plug>Sneak_S
" }}}

"-- szw/vim-maximizer -- {{{...
nnoremap <silent> <leader>W :MaximizerToggle<CR>
nnoremap <silent> <leader>w <C-w>o
nnoremap <silent> <leader><leader> <C-w><C-w>
" }}}

"-- lifepillar/vim-mucomplete -- {{{...
if (g:completor == 'mu')
  set shortmess+=c
  set complete-=t "no tag
  set completeopt=menuone,noselect,noinsert
  let g:mucomplete#no_mappings = 1
  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#chains = {
    \ 'default' : ['ulti', 'path', 'keyn', 'c-n'],
  \ }
  inoremap <silent> <plug>(MUcompleteFwdKey) <s-right>
  imap <s-right> <plug>(MUcompleteCycFwd)
  inoremap <silent> <plug>(MUcompleteBwdKey) <s-left>
  imap <s-left> <plug>(MUcompleteCycBwd)
  inoremap <expr> <c-e> pumvisible() ? mucomplete#popup_exit("\<c-e>") : "\<c-o>$"
  inoremap <expr> <c-y> pumvisible() ? mucomplete#popup_exit("\<c-y>") : "\<c-y>"
  inoremap <expr>  <cr> pumvisible() ? mucomplete#popup_exit("\<cr>") : MyCR()
  inoremap <expr> <down> pumvisible() ? "\<c-n>" : "\<c-o>gj"
  inoremap <expr> <up> pumvisible() ? "\<c-p>" : "\<c-o>gk"
endif
" }}}

"-- SirVer/ultisnips -- {{{...
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/trinity/UltiSnips'
" }}}

"-- haya14busa/incsearch.vim -- {{{...
hi Search ctermfg=Yellow ctermbg=Black
map /  <Plug>(incsearch-forward)
let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
map *  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map #  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)
" }}}

"-- svermeulen/vim-easyclip -- {{{...
" integrate yank highlight
hi HighlightedyankRegion ctermfg=Black ctermbg=Blue
function! s:sallowsleep(ms) abort
  let t = reltime()
  while !getchar(1) && a:ms - str2float(reltimestr(reltime(t))) * 1000.0 > 0
  endwhile
endfunction
function! HighlightYankedLine()
  let l:curline = line('.')
  call matchaddpos("HighlightedyankRegion", [l:curline])
  redraw
  call s:sallowsleep(500)
  call clearmatches()
endfunction
function! HighlightYankedEOL()
  let l:curline = line(".")
  let l:curcol = virtcol(".")
  let l:eofcol = virtcol("$")
  call matchaddpos("HighlightedyankRegion", [[l:curline, l:curcol, l:eofcol - l:curcol]])
  redraw
  call s:sallowsleep(500)
  call clearmatches()
endfunction
function! EasyClipYankMotionHighlithWrapper(type)
  call EasyClip#Yank#YankMotion(a:type)
  let l:startline = line("'[")
  let l:startcol = virtcol("'[")
  let l:endline = line("']")
  let l:endcol = virtcol("']")
  if a:type ==# 'char' && l:startline == l:endline
    call matchaddpos("HighlightedyankRegion", [[l:startline, l:startcol, l:endcol - l:startcol + 1]])
  elseif a:type ==# 'char' && l:startline != l:endline
    execute "normal! '["
    let l:firstlineEndcol = virtcol("$")
    call matchaddpos("HighlightedyankRegion", [[l:startline, l:startcol, l:firstlineEndcol - l:startcol]])
    for l:line in range(l:startline + 1, l:endline - 1)
      call matchaddpos("HighlightedyankRegion", [l:line])
    endfor
    call matchaddpos("HighlightedyankRegion", [[l:endline, 0, l:endcol]])
  elseif a:type ==# 'line'
    for l:line in range(l:startline, l:endline)
      call matchaddpos("HighlightedyankRegion", [l:line])
    endfor
  endif
  redraw
  call s:sallowsleep(500)
  call clearmatches()
endfunction
nnoremap <silent> yy :<c-u>call EasyClip#Yank#PreYankMotion()<cr>:call EasyClip#Yank#YankLine()<cr>:<c-u>call HighlightYankedLine()<cr>
nnoremap <silent> <expr> Y ":<c-u>call EasyClip#Yank#PreYankMotion()<cr>:set opfunc=EasyClip#Yank#YankMotion<cr>" . (v:count > 0 ? v:count : '') . "g@$:<c-u>call HighlightYankedEOL()<cr>"
nnoremap <silent> <expr> y ":<c-u>call EasyClip#Yank#PreYankMotion()<cr>:set opfunc=EasyClipYankMotionHighlithWrapper<cr>" . (v:count > 0 ? v:count : '') . "g@"
"}}}

"-- scrooloose/nerdtree -- {{{...
noremap <leader>e :NERDTreeToggle<CR>
augroup nerdtree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
  autocmd BufEnter * silent! lcd %:p:h
augroup END
"}}}

"-- vim-scripts/mru.vim -- {{{...
noremap <leader>r :MRU<CR>
" }}}

"-- kshenoy/vim-signature -- {{{...
let g:SignatureMap = {
  \ 'Leader'             :  "m",
  \ 'PlaceNextMark'      :  "m,",
  \ 'ToggleMarkAtLine'   :  "m.",
  \ 'PurgeMarksAtLine'   :  "m-",
  \ 'DeleteMark'         :  "dm",
  \ 'PurgeMarks'         :  "m<Space>",
  \ 'PurgeMarkers'       :  "",
  \ 'GotoNextLineAlpha'  :  "",
  \ 'GotoPrevLineAlpha'  :  "",
  \ 'GotoNextSpotAlpha'  :  "",
  \ 'GotoPrevSpotAlpha'  :  "",
  \ 'GotoNextLineByPos'  :  "",
  \ 'GotoPrevLineByPos'  :  "",
  \ 'GotoNextSpotByPos'  :  "]'",
  \ 'GotoPrevSpotByPos'  :  "['",
  \ 'GotoNextMarker'     :  "",
  \ 'GotoPrevMarker'     :  "",
  \ 'GotoNextMarkerAny'  :  "",
  \ 'GotoPrevMarkerAny'  :  "",
  \ 'ListBufferMarks'    :  "m/",
  \ 'ListBufferMarkers'  :  ""
  \ }
" }}}

"-- junegunn/fzf.vim -- {{{...
noremap <leader>ff :Files<CR>
noremap <leader>fl :BLines<CR>
noremap <leader>fk :BTags<CR>
noremap <leader>fg :Ag<CR>
noremap <leader>fb :Buffers<CR>
noremap <leader>fu :Snippets<CR>
noremap <leader>fh :Helptags<CR>
noremap <leader>fc :Commands<CR>
noremap <leader>fr :History<CR>
noremap <leader>f: :History:<CR>
noremap <leader>f/ :History/<CR>
map <leader>mn :call fzf#vim#maps('n', 0)<CR>
map <leader>mi :call fzf#vim#maps('i', 0)<CR>
map <leader>mx :call fzf#vim#maps('x', 0)<CR>
map <leader>mo :call fzf#vim#maps('o', 0)<CR>
" }}}

"-- mhinz/vim-signify -- {{{...
let g:signify_sign_show_count = 0
let g:signify_sign_change = '*'
" }}}

"-- majutsushi/tagbar -- {{{...
noremap <leader>t :TagbarToggle<CR>
let g:tagbar_map_closefold = "_"
" }}}

"-- Chiel92/vim-autoformat -- {{{...
noremap <leader>= :Autoformat<CR>
" let g:autoformat_verbosemode=1
let g:formatter_yapf_style = 'pep8'
let g:formatdef_yapf = "'yapf --line ' . a:firstline . '-' . a:lastline "
let g:formatters_python = ['yapf']
" }}}

"-- w0rp/ale -- {{{...
let g:ale_linters = {
\   'vim': ['vint'],
\   'python': ['pylint'],
\}
let g:ale_python_pylint_options = '-E'
function! LinterStatus() abort
  if (g:install_external_dependent_plugin == 0 || g:ale_enabled == 0)
    return 'off'
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? 'OK' : printf(
  \   '%dW %dE',
  \   all_non_errors,
  \   all_errors
  \)
endfunction
" echo message
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" mapping
nmap <silent> ( <Plug>(ale_previous_wrap)
nmap <silent> ) <Plug>(ale_next_wrap)
" run linters only when save files
let g:ale_lint_on_text_changed = 'never'
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lang {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2 shiftwidth=2 softtabstop=2
set foldmethod=indent

" vim
augroup file_vim
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" python
augroup file_py
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
  autocmd FileType python let NERDTreeIgnore = ['\.pyc$']
augroup END
" cpp
augroup file_cpp
  autocmd!
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType cpp setlocal foldmethod=indent
  autocmd FileType cpp let NERDTreeIgnore = ['\.o$']
augroup END

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra functionality {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change cursor type based on mode {{{...
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" }}}

" auto set paste {{{...
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
" }}}

" jump to last postion when reopen {{{...
augroup last_position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" }}}

" interactive registers {{{...
function! MyRegp()
  registers
  let l:reg = input("Please select your register: ")
  if l:reg != ''
    execute "normal \"" . l:reg . "p"
  endif
endfunction
function! MyRegP()
  registers
  let l:reg = input("Please select your register: ")
  if l:reg != ''
    execute "normal \"" . l:reg . "P"
  endif
endfunction
nmap <leader>p :call MyRegp()<CR>
nmap <leader>P :call MyRegP()<CR>
" }}}

" auto close quickfix window {{{...
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END
" }}}

" SmoothScroll
function! SmoothScroll(dir, cursor, dist, speed)
  for i in range(a:dist/a:speed)
    let start = reltime()
    " scroll down and cursor move
    if a:dir ==# 'd' && a:cursor ==# 'm'
      exec "normal! ".a:speed."\<C-e>".a:speed."j"
    " scroll up and cursor move
    elseif a:dir ==# 'u' && a:cursor ==# 'm'
      exec "normal! ".a:speed."\<C-y>".a:speed."k"
    " scroll down and cursor fix
    elseif a:dir ==# 'd' && a:cursor ==# 'f'
      exec "normal! ".a:speed."\<C-y>"
    " scroll up and cursor fix
    elseif a:dir ==# 'u' && a:cursor ==# 'f'
      exec "normal! ".a:speed."\<C-e>"
    endif
    redraw
  endfor
endfunction

" Toggle all folds
let s:my_unrol_flat = 1
function! MyUnrolToggle()
if s:my_unrol_flat == 0
    :exe "normal zR"
    let s:my_unrol_flat = 1
else
    :exe "normal zM"
    let s:my_unrol_flat = 0
endif
endfunction
nnoremap <S-tab> :call MyUnrolToggle()<CR>

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

let g:install_external_dependent_plugin = 1
let g:completor = ''
if !&diff
  Plug 'scrooloose/nerdtree'
  Plug 'unkiwii/vim-nerdtree-sync'
  Plug 'itchyny/lightline.vim'
  Plug 'taohex/lightline-buffer'
  Plug 'skywind3000/quickmenu.vim'
  Plug 'Raimondi/delimitMate'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'svermeulen/vim-easyclip'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/tpope-vim-abolish'
  Plug 'kshenoy/vim-signature'
  Plug 'tpope/vim-projectionist'
  Plug 'kana/vim-textobj-user'
  Plug 'sgur/vim-textobj-parameter'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'beloglazov/vim-textobj-quotes'
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
  if (g:install_external_dependent_plugin == 1)
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-signify'
    Plug 'w0rp/ale'
    Plug 'Chiel92/vim-autoformat'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-update-rc' }
    Plug 'junegunn/fzf.vim'
    let g:completor = 'ycm'
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  else
    let g:completor = 'mu'
    Plug 'lifepillar/vim-mucomplete'
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
" wrap line by default
set wrap
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
  autocmd FileType * setlocal formatoptions=
augroup END
" remove trailing space when saving buffer
augroup remove_trailing_space
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END
" auto close quickfix window
augroup QFClose
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup END
" jump to last postion when reopen
augroup last_position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" stop loggin viminfo in vimdiff
if &diff
  set viminfo=
endif
" force line wrap in vimdiff
autocmd VimEnter * if &diff | execute 'windo set wrap' | endif
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keys  {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l,[,]
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
nmap Y y$
" HML
noremap <expr> H getline(line('.'))[:col('.') - 2] =~# '^\s*$' ? "0" : "^"
nnoremap <expr> L col('.') == col('$') - 1 ? "$l" : "$"
xnoremap <expr> L col('.') == col('$') - 1 ? "$" : "$h"
" help
nnoremap ? :vert help<Space>
cnoreabbrev vh vert help
" range search
xmap / <Esc>/\%V
" change window layout
cnoreabbrev wv windo wincmd H
cnoreabbrev ws windo wincmd K
" force write
cnoreabbrev ww w ! sudo tee %
" jump to end of copying and pasting region
xnoremap gy y`]
nnoremap gp p`]
nnoremap gP P`]
" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
" quick save, workaround for sneak spell bug
nnoremap s :write<CR>
nnoremap S :wa<CR>
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
noremap <leader>/ :noh<CR>:windo call clearmatches()<CR>
" window
noremap <leader>w <C-w>
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>
" ctrl-i is equivalent to tab, use ctrl-l instead
noremap <C-l> <C-i>
" buffer
nnoremap + :bn<CR>
nnoremap _ :bp<CR>
nnoremap - :bd<CR>
" line editing {{{...
" Option + U mapped to Option + b
set <M-b>=b
inoremap <M-b> <s-left>
cnoremap <M-b> <s-left>
" Option + I mapped to Option + f
set <M-f>=f
inoremap <M-f> <s-right>
cnoremap <M-f> <s-right>
" Option + Y mapped to Ctrl + a
inoremap <expr> <C-a> getline(line('.'))[:col('.') - 2] =~# '^\s*$' ? "\<C-o>0" : "\<C-o>^"
cnoremap <C-a> <C-b>
" Option + O mapped to Ctrl + e
inoremap <C-e> <C-o>$
cnoremap <C-e> <C-e>
" Option + N mapped to Option + Delete
" <M-BS> not available, <M-\> as a workaround
set <M-\>=
inoremap <M-\> <C-w>
cnoremap <M-\> <C-w>
" Option + M mapped to Option + d
set <M-d>=d
inoremap <M-d> <C-o>de
cnoremap <M-d> <Del>
" Option + , mapped to Ctrl + u
inoremap <C-u> <C-u>
cnoremap <C-u> <C-u>
" Option + . mapped to Ctrl + k
inoremap <C-k> <C-o>D
cnoremap <C-k> <Del>
" forward delete word and line are not feasible in command-line editing
" however, they are not very commonly used
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show line number
set number
" eol
set virtualedit=onemore
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
" <CR> inside parentheses {{{
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
    return "\<CR>\<C-o><<\<UP>\<C-o>\o"
  elseif l:prevChar == '{' && l:currChar == '}'
    return "\<CR>\<C-o><<\<UP>\<C-o>\o"
  endif
  return "\<CR>"
endfunction
" }}}
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
    elseif (l:pline =~# '^\s*return' || l:pline =~# '^\s*pass\s*$')
      return indent(l:plnum) - &shiftwidth
    endif
  elseif (&filetype == 'cpp')
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
          if l:pline =~# '[[{]\s*\(\/\/.*\)\?\s*$'
            return indent(l:check_linenum) + &shiftwidth
          else
            return indent(l:check_linenum)
          endif
        endif
        let l:check_linenum -= 1
      endwhile
    elseif l:pline =~# '\s*namespace.*{\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum)
    elseif l:pline =~# '[[{]\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum) + &shiftwidth
    " public:, protected:, private:
    elseif l:pline =~# '\(public\|protected\|private\):\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum) + 1
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
    call feedkeys(":%S/\<C-r>s/\<C-r>s/gc\<left>\<left>\<left>")
  elseif a:type ==# 'char'
    normal! `[v`]"sy
    call feedkeys(":%S/\<C-r>s/\<C-r>s/gc\<left>\<left>\<left>")
  elseif a:type ==# 'V'
    call feedkeys(":'<,'>S/x/x/gc\<left>\<left>\<left>\<left>\<left>")
    return
  endif
endfunction
xnoremap <leader>s :<c-u>call MySubstituteOperator(visualmode())<cr>
nnoremap <leader>s :set operatorfunc=MySubstituteOperator<cr>g@
nnoremap <leader>ss :%S/x/x/gc<left><left><left><left><left>
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- tomtom/tcomment_vim -- {{{...
let g:tcommentMapLeaderOp1 = '<Leader>c'
" }}}

"-- skywind3000/quickmenu.vim -- {{{...
if !&diff
  " enable cursorline (L) and cmdline help (H)
  let g:quickmenu_options = "L"
  let g:quickmenu_ft_blacklist = ['netrw', 'nerdtree', 'tagbar']
  " clear all the items
  call g:quickmenu#reset()
  " invoke key
  noremap <silent> <leader>a :NERDTreeClose<cr>:TagbarClose<cr>:call quickmenu#toggle(0)<cr>
  " section 1, text starting with "#" represents a section (see the screen capture below)
  call g:quickmenu#append('# Toggle', '')
  call g:quickmenu#append('Toggle line wrap', 'setlocal wrap!')
  call g:quickmenu#append('Toggle invisible char display', 'setlocal list!')
  call g:quickmenu#append('Toggle cursor column', 'setlocal cursorcolumn!')
  " section 2
  call g:quickmenu#append('# Misc', '')
  call g:quickmenu#append('MRU', 'call MyMRU()')
  call g:quickmenu#append('Tab to space', 'setlocal list | retab')
  call g:quickmenu#append('Reload vimrc', 'source ~/.vimrc')
  " section 3
  if (g:install_external_dependent_plugin == 1)
    call g:quickmenu#append('# External', '')
    call g:quickmenu#append('Edit snippets', 'UltiSnipsEdit')
    call g:quickmenu#append('Ycm config gen', 'YcmGenerateConfig')
  endif
endif
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

"-- tpope/vim-surround -- {{{...
xmap s <Plug>VSurround
xmap S <Plug>VSurround
"}}}

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

" -- easymotion/vim-easymotion -- {{{...
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map f <Plug>(easymotion-bd-fl)
map t <Plug>(easymotion-bd-tl)
noremap T :join<CR>
map F <Plug>(easymotion-s)
map w <Plug>(easymotion-bd-wl)
map W <Plug>(easymotion-lineanywhere)
map b <Plug>(easymotion-bd-jk)
nmap B <Plug>(easymotion-overwin-line)
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
" m key mappings
nmap M <Plug>MoveMotionEndOfLinePlug
nnoremap gm m
" e for replace
xmap e <plug>XEasyClipPaste
nmap e <plug>SubstituteOverMotionMap
nmap ee <plug>SubstituteLine
nmap E <plug>SubstituteToEndOfLine
"}}}

"-- majutsushi/tagbar -- {{{...
noremap <leader>t :NERDTreeClose<CR>:TagbarToggle<CR>
noremap <leader>T :NERDTreeClose<CR>:TagbarToggle<CR><C-w>p
let g:tagbar_autofocus = 1
let g:tagbar_map_closefold = ['_', 'zc']
let g:tagbar_map_previewwin = ''
let g:tagbar_map_showproto = ''
let g:tagbar_map_hidenonpublic = ''
let g:tagbar_map_togglecaseinsensitive = ''
augroup tagbar
  autocmd!
  autocmd FileType tagbar nmap <buffer> i c<CR>
augroup END
" }}}

"-- scrooloose/nerdtree -- {{{...
noremap <leader>e :TagbarClose<CR>:NERDTreeToggle<CR><C-w>p<C-w>p
noremap <leader>E :TagbarClose<CR>:NERDTreeToggle<CR><C-w>p
let g:NERDTreeChDirMode = 2
let g:NERDTreeMapActivateNode = 'o'
let g:NERDTreeMapPreview = 'p'
let g:NERDTreeMapOpenInTab = ''
let g:NERDTreeMapOpenInTabSilent = ''
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapPreviewSplit = 'gs'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreviewVSplit = 'gv'
let g:NERDTreeMapCloseDir = '_'
let g:NERDTreeMapOpenRecursively = ''
let g:NERDTreeMapCloseChildren = ''
let g:NERDTreeMapOpenExpl = ''
let g:NERDTreeMapJumpRoot = ''
let g:NERDTreeMapJumpParent = ''
let g:NERDTreeMapJumpFirstChild = ''
let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
let g:NERDTreeMapDeleteBookmark = ''
let g:NERDTreeMapChangeRoot = 'w'
let g:NERDTreeMapUpdir = 'u'
let g:NERDTreeMapUpdirKeepOpen = ''
let g:NERDTreeMapRefresh = ''
let g:NERDTreeMapRefreshRoot = 'r'
let g:NERDTreeMapMenu = 'a'
let g:NERDTreeMapCWD = ''
let g:NERDTreeMapChdir = ''
let g:NERDTreeMapToggleZoom = ''
augroup nerdtree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
  autocmd FileType nerdtree nmap <buffer> i <CR>:NERDTreeClose<CR>
augroup END
"}}}

"-- Raimondi/delimitMate -- {{{...
let delimitMate_expand_space = 1
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
map <leader>mv :call fzf#vim#maps('v', 0)<CR>
map <leader>mx :call fzf#vim#maps('x', 0)<CR>
map <leader>mo :call fzf#vim#maps('o', 0)<CR>
map <leader>ms :call fzf#vim#maps('s', 0)<CR>
map <leader>mi :call fzf#vim#maps('i', 0)<CR>
map <leader>mc :call fzf#vim#maps('c', 0)<CR>
" }}}

"-- mhinz/vim-signify -- {{{...
let g:signify_sign_show_count = 1
let g:signify_sign_change = '*'
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
  inoremap <expr>  <cr> pumvisible() ? mucomplete#popup_exit("\<c-y>") : MyCR()
  inoremap <expr> <down> pumvisible() ? "\<c-n>" : "\<c-o>j"
  inoremap <expr> <up> pumvisible() ? "\<c-p>" : "\<c-o>k"
endif
" }}}

"-- Valloric/YouCompleteMe -- {{{...
if (g:completor == 'ycm')
  set completeopt-=preview
  let g:ycm_key_list_select_completion = ['<C-n>']
  let g:ycm_key_list_previous_completion = ['<C-p>']
  let g:ycm_key_list_stop_completion = ['<C-y>']
  imap <expr> <CR> pumvisible() ? "\<C-y>" : MyCR()
  imap <expr> <Down> pumvisible() ? "\<C-n>" : "\<C-o>j"
  imap <expr> <Up> pumvisible() ? "\<C-p>" : "\<C-o>k"
  let g:ycm_show_diagnostics_ui = 0
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_complete_in_comments = 1
  let g:ycm_complete_in_strings = 1
  let g:ycm_use_ultisnips_completer = 1
  let g:ycm_seed_identifiers_with_syntax=1
  nnoremap <leader>yi :YcmCompleter GoToInclude<CR>
  nnoremap <leader>yd :YcmCompleter GoToDeclaration<CR>
  nnoremap <leader>yt :YcmCompleter GetType<CR>
  nnoremap <leader>yp :YcmCompleter GetParent<CR>
  nnoremap <leader>yf :YcmCompleter FixIt<CR>:copen<CR>
endif
"}}}

"-- Chiel92/vim-autoformat -- {{{...
noremap <leader>= :Autoformat<CR>
" let g:autoformat_verbosemode=1
let g:formatter_yapf_style = 'pep8'
let g:formatdef_yapf = "'yapf --line ' . a:firstline . '-' . a:lastline "
let g:formatters_python = ['yapf']
let g:formatdef_my_custom_cpp = "'clang-format -style=\"{BasedOnStyle: google}\" -lines=' . a:firstline . ':' . a:lastline "
let g:formatters_cpp = ['my_custom_cpp']
" }}}

"-- w0rp/ale -- {{{...
let g:ale_linters = {
\   'python': ['pylint'],
\   'cpp': ['clang'],
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
set tabstop=4 shiftwidth=4 softtabstop=4
set foldmethod=indent

" vim {{{
augroup file_vim
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" shell {{{
augroup file_shell
  autocmd!
  autocmd FileType sh,zsh setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType sh,zsh setlocal foldmethod=marker
augroup END
" }}}

" python {{{
augroup file_py
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
  autocmd FileType python let NERDTreeIgnore = ['\.pyc$']
augroup END
" }}}

" cpp {{{
function! MyCppArrowAsParenthesis()
  if col('.') < 2
    return 0
  elseif getline(line('.'))[ : col('.') - 2] =~# '^#include\s'
    return 1
  elseif getline(line('.'))[ : col('.') - 2] =~# '^.*operator$'
    return 0
  elseif getline(line('.'))[col('.') - 2] =~# '[< ]'
    return 0
  else
    return 1
  end
endfunction
augroup file_cpp
  autocmd!
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType cpp let NERDTreeIgnore = ['\.o$']
  autocmd FileType cpp setlocal matchpairs+=<:>
  autocmd FileType cpp inoremap <buffer> <expr> < MyCppArrowAsParenthesis() ? "<>\<left>" : "<"
augroup END
" }}}

" make {{{
augroup file_make
  autocmd!
  autocmd FileType make setlocal tabstop=8 shiftwidth=8 softtabstop=8
  autocmd FileType make setlocal noexpandtab
  autocmd FileType make let NERDTreeIgnore = ['\.o$']
augroup END
" }}}

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

" SmoothScroll {{{
function! SmoothScroll(dir, dist, speed)
  for i in range(a:dist/a:speed)
    let start = reltime()
    " scroll down and cursor move
    if a:dir ==# 'd'
      exec "normal! ".a:speed."\<C-e>".a:speed."j"
    " scroll up and cursor move
    elseif a:dir ==# 'u'
      exec "normal! ".a:speed."\<C-y>".a:speed."k"
    endif
    redraw
  endfor
endfunction
let g:smooth_scroll_steps = &scroll
let g:smooth_scroll_speed = 3 "must be integer
nnoremap <silent> K :call SmoothScroll('u', g:smooth_scroll_steps, g:smooth_scroll_speed)<CR>
nnoremap <silent> J :call SmoothScroll('d', g:smooth_scroll_steps, g:smooth_scroll_speed)<CR>
" }}}

" Toggle all folds {{{
let s:my_unrol_flat = 1
function! MyUnrolToggle()
  if s:my_unrol_flat == 0
    execute "normal zR"
    let s:my_unrol_flat = 1
  else
    execute "normal zM"
    let s:my_unrol_flat = 0
endif
endfunction
nnoremap <S-tab> :call MyUnrolToggle()<CR>
"}}}

" MRU {{{
function! MyMRU()
  oldfiles
  let l:file = input("Please select your file: ")
  if l:file != ''
    execute 'e #<' . l:file
  endif
endfunction
" }}}

" toggle quickfix window {{{
function! MyQuickfixToggle()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction
nnoremap <leader>q :call MyQuickfixToggle()<CR>
" }}}

" }}}

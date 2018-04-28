"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{...
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" requires Ag, Ctags, Cmake, Git, yapf, clang-format, pylint
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'itchyny/lightline.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-signify'
Plug 'miyakogi/conoline.vim'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-highlightedyank'
Plug 'sjl/gundo.vim'
Plug 'Raimondi/delimitMate'
Plug 'svermeulen/vim-easyclip'
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-projectionist'
Plug 'tpope/tpope-vim-abolish'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-anzu'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'Julian/vim-textobj-brace'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" TODO incsearch.vim added in 8.0.1238

call plug#end()
" = }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings {{{...
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> basics {{{...
nnoremap ; :write<cr>
nnoremap ? :vert help<space>
noremap , J
" range search
xmap / <esc>/\%V
" stay visual mode after shifting
xnoremap < <gv
xnoremap > >gv
" ` jumps to the marked line and column, so swap them
nnoremap ' `
nnoremap ` '
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<cr>
nnoremap <S-tab> :call MyUnrolToggle()<CR>
" ctrl-i is equivalent to tab, use ctrl-l instead
noremap <C-l> <C-i>
nnoremap q :quit<cr>
" for quick jump back
vnoremap y y']
" select pasted text
nnoremap gp `[v`]
nnoremap Q q
nnoremap U <C-r>
nnoremap <silent> K :call SmoothScroll('u', g:smooth_scroll_steps, g:smooth_scroll_speed)<cr>
nnoremap <silent> J :call SmoothScroll('d', g:smooth_scroll_steps, g:smooth_scroll_speed)<cr>
xnoremap K <c-u>
xnoremap J <c-d>
noremap <expr> H getline(line('.'))[:col('.') - 2] =~# '^\s*$' ? "0" : "^"
nnoremap <expr> L col('.') == col('$') - 1 ? "$l" : "$"
xnoremap <expr> L col('.') == col('$') - 1 ? "$" : "$h"
" == }}}
" ==> abbreviation {{{...
cnoreabbrev vh vert help
" change window layout
cnoreabbrev wv windo wincmd H
cnoreabbrev ws windo wincmd K
" }}}
" ==> leader {{{...
let g:mapleader = "\<space>"
nnoremap <leader><leader> :Commands<cr>
noremap <leader>/ :noh<cr>
" ===> file {{{...
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fr :FZFMru<cr>
nnoremap <leader>fe :e ~/.vimrc<cr>
nnoremap <leader>fs :so ~/.vimrc<cr>
" ===}}}
" ===> toggle {{{...
nnoremap <leader>tw :set wrap!<cr>
nnoremap <leader>ti :set list!<cr>
nnoremap <leader>tc :setlocal cursorcolumn!<cr>
nnoremap <leader>tt :TagbarToggle<cr>
" === }}}
" ===> comment {{{...
xmap <leader>c <Plug>Commentary
nmap <leader>c <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
" === }}}
" ===> buffer {{{...
nnoremap <leader>bb :Buffers<cr>
noremap <leader>bd :bd<cr>
" ===}}}
" ===> substitute {{{...
xnoremap <leader>s :<c-u>call MySubstituteOperator(visualmode())<cr>
nnoremap <leader>s :set operatorfunc=MySubstituteOperator<cr>g@
nnoremap <leader>ss :%S///gc<left><left><left><left>
" ===}}}
" ===> search {{{...
xnoremap <leader>g :<c-u>call MySearchOperator(visualmode())<cr>
nnoremap <leader>g :set operatorfunc=MySearchOperator<cr>g@
nnoremap <leader>gg :Ag<cr>
" ===}}}
" ===> paste {{{...
nmap <leader>p :call MyRegp()<cr>
nmap <leader>P :call MyRegP()<cr>
" ===}}}
" ===> mapping/mark {{{...
nnoremap <leader>mn :call fzf#vim#maps('n', 0)<cr>
nnoremap <leader>mv :call fzf#vim#maps('v', 0)<cr>
nnoremap <leader>mx :call fzf#vim#maps('x', 0)<cr>
nnoremap <leader>mo :call fzf#vim#maps('o', 0)<cr>
nnoremap <leader>ms :call fzf#vim#maps('s', 0)<cr>
nnoremap <leader>mi :call fzf#vim#maps('i', 0)<cr>
nnoremap <leader>mc :call fzf#vim#maps('c', 0)<cr>
nnoremap <leader>mm :Marks<cr>
" ===}}}
" ===> YouCompleteMe {{{...
nnoremap <leader>yd :YcmCompleter GoToDeclaration<cr>
nnoremap <leader>yt :YcmCompleter GetType<cr>
nnoremap <leader>yp :YcmCompleter GetParent<cr>
nnoremap <leader>yf :YcmCompleter FixIt<cr>:copen<cr>
nnoremap <leader>yg :YcmGenerateConfig<cr>
" === }}}
" ==> vim-autoformat {{{...
noremap <leader>= :Autoformat<cr>
" === }}}
" ===> utilities {{{...
nnoremap <leader>uu :GundoToggle<cr>
nnoremap <leader>ue :UltiSnipsEdit<cr>
nnoremap <leader>ur :Rename<cr>
nnoremap <leader>um :Move<cr>
nnoremap <leader>ud :Delete<cr>
nnoremap <leader>uc :Mkdir<cr>
nnoremap <leader>ua :A<cr>
nnoremap <leader>uy :Yank<cr>
" === }}}
" ===> window {{{...
nnoremap <leader>w <C-w>
" jump to tagbar window
nnoremap <leader>wt :TagbarOpen j<cr>
nnoremap <leader>1 1<C-w><C-w>
nnoremap <leader>2 2<C-w><C-w>
nnoremap <leader>3 3<C-w><C-w>
nnoremap <leader>4 4<C-w><C-w>
nnoremap <leader>5 5<C-w><C-w>
nnoremap <leader>6 6<C-w><C-w>
nnoremap <leader>7 7<C-w><C-w>
nnoremap <leader>8 8<C-w><C-w>
nnoremap <leader>9 9<C-w><C-w>
" === }}}
" == }}}
" ==> vim-easymotion {{{...
map ee <Plug>(easymotion-s)
map ew <Plug>(easymotion-lineanywhere)
map ef <Plug>(easymotion-bd-fl)
map et <Plug>(easymotion-bd-tl)
xmap el <Plug>(easymotion-bd-jk)
nmap el <Plug>(easymotion-overwin-line)
" ==}}}
" == > line editing {{{...
" Option + U mapped to Option + b
set <M-b>=b
inoremap <M-b> <S-left>
cnoremap <M-b> <S-left>
" Option + I mapped to Option + f
set <M-f>=f
inoremap <M-f> <S-right>
cnoremap <M-f> <S-right>
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
" == }}}
" ==> fzf {{{...
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" == }}}
" = }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults {{{...
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> basics {{{...
set nocompatible
syntax on
filetype plugin indent on
set backspace=indent,eol,start
set encoding=utf-8
scriptencoding utf-8 " able to show some icon
set noswapfile
set mouse=a " enable mouse
set spell
set belloff=all
set whichwrap+=<,>,h,l,[,] " allow motion across lines
set wildmenu
set wildmode=list:longest,full
set autowriteall " save on buffer switch
set virtualedit=onemore,block
set hidden " keep undo history after switching buffer
if &diff
  set viminfo=
endif
" == }}}
" ==> UI {{{...
set background=dark
colorscheme gruvbox
set number
set relativenumber
set showcmd
set splitbelow
set splitright
set scrolloff=8
set cursorline
set colorcolumn=81
" invisible character
set listchars=tab:▸\ ,eol:¬,space:·
set tabstop=4 shiftwidth=4 softtabstop=4
set shiftround
set expandtab
set autoindent
set foldmethod=indent
set foldcolumn=1
set foldlevel=20 " fold deep only at opening
" == }}}
" = }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Types {{{...
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> vim {{{...
augroup file_vim
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" == }}}
" ==> shell {{{...
augroup file_shell
  autocmd!
  autocmd FileType sh,zsh setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType sh,zsh setlocal foldmethod=indent
augroup END
" == }}}
" ==> python {{{...
augroup file_py
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  " for docstring
  autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
augroup END
" == }}}
" ==> cpp {{{...
augroup file_cpp
  autocmd!
  autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType cpp setlocal matchpairs+=<:>
  autocmd FileType cpp inoremap <buffer> <expr> < MyCppArrowAsParenthesis() ? "<>\<left>" : "<"
augroup END
" == }}}
" = }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{...
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> lightline {{{...
set laststatus=2
set noshowmode " mode is shown in lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', 'spell' ],
  \             [ 'readonly', 'relativepath', 'modified' ],
  \             [ 'lint'] ],
  \   'right': [ [ 'lineinfo', 'winnr' ],
  \              [ 'percent' ],
  \              [ 'fileencoding', 'filetype' ] ]
  \ },
  \ "inactive" : {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo', 'winnr' ],
  \              [ 'percent' ] ]
  \ },
  \ 'component': {
  \   'winnr': '%{"❐ " . winnr()}',
  \   'readonly': '%{&readonly?"\ue0a2":""}',
  \   'lint': '%{LinterStatus()}',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ }
" == }}}
" ==> conoline.vim {{{...
let g:conoline_auto_enable = 1
let g:conoline_use_colorscheme_default_normal=1
" == }}}
" ==> vim-signature {{{...
let g:SignatureMap = {
  \ 'Leader'             :  "gm",
  \ 'PlaceNextMark'      :  "",
  \ 'ToggleMarkAtLine'   :  "",
  \ 'PurgeMarksAtLine'   :  "",
  \ 'DeleteMark'         :  "",
  \ 'PurgeMarks'         :  "dm",
  \ 'PurgeMarkers'       :  "",
  \ 'GotoNextLineAlpha'  :  "",
  \ 'GotoPrevLineAlpha'  :  "",
  \ 'GotoNextSpotAlpha'  :  "",
  \ 'GotoPrevSpotAlpha'  :  "",
  \ 'GotoNextLineByPos'  :  "",
  \ 'GotoPrevLineByPos'  :  "",
  \ 'GotoNextSpotByPos'  :  "",
  \ 'GotoPrevSpotByPos'  :  "",
  \ 'GotoNextMarker'     :  "",
  \ 'GotoPrevMarker'     :  "",
  \ 'GotoNextMarkerAny'  :  "",
  \ 'GotoPrevMarkerAny'  :  "",
  \ 'ListBufferMarks'    :  "",
  \ 'ListBufferMarkers'  :  ""
  \ }
" == }}}
" ==> gundo.vim {{{...
let g:gundo_prefer_python3 = 1
let g:gundo_return_on_revert = 0
" === }}}
" ==> incsearch.vim {{{...
set hlsearch
set ignorecase
set smartcase
hi Search ctermfg=Magenta ctermbg=Black
map /  <Plug>(incsearch-forward)
let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
map g*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map * <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
" == }}}
" ==> vim-easyclip {{{...
nmap M <Plug>MoveMotionEndOfLinePlug
let g:EasyClipUseSubstituteDefaults = 1
let g:EasyClipAlwaysMoveCursorToEndOfPaste = 1
hi HighlightedyankRegion ctermfg=Black ctermbg=Blue
" == }}}
" ==> vim-easymotion {{{...
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" == }}}
" ==> YouCompleteMe {{{...
set completeopt-=preview
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
let g:ycm_key_list_stop_completion = ['<C-y>']
imap <expr> <cr> pumvisible() ? "\<C-y>" : MyCR()
let g:ycm_show_diagnostics_ui = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax=1
" == }}}
" ==> tagbar {{{...
set updatetime=500
let g:tagbar_map_togglefold = ['<tab>', 'za', 'o']
" to enable leader
let g:tagbar_map_showproto = ''
" == }}}
" ==> ultisnips {{{...
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/trinity/UltiSnips'
let g:UltiSnipsEditSplit="vertical"
" == }}}
" ==> vim-autoformat {{{...
let g:formatter_yapf_style = 'pep8'
let g:formatdef_yapf = "'yapf --line ' . a:firstline . '-' . a:lastline "
let g:formatters_python = ['yapf']
let g:formatdef_my_custom_cpp = "'clang-format -style=\"{BasedOnStyle: google}\" -lines=' . a:firstline . ':' . a:lastline "
let g:formatters_cpp = ['my_custom_cpp']
" }}}
" ==> ale {{{...
let g:ale_linters = {
  \   'python': ['pylint'],
  \   'cpp': ['clang'],
  \}
let g:ale_python_pylint_options = '-E'
function! LinterStatus() abort
  if (g:ale_enabled == 0)
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
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" run linters only when save files
let g:ale_lint_on_text_changed = 'never'
" == }}}
" ==> vim-textobj-parameter {{{...
let g:vim_textobj_parameter_mapping = 'a'
" ==}}}
" = }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Functionalities {{{...
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> search {{{...
function! MySearchOperator(type)
  if a:type ==# 'v'
    normal! `<v`>"sy
    call feedkeys(":Ag\<space>\<C-r>s\<cr>")
  elseif a:type ==# 'char'
    normal! `[v`]"sy
    call feedkeys(":Ag\<space>\<C-r>s\<cr>")
    return
  endif
endfunction
" ==> }}}
" ==> substitute {{{...
function! MySubstituteOperator(type)
  if a:type ==# 'v'
    normal! `<v`>"sy
    call feedkeys(":%S/\<C-r>s/\<C-r>s/gc\<left>\<left>\<left>")
  elseif a:type ==# 'char'
    normal! `[v`]"sy
    call feedkeys(":%S/\<C-r>s/\<C-r>s/gc\<left>\<left>\<left>")
    return
  " region substitute
  elseif a:type ==# 'V'
    call feedkeys(":'<,'>S///gc\<left>\<left>\<left>\<left>")
    return
  endif
endfunction
" ==> }}}
" ==> smooth scroll {{{...
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
let g:smooth_scroll_speed = 2 "must be integer
" == }}}
" ==> disable all format options including auto comment {{{...
augroup disable_format_options
  autocmd!
  autocmd FileType * setlocal formatoptions=
augroup END
" == }}}
" ==> jump to last position when reopen {{{...
augroup jump_to_last_quit_position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" == }}}
" ==> fast escapes {{{...
set timeout timeoutlen=3000 ttimeoutlen=30
augroup FastEscape
  autocmd!
  autocmd InsertEnter * set timeoutlen=30
  autocmd InsertLeave * set timeoutlen=3000
  " TODO Add CmdlineEnter and CmdlineLeave 8.0.1206
augroup END
" == }}}
" ==> remove trailing space when saving buffer {{{...
function! RemoveTrailingSpace()
  let l:save_cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfunction
augroup remove_trailing_space
  autocmd!
  autocmd BufWritePre * execute "call RemoveTrailingSpace()"
augroup END
" == }}}
" ==> change cursor type based on mode {{{...
let &t_SI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=1\x7\<esc>\\"
let &t_SR = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=2\x7\<esc>\\"
let &t_EI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
" == }}}
" ==> auto set paste {{{...
function! WrapForTmux(s)
  if !exists('$TMUX')
  return a:s
  endif
  let l:tmux_start = "\<esc>Ptmux;"
  let l:tmux_end = "\<esc>\\"
  return l:tmux_start . substitute(a:s, "\<esc>", "\<esc>\<esc>", 'g') . l:tmux_end
endfunction
let &t_SI .= WrapForTmux("\<esc>[?2004h")
let &t_EI .= WrapForTmux("\<esc>[?2004l")
function! XTermPasteBegin()
  set pastetoggle=<esc>[201~
  set paste
  return ''
endfunction
inoremap <special> <expr> <esc>[200~ XTermPasteBegin()
" == }}}
" ==> toggle all folds {{{...
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
" ==}}}
" ==> interactive past {{{...
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
" == }}}
" ==> check <> as a pair for cpp {{{...
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
" == }}}
" ==> <cr> inside {} [] {{{...
function! MyCR()
  if pumvisible()
    return "\<cr>"
  endif
  if col('.') < 2
    return "\<cr>"
  endif
  let l:prevChar = getline(line('.'))[col('.') - 2]
  let l:currChar = getline(line('.'))[col('.') - 1]
  if l:prevChar == '[' && l:currChar == ']'
    return "\<cr>\<C-o><<\<up>\<C-o>\o"
  elseif l:prevChar == '{' && l:currChar == '}'
    return "\<cr>\<C-o><<\<up>\<C-o>\o"
  elseif l:prevChar == '(' && l:currChar == ')' && &filetype == 'python'
    return "\<cr>\<C-o><<\<up>\<C-o>\o"
  endif
  return "\<cr>"
endfunction
" == }}}
" ==> my indent rule {{{...
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
  " use PEP8 rule for python
  if (&filetype == 'cpp' || &filetype == 'java')
    " opening '('
    if NumCharInStr('(', l:pline) > NumCharInStr(')', l:pline)
      " with nothing followed
      if l:pline =~# '(\s*\(#.*\)\?\s*$'
        return indent(l:plnum) + &shiftwidth + &shiftwidth
      " with something followed
      else
        execute 'normal! [('
        return col('.')
      endif
    " closing ')'
    elseif NumCharInStr(')', l:pline) > NumCharInStr('(', l:pline)
      let l:check_linenum = l:plnum - 1
      let l:left_cnt = NumCharInStr('(', l:pline)
      let l:right_cnt = NumCharInStr(')', l:pline)
      " fall back to check last 10 lines to find the opening line
      while l:check_linenum > l:plnum - 10 && l:check_linenum > 0
        let l:check_line = getline(l:check_linenum)
        let l:left_cnt += NumCharInStr('(', l:check_line)
        let l:right_cnt += NumCharInStr(')', l:check_line)
        if l:left_cnt == l:right_cnt
            return indent(l:check_linenum)
          endif
        endif
        let l:check_linenum -= 1
      endwhile
    " no indent for namespace
    elseif l:pline =~# '\s*namespace.*{\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum)
    " other opening chars, 1 indent
    elseif l:pline =~# '[[{]\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum) + &shiftwidth
    " 1 space for public:, protected:, private:
    elseif l:pline =~# '\(public\|protected\|private\):\s*\(\/\/.*\)\?\s*$'
      return indent(l:plnum) + 1
    endif
  else "other filetypes
    if l:pline =~# '[[{(]\s*$'
      return indent(l:plnum) + &shiftwidth
    endif
  endif
  return -1
endfunction
filetype indent off
set indentkeys=oO
set indentexpr=GetMyIndent(v:lnum)
" == }}}
" = }}}

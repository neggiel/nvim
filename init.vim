set nocompatible
set noshowmode
set showcmd
set noswapfile
set number
set hidden
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set cursorline
"set pastetoggle=<C-e>
colorscheme molokai

" マクロ
let @d = 'vf";x'
let @b = 'o'
"let @n = ':tabnew
:e .
'
let @p = ':set paste
'
let @o = ':set nopaste
'

" ファイルタイプの変更
"nnoremap <C-h><C-h> :set filetype=html<CR>
"nnoremap <C-j><C-j> :set filetype=php<CR>

" 文字化け対策
set ttimeout
set ttimeoutlen=50
set ambiwidth=double

" インサートモードでの移動
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>

" (te)
" xやsではヤンクしない
nnoremap x "_x
nnoremap s "_s

" ビジュアルモードで連続ペースト
xnoremap p "_xP

" 括弧補完
" imap { {}<LEFT>
" imap [ []<LEFT>
" imap ( ()<LEFT>

" json
let g:vim_json_syntax_conceal = 0

" leader
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader><Bar> :vsplit<CR>
nnoremap <Leader>- :split<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>c :close<CR>
nnoremap <Leader>e :e .<CR>
nnoremap <Leader>t :tabnew<CR>:e .<CR>
nnoremap <Leader>, gT
nnoremap <Leader>. gt
nnoremap <Leader><Space> o<Esc>

" netrw
nnoremap <C-e><C-e> :e .<CR>
nnoremap <C-t><C-e> :tabnew<CR>:e .<CR>
nnoremap <C-t><C-w> :bd<CR>

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" クリップボードにコピー
" set clipboard=unnamed

" terminal
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber

" blade
au BufRead,BufNewFile *.blade.php set filetype=html

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/deoplete.nvim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('mattn/emmet-vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('kana/vim-operator-user')
  call dein#add('kana/vim-operator-replace')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('tomtom/tcomment_vim')
  "call dein#add('scrooloose/nerdtree')
  call dein#add('junegunn/vim-peekaboo')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


" deoplate
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
        \ neosnippet#expandable_or_jumpable() ?
        \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"


" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.config/nvim/snippets'


" lightline
" https://github.com/itchyny/lightline.vim
set laststatus=2
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
   return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		return fugitive#head()
	else
		return ''
	endif
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" operater replace usage : Riw or Ri'
map R <Plug>(operator-replace)

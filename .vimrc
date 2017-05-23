set number "行表示
set cursorline "行ハイライト"
"set smartindent "インデント自動入力
set autoindent
"set cindent
set shiftwidth=4 "自動インデント時のタブ幅"
set title "編集中のファイル名
set tabstop=4 "タブ幅変更
"不可視文字の可視化
"色変更
set t_Co=256
"colorscheme visualstudio "カラースキーム
"colorscheme neodark
"colorscheme molokai
colorscheme mrkn256 
"colorscheme primary 
"colorscheme amcolors 
"colorscheme jammy

set showmatch
set matchtime=1 "括弧入力時に対応する括弧を表示

set noswapfile "スワップファイルを作成しない
set backspace=indent,eol,start
set foldmethod=indent "フォールド(折り畳み)
set foldlevel=2 "折り畳みレベルの指定
set foldcolumn=1
"set mouse=a "マウス機能
set history=10000 "ヒストリーストック数(default 20)
"set spell "spell check
set spelllang=en "spell checkをengのみに適応
set hidden "buffer使用時保存確認無し
set backup "バックアップファイル作成
set backupdir=~/.vim/backup "バックアップフォルダ


" Two-byte space
"autocmd ColorScheme * hi link TwoByteSpace Error
"autocmd VimEnter,WinEnter * let w:m_tbs = matchadd("TwoByteSpace", '　')

"括弧の自動入力
"inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
""inoremap ( ()<Left>
""inoremap " ""<Left>
""inoremap ' ''<Left>
""inoremap [ []<Left>
""inoremap () ()

set ambiwidth=double "□"

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"Substitution Key
"""""""""""""""""""""""""""""""""""""""""""""""""""""
""imap <C-L> <RIGHT>
""imap <C-H> <LEFT>
""imap <C-J> <DOWN>
""imap <C-K> <UP>
"inoremap jj <Esc>:Sort<CR>
inoremap jj <Esc>
nmap j gj
nmap k gk

nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l 


nnoremap w0 <C-w>=
nnoremap w. <C-w>>
nnoremap w, <C-w><
nnoremap w; <C-w>+
nnoremap w- <C-w>-


noremap <UP> <nop>
noremap <DOWN> <nop>
noremap <RIGHT> <nop>
noremap <LEFT> <nop>
noremap! <UP> <nop>
noremap! <DOWN> <nop>
noremap! <RIGHT> <nop>
noremap! <LEFT> <nop>


nmap f0 :set foldlevel=0<CR>
nmap f1 :set foldlevel=1<CR>
nmap f2 :set foldlevel=2<CR>
nmap f3 :set foldlevel=3<CR>
nmap f4 :set foldlevel=4<CR>
nmap f5 :set foldlevel=5<CR>
nmap f6 :set foldlevel=6<CR>
nmap f7 :set foldlevel=7<CR>
nmap f8 :set foldlevel=8<CR>
nmap f9 :set foldlevel=9<CR>
nmap f10 :set foldlevel=100<CR>



	let e = expand("%:e")
	let file = system("ls | grep .".e)
let g:files = substitute(file, "\n", " ", "g")


command! Sort call s:Sort()
function! s:Sort()
	let e = expand("%:e")
	if e == "c"
		:let pos = getpos(".")
		:normal gg=G
		:call setpos('.',pos)
	endif
endfunction





""F5でコンパイル&実行&""""""""""
command! Run call s:Run()
function! s:Run()
	:w
	let e = expand("%:e")
	if e == "c"
		:Gcc
	endif
	
	if e == "cpp"
		:Gpp
	endif

	if e == "php"
		:Php
	endif

	if e == "java"
		:Jav
	endif

	if e == "html"
		:HTML
	endif
endfunction
"""""C言語、ファイル末尾にコメントアウト付き
command! Gcc call s:Gcc()
function! s:Gcc()
	:let error = system("g++ -o " . %:r . ".out " . % )
	if v:shell_error == 0
	""コメントアウト
		:call append(line('$'), split("/*","",1))
	""コンパイル成功時のみ実行
		:call cursor(line('$'),0)
	""実行結果の貼り付け(ユーザー入力は入力されない(仕様))
		:r!./%:r.out
		:call append(line('$'), split("*/","",1))
	else
		:echomsg error
		:messages
	endif
endfunction

command! Gpp call s:Gpp()
function! s:Gpp()
	:!g++ -o %:r.out %
	if v:shell_error == 0
		:!./%:r.out
	endif
endfunction

command! Php call s:Php()
function! s:Php()
	:!php %
endfunction

command! Jav call s:Jav()
function! s:Jav()
	:!javac %
	if v:shell_error == 0
		:!java %:r
	endif
endfunction

command! HTML call s:HTML()
function! s:HTML()
	:!firefox %
endfunction

nmap <F5> :Run<CR>
imap <F5> <Esc>:Run<CR>
""""""""""""""""""""""""""""""""""



command! GrepRun call s:GrepRun()
function! s:GrepRun()
	:wa
	if e == "cpp"
		:GGpp
	endif
	
endfunction

command! GGpp call s:GGpp()
function! s:GGpp()
	:let error = system("g++ -o main.out ".g:files)
	if v:shell_error == 0
		:!./main.out
	else
		:echomsg error
		:messages
	endif
endfunction








nmap <F6> :GrepRun<CR>
imap <F6> <Esc>:GrepRun<CR>

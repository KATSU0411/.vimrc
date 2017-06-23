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
set foldlevel=100 "折り畳みレベルの指定
set foldcolumn=1
"set mouse=a "マウス機能
set history=10000 "ヒストリーストック数(default 20)
"set spell "spell check
set spelllang=en "spell checkをengのみに適応
set hidden "buffer使用時保存確認無し
"set backup "バックアップファイル作成
"set backupdir=~/.vim/backup "バックアップフォルダ


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



"------------------------------NeoBundle---------------------
" 起動時にruntimepathにNeoBundleのパスを追加する
if has('vim_starting')
   	if &compatible
       set nocompatible
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" NeoBundle設定の開始
call neobundle#begin(expand('~/.vim/bundle'))

" NeoBundleのバージョンをNeoBundle自身で管理する
NeoBundleFetch 'Shougo/neobundle.vim'

" インストールしたいプラグインを記述
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Yggdroot/indentLine'
"NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'jistr/vim-nerdtree-tabs'
"NeoBundle 'airblade/vim-gitgutter' "git
NeoBundle 'rhysd/accelerated-jk'
"NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tiagofumo/vim-nerdtree-syntax-highlight'
NeoBundle 'tyru/caw.vim.git'




" NeoBundle設定の終了
call neobundle#end()

filetype plugin indent on

" vim起動時に未インストールのプラグインをインストールする
NeoBundleCheck

"jkの移動を高速化
"nmap j <Plug>(accelerated_jk_gj)
"nmap k <Plug>(accelerated_jk_gk)



"--------------------caw.vim------------
"cmでcommentout
nmap cm <Plug>(caw:hatpos:toggle)
vmap cm <Plug>(caw:hatpos:toggle)

"---------------------snippets-----------------------
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets/'

" <TAB>: completion.
 " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

 " Plugin key-mappings.
 imap <C-k>     <Plug>(neosnippet_expand_or_jump)
 smap <C-k>     <Plug>(neosnippet_expand_or_jump)

 imap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
 " imap <expr><CR>  pumvisible() ? "\<Plug>(neosnippet_expand_or_jump)" : "<CR>"

 

 " SuperTab like snippets behavior.
 " imap <expr><TAB> neosnippet#jumpable() ?
 "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
 imap <expr><TAB> neosnippet#jumpable() ?"\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
 smap <expr><TAB> neosnippet#jumpable() ?"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

 
 

 " For snippet_complete marker.
 if has('conceal')
   set conceallevel=1 concealcursor=i
endif


"--------------------nerdtree-------------------------
 inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
 inoremap <expr><C-l>     neocomplete#complete_common_string()
" let NERDTreeShowHidden = 1	"隠しファイル有無
 autocmd VimEnter * NERDTree
 map <C-n> :NERDTreeToggle<CR>
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "Treeだけ残るようなら終了
 

  "NERDTress File highlighting--拡張子ごとのハイライト設定
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1


"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.  a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.  a:extension .'$#'
"
"endfunction
"
"call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow','#151515')
"call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('rb',     'Red',     'none', 'red', '#151515')
"call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
"call NERDTreeHighlightFile('c',    'darkblue', 'none', '#00008b', '#151515')
"
"----------------------neocomplacache------------------
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
 set completeopt=menuone

 " 補完ウィンドウの設定
 set completeopt=menuone

 " rsenseでの自動補完機能を有効化
 let g:rsenseUseOmniFunc = 1
 " let g:rsenseHome = '/usr/local/lib/rsense-0.3'

 " auto-ctagsを使ってファイル保存時にtagsファイルを更新
 let g:auto_ctags = 1

 " 起動時に有効化
 let g:neocomplcache_enable_at_startup = 1

 " 大文字が入力されるまで大文字小文字の区別を無視する
 let g:neocomplcache_enable_smart_case = 1

 " _(アンダースコア)区切りの補完を有効化
 let g:neocomplcache_enable_underbar_completion = 1

 let g:neocomplcache_enable_camel_case_completion  =  1

 " 最初の補完候補を選択状態にする
 let g:neocomplcache_enable_auto_select = 1

 " ポップアップメニューで表示される候補の数
 let g:neocomplcache_max_list = 20

 " シンタックスをキャッシュするときの最小文字長
 let g:neocomplcache_min_syntax_length = 3

 " 補完の設定
 autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
 if !exists('g:neocomplete#force_omni_input_patterns')
   let g:neocomplete#force_omni_input_patterns = {}
   endif
   let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

   if !exists('g:neocomplete#keyword_patterns')
           let g:neocomplete#keyword_patterns = {}
           endif
           let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" <TAB>: completion.                                         
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   
" inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 
"
"" neocomplcache
"---------------------------------------------------------


"----------------------------------------------------------


filetype on

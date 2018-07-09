"---------------------------------------------------------------------------
" plugins下のディレクトリをruntimepathへ追加する。
"---------------------------------------------------------------------------
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"---------------------------------------------------------------------------
" 基本設定:
"---------------------------------------------------------------------------
" 行番号を表示
set number

" ルーラーを表示
set ruler

" 長い行を折り返して表示
set wrap

" 常にステータス行を表示
set laststatus=2

" コマンドをステータス行に表示
set showcmd

" タイトルを表示
set title

" シンタックス表示
syntax on

" clipboardの設定
set clipboard=unnamed

" vimの文字コードをUTF-8に設定
set enc=utf-8

" ファイル保存時の文字コード
set fenc=utf-8

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start

" 改行時のtab幅を設定
set shiftwidth=4

"---------------------------------------------------------------------------
" 編集に関する設定:
"---------------------------------------------------------------------------
" タブの画面上での幅
set tabstop=4

" タブをスペースに展開しない
set noexpandtab

" 自動的にインデントする
set autoindent

" 括弧入力時に対応する括弧を表示
set showmatch

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" 検索に関する設定:
"---------------------------------------------------------------------------
"              小文字                大文字
"*************************************************************************** 
"| ignorecase              : 大文字小文字を無視 : 大文字小文字を無視       |
"| ignorecase + smartcase  : 大文字小文字を無視 : 普通の検索               |
"| ignorecaseなし          : 普通の検索         : 普通の検索               |
"*************************************************************************** 
" 検索時に大文字小文字を無視
set ignorecase

" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan

"---------------------------------------------------------------------------
" バックアップに関する設定:
"---------------------------------------------------------------------------
" スワップファイルの設定
set swapfile
set directory=$VIM/temp/swp

" バックアップファイルの設定
set backup
set backupdir=$VIM/temp/backup

" インフォファイルの設定
set viminfo=

" アンドゥファイルの設定
set noundofile

"---------------------------------------------------------------------------
" Dein.vim の設定:
"---------------------------------------------------------------------------
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')

" Plugin
call dein#add('Shougo/Unite.vim')
call dein#add('scrooloose/nerdtree')

" ColorScheme
call dein#add('w0ng/vim-hybrid')
call dein#add('nanotech/jellybeans.vim')
call dein#add('vim-scripts/Zenburn')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('davidhalter/jedi-vim')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('thinca/vim-quickrun')
call dein#add('scrooloose/syntastic')
 
" Rust
call dein#add('rust-lang/rust.vim')

" if dein#check_install()
"   call dein#install()
" endif

call dein#end()

filetype plugin indent on

"---------------------------------------------------------------------------
" jedi の設定:
"---------------------------------------------------------------------------
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 0

" 補完キーの設定
let g:jedi#completions_command = "<C-Space>"

" 変数の宣言場所へジャンプ
let g:jedi#goto_assignments_command = "<C-g>"

" クラス、関数定義にジャンプ
let g:jedi#goto_definitions_command = "<C-n>"
let g:jedi#goto_command = "<C-j>"

" Pydocを表示
let g:jedi#documentation_command = "<C-k>"

"---------------------------------------------------------------------------
" syntastic の設定:
"---------------------------------------------------------------------------
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_python_checkers = ['flake8']
" let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_mode_map = { 'mode': 'passive' }

"---------------------------------------------------------------------------
" キーマップに関する設定:
"---------------------------------------------------------------------------
" 半角の括弧系を補完入力
inoremap {<CR> {}<LEFT>
inoremap [<CR> []<LEFT>
inoremap (<CR> ()<LEFT>
inoremap <<CR> <><LEFT>

" 全角の括弧系を補完入力
inoremap 「<CR> 「」<LEFT>
inoremap （<CR> （）<LEFT>

" Pythonを編集中に実行する設定
autocmd BufNewFile,BufRead *.py nnoremap <F5> :!python %

" quickfixが更新されたら自動で開くようにできる
autocmd QuickfixCmdPost vimgrep copen

" NERDTreeをC-eで開くように設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" jedi
nnoremap [jedi] <Nop>
xnoremap [jedi] <Nop>
nmap <Leader>j [jedi]
xmap <Leader>j [jedi]

" syntastic
noremap <C-c> :SyntasticCheck<CR>

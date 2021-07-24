" ショートカットキーの設定
noremap <leader>dtl :call GetTableList()<CR>
noremap <leader>dsa :call SelectAll()<CR>
vnoremap <leader>des :<C-U>call ExecuteSQL()<CR>

" グローバル変数の設定
let g:db_path = $HOME . "/vimfiles/db/Finance.sqlite3"

function! GetTableList()
	let l:exe_type = "get_table_list"

	py3file $HOME/vimfiles/python/sqlite3.py

	echo s:result_select

endfunction

function! SelectAll()
	let l:exe_type = "select_all"

	py3file $HOME/vimfiles/python/sqlite3.py

	echo s:result_select

endfunction

function! ExecuteSQL()

	" 選択行の文字列を無名レジスタに取得
	silent normal gvy

	" 改行とタブをスペースに置き換え
	let l:exe_sql = @@
	let l:exe_sql = substitute(l:exe_sql, "\n", " ", "g")

	let l:exe_type = "execute_sql"
	" let s:exe_sql = "select * from daily_data"

	py3file $HOME/vimfiles/python/sqlite3.py

	echo s:result_select

endfunction

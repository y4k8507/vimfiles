" ショートカットキーの設定
noremap <leader>dtl :call GetTableList()<CR>
noremap <leader>dsa :call SelectAll()<CR>

" グローバル変数の設定
let g:db_path = $HOME . "/vimfiles/db/Finance.sqlite3"

function! GetTableList()
	let s:exe_type = "get_table_list"

	py3file $HOME/vimfiles/python/sqlite3.py

	echo s:result_select

endfunction

function! SelectAll()
	let s:exe_type = "select_all"

	py3file $HOME/vimfiles/python/sqlite3.py

	echo s:result_select

endfunction

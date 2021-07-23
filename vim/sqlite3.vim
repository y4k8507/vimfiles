" ショートカットキーの設定
noremap <leader>dbtl :call ExeSelect()<CR>

function! ExeSelect()
	let s:exe_type = "get_table_list"

	py3file $HOME/vimfiles/python/sqlite3.py

	echo s:result_select

endfunction

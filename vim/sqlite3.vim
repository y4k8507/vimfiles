" ショートカットキーの設定
noremap <leader>dex :call ExplorerSqlite3()<cr>
noremap <leader>dtl :call GetTableList()<CR>
vnoremap <leader>des :<C-U>call ExecuteSQL()<CR>

" グローバル変数の設定
let g:db_path = $HOME . "/vimfiles/db/Finance.sqlite3"

function! GetTableList()
	let l:exe_type = "get_table_list"

	py3file $HOME/vimfiles/python/sqlite3.py

	if win_gotoid(g:win_result_sql) == 0
		echo "出力画面が存在しません"
	endif

	" SQLの結果を表示する
	call PasteResultWindow()

	" 出力結果を整形する
	execute '%s/,/\r/g'

endfunction

function! ExecuteSQL()

	" 選択行の文字列を無名レジスタに取得
	silent normal gvy

	" 改行とタブをスペースに置き換え
	let l:exe_sql = @@
	let l:exe_sql = substitute(l:exe_sql, "\n", " ", "g")

	let l:exe_type = "execute_sql"

	py3file $HOME/vimfiles/python/sqlite3.py

	" SQLの結果を表示する
	call PasteResultWindow()

	" 出力結果を整形する
	execute '%s/),(/)\r(/g'

endfunction

function! ExplorerSqlite3()

	" Sqlite3用のタブを生成
	execute 'tabnew'
	let g:win_exe_sql = win_getid()
	execute 'new'
	let g:win_result_sql = win_getid()

	if win_gotoid(g:win_exe_sql) == 0
		echo "初期化に失敗しました。"
	endif

endfunction

function! PasteResultWindow()

	" SQL結果ウィンドウに移動
	if win_gotoid(g:win_result_sql) == 1

		" 画面の内容を全消去
		execute '%d'

		" 選択領域用レジスタにSQL結果をコピーし、貼り付ける
		let @+ = s:result_select
		normal p

	else 
		echo "結果画面が存在しません。"

	endif

endfunction

" 株式機能を呼び出す。
noremap <leader>stock :call ScrapDailyDataFromYahooFinance()<CR>

let g:sqlite3_path = $HOME . "/vimfiles/db/Finance.sqlite3"

function! ScrapDailyDataFromYahooFinance()

	echo "1:デイリーデータ取得　2:データ参照　3:データ初期化"
	let s:user_input = input(">>> ")

	if s:user_input == "1"
		let s:stock_code = input("銘柄コード >>> ")
		echo "\n"

		if s:stock_code != ""
			py3file $HOME/vimfiles/python/scrap.py
		endif
	
	elseif s:user_input == "2"
		echo "\n"
		echo "1:daily_data　2:owned_stock"
		let s:user_input = input(">>> ")
		echo "\n"

		if s:user_input == "1"
		
			let s:stock_code = input("銘柄コード >>> ")
			echo "\n"

			if s:stock_code != ""
				let s:exec_type = "ref"
				let s:table_name = "daily_data"
				py3file $HOME/vimfiles/python/util_db.py
			endif

		elseif s:user_input == "2"

			let s:exec_type = "ref"
			let s:table_name = "owned_stock"
			py3file $HOME/vimfiles/python/util_db.py

		endif
	
		" vim-table-modeを有効化
		TableModeEnable

		" データを貼り付ける
		normal p
		normal o||
		normal 0k

	elseif s:user_input == "3"
		let s:stock_code = input("本当に初期化しますか(y/n)？ >>> ")
		echo "\n"

		if s:stock_code == "y"
			let s:exec_type = "init_table"
			py3file $HOME/vimfiles/python/util_db.py

			echo "初期化しました。"
		else
			echo "中断しました。"

		endif
	
	endif

endfunction



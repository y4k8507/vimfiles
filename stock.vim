" 株式機能を呼び出す。
noremap <leader>stock :call ScrapDailyDataFromYahooFinance()<CR>

let g:sqlite3_path = $HOME . "/vimfiles/db/Finance.sqlite3"

function! ScrapDailyDataFromYahooFinance()

	echo "1:デイリーデータ取得　2:データ参照"
	let s:user_input = input(">>> ")

	if s:user_input == "1"
		let s:stock_code = input("銘柄コード >>> ")
		echo "\n"

		if s:stock_code != ""
			py3file $HOME/vimfiles/python/scrap.py
		endif
	
	elseif s:user_input == "2"
		let s:stock_code = input("銘柄コード >>> ")
		echo "\n"

		if s:stock_code != ""
			py3file $HOME/vimfiles/python/util_db.py
		endif

		" vim-table-modeを有効化
		TableModeEnable

		" データを貼り付ける
		normal p
		normal o||
		normal 0k
	
	endif

endfunction



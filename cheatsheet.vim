function! CheatGrep()
	" キーワードを入力
	let s:user_input = input("Grepキーワード >>> ")
	echo "\n"

	" vimgrepコマンドを実行
	if s:user_input != ""
		execute 'vim ' . s:user_input . ' C:/Users/User/cheatsheet/**.*'
	endif
endfunction

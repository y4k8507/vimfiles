" チートシートをgrepをする
noremap <leader>cg :call CheatGrep()<CR>

" チートシートを参照するタブを開く
noremap <leader>ce :call ExplorerCheatSheet()<CR>

function! CheatGrep()
	" キーワードを入力
	let s:user_input = input("Grepキーワード >>> ")
	echo "\n"

	" vimgrepコマンドを実行
	if s:user_input != ""
		execute 'vim ' . s:user_input . ' $HOME/cheatsheet/**/*'
	endif
endfunction

function! ExplorerCheatSheet()
	" 新しいタブを開く
	execute 'tabnew'

	" lcdを実行する
	execute 'lcd ' $HOME . '/cheatsheet'

endfunction

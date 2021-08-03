" ショートカットキーの設定
vnoremap <leader>gh :<C-U>call GrepSelectKeyword()<CR>

function! GrepSelectKeyword()
	
	" 選択行の文字列を無名レジスタに取得
	silent normal gvy

	let l:grep_keyword = @"
	echo l:grep_keyword

	" vimgrepコマンドを実行
	" カレントフォルダ以降の全ファイルを検索対象とする。
	execute 'vim ' . l:grep_keyword . ' **/*'

endfunction

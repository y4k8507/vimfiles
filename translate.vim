" 翻訳内容の設定
let g:trans_src="en"
let g:trans_dest="ja"

function! TransNormalMode()
	
	" 翻訳実行
	call Trans("")

endfunction

function! TransVisualMode()
	
	" 選択行の文字列を無名レジスタに取得
	silent normal gvy

	" 改行とタブをスペースに置き換え
	let l:sentence = @@
	let l:sentence = substitute(l:sentence, "\n", " ", "g")
	let l:sentence = substitute(l:sentence, "\t", " ", "g")

	" 翻訳実行
	call Trans(l:sentence)

endfunction

function! Trans(sentence)

	" 呼び出し元から翻訳元の指定があった場合
	if a:sentence != ""
		let s:user_input = a:sentence

	else
		" 翻訳内容を入力
		if g:trans_src == "en" && g:trans_dest == "ja"
			let s:user_input = input("翻訳(英語 -> 日本語) >>> ")
			echo "\n"

		elseif g:trans_src == "ja" && g:trans_dest == "en"
			let s:user_input = input("翻訳(日本語 -> 英語) >>> ")
			echo "\n"

		endif

	endif

	" Pythonを実行
	if s:user_input != ""
		py3file $HOME/vimfiles/python/trans.py

		" リターン結果をレジスタに設定
		let @* = g:trans_ret
	endif

endfunction

function! SetTransConfig()

	echo "1:英語 -> 日本語　2:日本語 -> 英語"
	let s:user_input = input(">>> ")
	echo "\n"

	if s:user_input == "1"
		let g:trans_src="en"
		let g:trans_dest="ja"
		echo "英語 -> 日本語で設定しました。"

	elseif s:user_input == "2"
		let g:trans_src="ja"
		let g:trans_dest="en"
		echo "日本語 -> 英語で設定しました。"

	endif

endfunction

function! DisplayTransConfig()

	if g:trans_src == "ja" && g:trans_dest == "en"
		echo "翻訳設定：日本語 -> 英語"

	elseif g:trans_src == "en" && g:trans_dest == "ja"
		echo "翻訳設定：英語 -> 日本語"

	endif

endfunction

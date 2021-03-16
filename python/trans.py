# require pip install googletrans==4.0.0rc1

from googletrans import Translator
import vim

sentence = vim.eval("s:user_input")
trans_src = vim.eval("s:trans_src")
trans_dest = vim.eval("s:trans_dest")

translator = Translator()

trans_sentence = translator.translate(sentence, src=trans_src, dest=trans_dest)
print(trans_sentence.text)

vim.command('let g:trans_ret = "' + trans_sentence.text + '"')

# require pip install googletrans==4.0.0rc1

from googletrans import Translator
import vim

sentence = vim.eval("s:user_input")

translator = Translator()

trans_sentence = translator.translate(sentence, src="en", dest="ja")
print(trans_sentence.text)

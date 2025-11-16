" MIT License
"
" Copyright (c) 2025 DuckAfire <https://duckafire.gitlab.io>
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

fu! s:GetText(arg)
	" -1: null
	"  0: buffer start
	"  1: between buffer content
	"  2: buffer end
	let l:code = -1
	let l:text = v:null

	if a:arg == "xhtml"
		let l:code = 0
		let l:text = [
			\ "<?xml version=\"1.0\" encoding=\"utf-8\"?>",
			\ "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">",
			\ "<html>",
			\ "<head>",
			\ "\t<title><title>",
			\ "\t<link rel=\"icon\" href=\"\"/>",
			\ "\t<meta charset=\"utf-8\"/>",
			\ "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>",
			\ "</head>",
			\ "<body>",
			\ "\t<!-- code -->",
			\ "</body>",
			\ "</html>",
		\ ]

	elseif a:arg == "lorem"
		let l:code = 1
		let l:text = "Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti" .
				\ "ultricies inceptos, quam facilisis aliquam vehicula quis." .
				\ "Laoreet proin magna inceptos senectus lorem. Penatibus etiam" .
				\ "metus quam sodales nisi. Pellentesque mattis ligula habitasse" .
				\ "sed eleifend massa hendrerit accumsan. Venenatis sed penatibus" .
				\ "justo sagittis laoreet malesuada elementum. Auctor adipiscing" .
				\ "conubia phasellus; aptent habitasse accumsan. Diam inceptos" .
				\ "finibus magna imperdiet gravida molestie consequat himenaeos." .
				\ "Imperdiet suscipit natoque sem tellus ut; vel urna. Vulputate" .
				\ "cubilia sodales risus at eget et sociosqu lacus commodo."

	elseif a:arg == "breaked-lorem" || a:arg == "b-lorem" || a:arg == "blorem"
		let l:code = 1
		let l:text = [
			\"Lorem ipsum odor amet, consectetuer adipiscing elit. Potenti",
			\ "ultricies inceptos, quam facilisis aliquam vehicula quis.",
			\ "Laoreet proin magna inceptos senectus lorem. Penatibus etiam",
			\ "metus quam sodales nisi. Pellentesque mattis ligula habitasse",
			\ "sed eleifend massa hendrerit accumsan. Venenatis sed penatibus",
			\ "justo sagittis laoreet malesuada elementum. Auctor adipiscing",
			\ "conubia phasellus; aptent habitasse accumsan. Diam inceptos",
			\ "finibus magna imperdiet gravida molestie consequat himenaeos.",
			\ "Imperdiet suscipit natoque sem tellus ut; vel urna. Vulputate",
			\ "cubilia sodales risus at eget et sociosqu lacus commodo.",
		\ ]
	else
		echoerr "Invalid argument: \"" . a:arg . "\". Try: xhtml (default); lorem; b[[reaked]-]lorem."
	end

	return [ l:code, l:text ]
endf

fu! s:InsertText(append, line, text)
	if type(a:text) == v:t_string
		if a:append == v:true
			call append(a:line, a:text)
			return
		endif

		call setline(a:line, a:text)
		return
	endif

	let l:line = a:line
	for l:chunk in a:text
		call append(l:line, l:chunk)
		let l:line += 1
	endfor
endf

fu! s:PasteTextOnCurrentBuffer(...)
	let l:arg  = "xhtml"

	if a:0 > 0
		let l:arg = a:1

		if a:0 > 1
			echoerr "Only the first argument was used."
			echoerr "Other ones were ignored."
		endif
	endif

	let l:content = s:GetText(l:arg)
	let l:code    = l:content[0]
	let l:text    = l:content[1]
	let l:T_TEXT  = type(l:text)

	if l:T_TEXT == v:t_none
		return
	endif

	if l:code == 0
		call s:InsertText(v:true, 0, l:text)
		return
	endif

	if l:code == 1
		" number
		let l:cursor_line   = line(".")
		let l:cursor_column = col(".")

		if l:T_TEXT == v:t_list
			call s:InsertText(v:false, l:cursor_line, l:text)
			return
		endif

		" string
		let l:current_line  = getline( l:cursor_line )
		let l:before_cursor = l:current_line[ :(l:cursor_column - 2) ]
		let l:after_cursor  = l:current_line[  (l:cursor_column - 1): ]

		let l:full_text = l:before_cursor . l:text . l:after_cursor

		call s:InsertText(v:false, l:cursor_line, l:full_text)
		return
	endif

	" l:code == 2
	" comming soon...
endf

command! -nargs=? WebSetPaste :call s:PasteTextOnCurrentBuffer(<f-args>)

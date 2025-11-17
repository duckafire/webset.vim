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

fu! g:FormatHTMLTag(style)
	let l:cursor_line = line(".")
	let l:cursor_line_content = getline( l:cursor_line )

	let l:tag = matchstr( l:cursor_line_content, '\S\+' )

	if a:style == 0
		call setline( l:cursor_line, "<" . l:tag . "></" . l:tag . ">")
		normal ^
		normal e
		normal l

	elseif a:style == 1
		call setline( l:cursor_line, "<"  . l:tag . ">")
		call append(  l:cursor_line, "</" . l:tag . ">" )
		normal $

	elseif a:style == 2
		call setline( l:cursor_line, "<" . l:tag . "/>" )
		normal $
		normal 2h
	endif
endfu

" call `:echo get(g:, "mapleader", "DEFAULT")`
" to check `mapleader` value. If it is undefined,
" `"DEFAULT"` will be returned.
"
" Void container;
" opened Container;
" No-Container;
nnoremap <Leader>wv :call g:FormatHTMLTag(0)<CR>
nnoremap <Leader>wc :call g:FormatHTMLTag(1)<CR>
nnoremap <Leader>wn :call g:FormatHTMLTag(2)<CR>

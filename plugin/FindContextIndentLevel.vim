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

fu! g:FindContextIndentLevel()
	let l:adj_cursor_line     = 0
	let l:cursor_line         = v:null
	let l:cursor_line_content = v:null

	" do-while be like
	while v:true
		let l:cursor_line = line(".") - l:adj_cursor_line
		let l:cursor_line_content = getline( l:cursor_line )

		if l:cursor_line == 0 || match( l:cursor_line_content, '\S' ) != -1
			break
		endif
		
		let l:adj_cursor_line += 1
	endwh

	if l:cursor_line == 0
		return ["", 0]
	endif

	let l:literal_indent_level = matchstr( l:cursor_line_content, '\v^(\t| )+' )
	let l:indent_level = len( l:literal_indent_level )

	return [l:literal_indent_level, l:indent_level]
endfu

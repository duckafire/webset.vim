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

" Spec  : Special
" Dtype : Doctype
" Cont  : Container(s)
" Attr  : Attribute(s)

augroup FILE_TYPE_HTML_TO_XHTML
	autocmd!
	autocmd BufRead,BufNewFile *.html set filetype=xhtml
	autocmd FileType html             set filetype=xhtml
augroup END

for group in ["Arg","CssDefinition","H3","ItalicBoldUnderline","PreProcAttrName","StyleArg","UnderlineItalic","Bold","CssStyleComment","H4","ItalicUnderline","PreStmt","Tag","UnderlineItalicBold","BoldItalic","EndTag","H5","ItalicUnderlineBold","ScriptTag","TagError","Value","BoldItalicUnderline","Error","H6","LeadingSpace","Special","TagN","BoldUnderline","Event","Head","Link","SpecialChar","TagName","BoldUnderlineItalic","EventDQ","Highlight","PreAttr","SpecialTagName","Title","Comment","EventSQ","HighlightSkip","PreError","Statement","Underline","CommentError","H1","Italic","PreProc","Strike","UnderlineBold","CommentPart","H2","ItalicBold","PreProcAttrError","String","UnderlineBoldItalic"]
	exec "sy  clear html" . group
	exec "hi! clear html" . group
endfor

" tag regions
sy region xhtmlContTag matchgroup=xhtmlContTagStyle start='<' end='>' oneline
	\ contains=xhtmlContTagName,xhtmlSpecContTagName,xhtmlOperator,@xhtmlTagAttr,xhtmlTagAttrValue,xhtmlUrl

sy region xhtmlNoContTag matchgroup=xhtmlNoContTagStyle start='<' end='/>' oneline
	\ contains=xhtmlNoContTagName,xhtmlOperator,@xhtmlTagAttr,xhtmlTagAttrValue

sy region xhtmlContTagEnd matchgroup=xhtmlContTagStyle start='</' end='>' oneline
	\ contains=xhtmlContTagName,xhtmlSpecContTagName,xhtmlUrl

sy region xhtmlXmlNoContTag matchgroup=xhtmlXmlNoContTagStyle start='\%1l<?' end='?>' oneline
	\ contains=xhtmlXmlTagName,xhtmlXmlTagAttr,xhtmlXmlTagAttr

sy region xhtmlDtypeNoContTag matchgroup=xhtmlDtypeNoContTagStyle start='\%<3l<!' end='>' oneline
	\ contains=xhtmlDtypeTagName,xhtmlDtypeUrl,xhtmlDtypeTagAttrValue

hi! def xhtmlContTagStyle        ctermfg=blue     ctermbg=none cterm=bold
hi! def xhtmlNoContTagStyle      ctermfg=cyan     ctermbg=none cterm=bold
hi! def xhtmlXmlNoContTagStyle   ctermfg=darkgray ctermbg=none cterm=bold
hi! def xhtmlDtypeNoContTagStyle ctermfg=darkgray ctermbg=none cterm=bold

" tag names
sy keyword xhtmlContTagName     contained a abbr address article audio b bdi bdo blockquote button canvas caption cite code colgroup datalist dd del details dfn
sy keyword xhtmlContTagName     contained dialog div dl dt em fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 header hgroup i iframe ins kbd label legend li main map
sy keyword xhtmlContTagName     contained mark meter nav object ol optgroup option output p picture pre progress q rp rt ruby samp section select small span strong sub summary
sy keyword xhtmlContTagName     contained sup table tbody td template textarea tfoot th thead time tr ul vari video
" This match below allows that these tag
" name can be overlaped by an attribute
" named as `data` or `data-*`. This was
" written because keywords have priority
" over matches (and regions; run:
" `:h syn-priority`).
sy match   xhtmlContTagName     contained 'data'
sy keyword xhtmlNoContTagName   contained area base br col hr img input link meta source track wbr
sy keyword xhtmlSpecContTagName contained html head title style body script noscript
sy keyword xhtmlXmlTagName      contained xml
sy keyword xhtmlDtypeTagName    contained DOCTYPE html PUBLIC

" attributes
sy cluster xhtmlTagAttr contains=xhtmlStdTagAttr,xhtmlDataTagAttr,xhtmlAriaTagAttr

sy keyword xhtmlStdTagAttr contained abbr above accesskey action align alink allowfullscreen alt archive async autocomplete autofocus autoplay axis background below bgcolor
sy keyword xhtmlStdTagAttr contained border bordercolor cellpadding cellspacing challenge char charoff checked cite class classid clear clip code codebase codetype color cols
sy keyword xhtmlStdTagAttr contained colspan compact content contenteditable contextmenu controls coords crossorigin datetime declare default defer dialog dir dirname disabled
sy keyword xhtmlStdTagAttr contained download draggable dropzone enctype face for form formaction formenctype formmethod formnovalidate formtarget frame frameborder gutter headers
sy keyword xhtmlStdTagAttr contained height hidden high href hreflang hspace ht icon id id inputmode ismap keytype kind lang language left link list longdesc loop low lowsrc marginheight
sy keyword xhtmlStdTagAttr contained marginwidth max maxlength media method min minlength multiple muted name nohref nonce noresize noshade novalidate nowrap object open optimum pagex
sy keyword xhtmlStdTagAttr contained pagey pattern placeholder poster preload profile prompt radiogroup readonly rel required rev reversed role rows rowspan rules sandbox scheme scope
sy keyword xhtmlStdTagAttr contained scrolling selected shape size sizes span spellcheck src srcdoc srclang srcset standby start step style tabindex target text title top
sy keyword xhtmlStdTagAttr contained translate type typemustmatch url usemap valign value valuetype version visibility vlink vspace width wrap
" This match below allows that these tag
" name can be overlaped by an attribute
" named as ``data-*`. This was written
" because keywords have priority over
" matches (and regions; run:
" `:h syn-priority`).
sy match   xhtmlStdTagAttr contained 'data'
sy match   xhtmlStdTagAttr contained /\v%(summary|accept-charset|accept|charset|z-index|http-equiv)/
sy match  xhtmlDataTagAttr contained /\v<data\-%(\w|\-)*/
sy match  xhtmlAriaTagAttr contained /\v<aria\-%(activedescendant|atomic|autocomplete|busy|checked|col%(count|index|span)|controls|current|describedby|details|disabled|dropeffect)/
sy match  xhtmlAriaTagAttr contained /\v<aria\-%(errormessage|expanded|flowto|grabbed|haspopup|hidden|invalid|keyshortcuts|label%(ledby)?|level|live|modal|multi%(line|selectable))/
sy match  xhtmlAriaTagAttr contained /\v<aria\-%(orientation|owns|placeholder|posinset|pressed|readonly|relevant|required|roledescription|row%(count|index|span)|selected|setsize)/
sy match  xhtmlAriaTagAttr contained /\v<aria\-%(sort|value%(max|min|now|text))/
sy match  xhtmlXmlTagAttr  contained /\v\c<encoding\="%(ascii|utf-8)"/
sy match  xhtmlXmlTagAttr  contained /\v\c<standalone\="%(yes|no)"/
sy match  xhtmlXmlTagAttr  contained /\v\c<version\="\d+%(\.\d+(\.\d+)?)?"/

hi! def xhtmlStdTagAttr  ctermfg=green    ctermbg=none cterm=none
hi! def xhtmlDataTagAttr ctermfg=green    ctermbg=none cterm=italic
" xhtmlAriaTagAttr
hi! def xhtmlXmlTagAttr  ctermfg=darkgray ctermbg=none cterm=none

hi! def link xhtmlAriaTagAttr xhtmlStdTagAttr

hi! def xhtmlContTagName        ctermfg=blue     ctermbg=none cterm=none
hi! def xhtmlNoContTagName      ctermfg=cyan     ctermbg=none cterm=none
hi! def xhtmlSpecContTagName    ctermfg=blue     ctermbg=none cterm=bold
hi! def xhtmlXmlTagName         ctermfg=darkgray ctermbg=none cterm=bold
hi! def xhtmlDtypeTagName       ctermfg=darkgray ctermbg=none cterm=bold

" other regions
sy region xhtmlComment           start=/<!--/ end=/-->/            keepend
sy region xhtmlTagAttrValue      start=/"/    end=/"/   skip=/\\"/         oneline contained contains=xhtmlUrl
sy region xhtmlDtypeTagAttrValue start=/"/    end=/"/   skip=/\\"/         oneline contained contains=xhtmlDtypeUrl

hi! def xhtmlComment           ctermfg=darkgray ctermbg=none cterm=none
hi! def xhtmlTagAttrValue      ctermfg=magenta  ctermbg=none cterm=none
hi! def xhtmlDtypeTagAttrValue ctermfg=darkgray ctermbg=none cterm=italic

" miscellaneous
sy match xhtmlOperator contained /\v[=]/
sy match xhtmlCharCode           /\v\&(\l+|#\d+);/
sy match xhtmlUrl      contained /\vhttps?:\/\/[^"]*/
sy match xhtmlDtypeUrl contained /\vhttps?:\/\/[^"]*/

hi! def xhtmlOperator ctermfg=yellow   ctermbg=none cterm=none
hi! def xhtmlCharCode ctermfg=red      ctermbg=none cterm=none
hi! def xhtmlUrl      ctermfg=magenta  ctermbg=none cterm=underline
hi! def xhtmlDtypeUrl ctermfg=darkgray ctermbg=none cterm=italic,underline

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
" Cont  : Container
" Attr  : Attribute

" MISCELLANOUS LOGIC
fu! g:FileTypeHtmlToXhtml()
	set filetype=xhtml

	for group in ["Arg","CssDefinition","H3","ItalicBoldUnderline","PreProcAttrName","StyleArg","UnderlineItalic","Bold","CssStyleComment","H4","ItalicUnderline","PreStmt","Tag","UnderlineItalicBold","BoldItalic","EndTag","H5","ItalicUnderlineBold","ScriptTag","TagError","Value","BoldItalicUnderline","Error","H6","LeadingSpace","Special","TagN","BoldUnderline","Event","Head","Link","SpecialChar","TagName","BoldUnderlineItalic","EventDQ","Highlight","PreAttr","SpecialTagName","Title","Comment","EventSQ","HighlightSkip","PreError","Statement","Underline","CommentError","H1","Italic","PreProc","Strike","UnderlineBold","CommentPart","H2","ItalicBold","PreProcAttrError","String","UnderlineBoldItalic"]
		exec "sil! sy  clear html" . group
		exec "sil! hi! clear html" . group
	endfo
endfu

augroup FILE_TYPE_HTML_TO_XHTML
	autocmd!
	autocmd BufRead,BufNewFile *.html call g:FileTypeHtmlToXhtml()
	autocmd FileType html             call g:FileTypeHtmlToXhtml()
augroup END

" ERRORS
sy match xhtmlTextContentError /\v[<>]/

sy cluster xhtmlTagError contains=xhtmlTagAttrError,xhtmlTagAttrValueError

hi! def xhtmlError ctermfg=red ctermbg=white cterm=standout,bold

hi! def link xhtmlTextContentError  xhtmlError

" HTML TAGS
sy region xhtmlContTag matchgroup=xhtmlContTagStyle end='>' contains=@xhtmlTagThings,@xhtmlTagError
	\ start='\v\<%(abbr|address|article|audio|blockquote|button|canvas|cite|code|colgroup|del|details|dfn|dialog|div|em|fieldset|figure|footer|form|header|hgroup|iframe|ins|kbd|label)>'
	\ start='\v\<%(legend|meter|nav|object|output|picture|pre|progress|ruby|samp|section|select|small|span|strong|sub|summary|sup|table|template|textarea|time|var|video|data%(list)?)>'
	\ start='\v\<%(opt%(group|ion)|t%(head|body|foot|[dhr])|%(fig)?caption|ma%(in|p|rk)|b%(d[io])?|r[pt]|h[1-6]|d[ltd]|[ou]l|[apq]|l?i)>'

sy region xhtmlSpecContTag matchgroup=xhtmlSpecContTagStyle contains=@xhtmlTagThings,@xhtmlTagError end='>' start='\v\<%(html|head|title|style|body|%(no)?script)>'
sy region xhtmlNoContTag matchgroup=xhtmlNoContTagStyle contains=@xhtmlTagThings end='/>' start='\v\<%(area|base|col|img|input|link|meta|source|track|%(h|w?b)r)>'

sy region xhtmlXmlNoContTag   matchgroup=xhtmlXmlNoContTagStyle   start='\%1l<?xml'           end='?>' oneline contains=xhtmlXmlTagAttr
sy region xhtmlDtypeNoContTag matchgroup=xhtmlDtypeNoContTagStyle start='\%<3l<!DOCTYPE html' end='>'  oneline

sy match xhtmlContTagEnd '\v\</%(h[1-6]|d[ltd]|figure|%(fig)?caption|b%(d[io])?|l?i|r[pt]|t%(head|body|foot|[dhr])|[ou]l|data%(list)?|opt%(group|ion)|[apq]|ma%(in|p|rk)|abbr|address)\>'
sy match xhtmlContTagEnd '\v\</%(article|audio|blockquote|button|canvas|cite|code|colgroup|del|details|dfn|dialog|div|em|fieldset|footer|form|header|hgroup|iframe|ins|kbd|label|legend)\>'
sy match xhtmlContTagEnd '\v\</%(meter|nav|object|output|picture|pre|progress|ruby|samp|section|select|small|span|strong|sub|summary|sup|table|template|textarea|time|var|video)\>'

sy match xhtmlSpecContTagEnd '\v\</%(html|head|title|style|body|%(no)?script)\>'

hi! def xhtmlContTagStyle        ctermfg=blue     ctermbg=none cterm=none
hi! def xhtmlSpecContTagStyle    ctermfg=blue     ctermbg=none cterm=bold
hi! def xhtmlNoContTagStyle      ctermfg=cyan     ctermbg=none cterm=none
hi! def xhtmlXmlNoContTagStyle   ctermfg=darkgray ctermbg=none cterm=bold
hi! def xhtmlDtypeNoContTagStyle ctermfg=darkgray ctermbg=none cterm=bold

hi! xhtmlDtypeNoContTag ctermfg=darkgray ctermbg=none cterm=italic

hi! def link xhtmlContTagEnd     xhtmlContTagStyle
hi! def link xhtmlSpecContTagEnd xhtmlSpecContTagStyle

" COMMENTS
sy region xhtmlComment start='<!--' end='-->' contains=xhtmlCommentTitle,xhtmlCommentTag

sy match   xhtmlCommentTitle contained /\v%(^|\<!\-\-)\s*\zs(\u|\s)+:/
sy keyword xhtmlCommentTag   contained CAUTION DEBUG EDIT NOTE TODO WARN WARNING

hi! def xhtmlComment      ctermfg=darkgray ctermbg=none  cterm=none
hi! def xhtmlCommentTitle ctermfg=cyan     ctermbg=none  cterm=none
hi! def xhtmlCommentTag   ctermfg=yellow   ctermbg=black cterm=standout,bold

" TAGS ATTRIBUTES
sy cluster xhtmlTagThings
	\ contains=xhtmlStdTagAttr,xhtmlDataTagAttr,xhtmlAriaTagAttr,xhtmlTagAttrValue,xhtmlOperator,xhtmlPropertyOG

"   `data` is below, as a match instead a keyword,
" for it to be overlaped by a `data-*` attribute.
" It could not occur if it is a keyword, because
" they have priority over matches (and regions).
"   Other ones are here because keyword only can
" contain characters present in `iskeyword` or
" because they have some conflict with other
" attribute(s) present here.
"   See:
"     :h syn-priority
"     :h syn-keyword
"     :set iskeyword?
sy match   xhtmlStdTagAttr contained /\v%(accept-charset|accept|charset|data|http-equiv|summary|z-index)/
sy keyword xhtmlStdTagAttr contained abbr above accesskey action align alink allowfullscreen alt archive async autocomplete autofocus autoplay axis background below bgcolor
sy keyword xhtmlStdTagAttr contained border bordercolor cellpadding cellspacing challenge char charoff checked cite class classid clear clip code codebase codetype color cols
sy keyword xhtmlStdTagAttr contained colspan compact content contenteditable contextmenu controls coords crossorigin datetime declare default defer dialog dir dirname disabled
sy keyword xhtmlStdTagAttr contained download draggable dropzone enctype face for form formaction formenctype formmethod formnovalidate formtarget frame frameborder gutter headers
sy keyword xhtmlStdTagAttr contained height hidden high href hreflang hspace ht icon id inputmode integrity ismap keytype kind label lang language left link list longdesc loop low lowsrc marginheight
sy keyword xhtmlStdTagAttr contained marginwidth max maxlength media method min minlength multiple muted name nohref nomodule nonce noresize noshade novalidate nowrap object open optimum pagex
sy keyword xhtmlStdTagAttr contained pagey pattern placeholder poster preload profile prompt radiogroup readonly rel required rev reversed role rows rowspan rules sandbox scheme scope
sy keyword xhtmlStdTagAttr contained scrolling selected shape size sizes span spellcheck src srcdoc srclang srcset standby start step style summary tabindex target text title top
sy keyword xhtmlStdTagAttr contained translate type typemustmatch url usemap valign value valuetype version visibility vlink vspace width wrap

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
hi! def xhtmlXmlTagAttr  ctermfg=darkgray ctermbg=none cterm=none

hi! def link xhtmlAriaTagAttr xhtmlStdTagAttr

" MISCELLANEOUS MATCHES
sy region xhtmlTagAttrValue start=/"/ end=/"/ skip=/[^\\]\\"/ oneline contained contains=xhtmlUrl
sy region xhtmlPropertyOG   matchgroup=xhtmlPropertyOGStyle start=/\v<property\="[a-zA-Z_-]+:/ end=/"/ skip=/[^\\]\\"/ contained

sy match xhtmlOperator contained /\v[=]/
sy match xhtmlCharCode           /\v\&(\l+|#\d+);/
sy match xhtmlUrl      contained /\vhttps?:\/\/[^"]*/

hi! def xhtmlPropertyOGStyle ctermfg=yellow ctermbg=none cterm=none

hi! def xhtmlTagAttrValue ctermfg=magenta ctermbg=none cterm=none
hi! def xhtmlOperator     ctermfg=yellow  ctermbg=none cterm=none
hi! def xhtmlCharCode     ctermfg=red     ctermbg=none cterm=none
hi! def xhtmlUrl          ctermfg=magenta ctermbg=none cterm=underline

hi! def link xhtmlPropertyOG xhtmlTagAttrValue

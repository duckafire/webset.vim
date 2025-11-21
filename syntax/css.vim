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

" Spec   : Special
" Select : Select(or)
" Func   : Function
" Attr   : Atribute

" MISCELLANOUS LOGIC
fu g:ClearCssHighlight()
	for group in ["AnimationAttr","Color","FunctionName","MarqueeAttr","PseudoClass","TransformAttr","AnimationProp","ColorProp","GeneratedContentAttr","MarqueeProp","PseudoClassFn","TransformProp","AtKeyword","Comment","GeneratedContentProp","MediaAttr","PseudoClassId","TransitionAttr","AtRule","CommonAttr","GradientAttr","MediaComma","PseudoClassLang","TransitionProp","AtRuleLogical","ContentForPagedMediaAttr","GridAttr","MediaProp","RenderAttr","UIAttr","Attr","ContentForPagedMediaProp","GridProp","MediaType","RenderProp","UIProp","AttrComma","Definition","Hacks","MobileTextProp","RubyAttr","URL","AttrRegion","Deprecated","HyerlinkAttr","MultiColumnAttr","RubyProp","UnicodeEscape","AttributeSelector","DimensionAttr","HyerlinkProp","MultiColumnProp","SelectorOp","UnicodeRange","AuralAttr","DimensionProp","IEUIAttr","Noise","SelectorOp2","UnitDecorators","AuralProp","Error","IEUIProp","PaddingAttr","SpecialCharQ","ValueAngle","BackgroundAttr","FlexibleBoxAttr","Identifier","PageMarginProp","SpecialCharQQ","ValueFrequency","BackgroundProp","FlexibleBoxProp","Important","PageProp","SpeechAttr","ValueInteger","BorderAttr","FontAttr","InteractAttr","PagePseudo","SpeechProp","ValueLength","BorderProp","FontDescriptor","InteractProp","PagedMediaAttr","StringQ","ValueNumber","BoxAttr","FontDescriptorAttr","KeyFrameProp","PagedMediaProp","StringQQ","ValueTime","BoxProp","FontDescriptorBlock","LineboxAttr","PositioningAttr","TableAttr","Vendor","BraceError","FontDescriptorProp","LineboxProp","PositioningProp","TableProp","Braces","FontProp","ListAttr","PrintAttr","TagName","ClassName","Function","ListProp","PrintProp","TextAttr","ClassNameDot","FunctionComma","MarginAttr","Prop","TextProp"]
		exec "sy  clear css" . group
		exec "hi! clear css" . group
	endfo
endfu

augroup CLEAR_CSS_HIGHLIGHT
	autocmd!
	autocmd BufRead,BufNewFile *.css call g:ClearCssHighlight()
	autocmd FileType css             call g:ClearCssHighlight()
augroup END

" SELECTORS
" Using match, instead keyword, to allow
" that other matches can replace these.
sy match cssHtmlElement  /\v<%(h[1-6]|d[ltd]|figure|%(fig)?caption|b%(d[io])?|l?i|r[pt]|t%(head|body|foot|[dhr])|[ou]l|data%(list)?|opt%(group|ion)|[apq]|ma%(in|p|rk)|abbr|address)>/
sy match cssHtmlElement  /\v<%(article|audio|blockquote|button|canvas|cite|code|colgroup|del|details|dfn|dialog|div|em|fieldset|footer|form|header|hgroup|iframe|ins|kbd|label|legend)>/
sy match cssHtmlElement  /\v<%(meter|nav|object|output|picture|pre|progress|ruby|samp|section|select|small|span|strong|sub|summary|sup|table|template|textarea|time|var|video)>/
sy match cssHtmlElement  /\v<%(html|head|title|style|body|%(no)?script|area|base|col|img|input|link|meta|source|track|%(h|w?b)r)>/
sy match cssElementId    /\v#\h%(\w|\-)*\ze%([^A-Za-z0-9_\-]|$)/
sy match cssElementClass /\v\.\h%(\w|\-)*\ze%([^A-Za-z0-9_\-]|$)/
sy match cssSpecSelect   /\v[&*]/

hi! def cssHtmlElement  ctermfg=blue  ctermbg=none cterm=none
hi! def cssElementId    ctermfg=red   ctermbg=none cterm=none
hi! def cssElementClass ctermfg=green ctermbg=none cterm=none
hi! def cssSpecSelect   ctermfg=blue  ctermbg=none cterm=bold

" OPERATORS
" [iI] : case-insensitive | [sS] : case-sensitive
sy region cssAttrSelectRegion matchgroup=cssAttrSelectRegionStyle start='\[' end='\v%(%(\s|")[iIsS])?\]'
	\ contains=cssAttrSelectOperator,cssAttrSelectSpecAttr,cssAttrSelectValue
sy region cssFuncRegion       matchgroup=cssFuncRegionStyle       start='('  end=')'
sy region cssRulesRegion      matchgroup=cssRulesRegionStyle      start='{'  end='}'

sy match cssOperator /\v[,:;+~>]/

sy match  cssAttrSelectOperator contained /\v[~|^$*]?\=/ contains=cssAttrSelectValue
sy match  cssAttrSelectSpecAttr contained /\vdata\-%(\w|\-)*/
sy region cssAttrSelectValue    matchgroup=cssOperator contained start='="\?' end='\v"?%( [iIsS]?|[iIsS]?\])'

hi! def cssOperator           ctermfg=yellow  ctermbg=none cterm=none
hi! def cssRulesRegionStyle   ctermfg=yellow  ctermbg=none cterm=bold
hi! def cssAttrSelectSpecAttr ctermfg=white   ctermbg=none cterm=italic
hi! def cssAttrSelectValue    ctermfg=magenta ctermbg=none cterm=none

hi! def link cssAttrSelectRegionStyle cssOperator
hi! def link cssFuncRegionStyle       cssOperator
hi! def link cssAttrSelectOperator    cssOperator

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

" MISCELLANOUS LOGIC
fu g:ClearCssHighlight()
	for group in ["AnimationAttr","Color","FunctionName","MarqueeAttr","PseudoClass","TransformAttr","AnimationProp","ColorProp","GeneratedContentAttr","MarqueeProp","PseudoClassFn","TransformProp","AtKeyword","Comment","GeneratedContentProp","MediaAttr","PseudoClassId","TransitionAttr","AtRule","CommonAttr","GradientAttr","MediaComma","PseudoClassLang","TransitionProp","AtRuleLogical","ContentForPagedMediaAttr","GridAttr","MediaProp","RenderAttr","UIAttr","Attr","ContentForPagedMediaProp","GridProp","MediaType","RenderProp","UIProp","AttrComma","Definition","Hacks","MobileTextProp","RubyAttr","URL","AttrRegion","Deprecated","HyerlinkAttr","MultiColumnAttr","RubyProp","UnicodeEscape","AttributeSelector","DimensionAttr","HyerlinkProp","MultiColumnProp","SelectorOp","UnicodeRange","AuralAttr","DimensionProp","IEUIAttr","Noise","SelectorOp2","UnitDecorators","AuralProp","Error","IEUIProp","PaddingAttr","SpecialCharQ","ValueAngle","BackgroundAttr","FlexibleBoxAttr","Identifier","PageMarginProp","SpecialCharQQ","ValueFrequency","BackgroundProp","FlexibleBoxProp","Important","PageProp","SpeechAttr","ValueInteger","BorderAttr","FontAttr","InteractAttr","PagePseudo","SpeechProp","ValueLength","BorderProp","FontDescriptor","InteractProp","PagedMediaAttr","StringQ","ValueNumber","BoxAttr","FontDescriptorAttr","KeyFrameProp","PagedMediaProp","StringQQ","ValueTime","BoxProp","FontDescriptorBlock","LineboxAttr","PositioningAttr","TableAttr","Vendor","BraceError","FontDescriptorProp","LineboxProp","PositioningProp","TableProp","Braces","FontProp","ListAttr","PrintAttr","TagName","ClassName","Function","ListProp","PrintProp","TextAttr","ClassNameDot","FunctionComma","MarginAttr","Prop","TextProp"]
		exec "sy  clear css" . group
		exec "hi! clear css" . group
	end
endfu

augroup CLEAR_CSS_HIGHLIGHT
	autocmd!
	autocmd BufRead,BufNewFile *.css call g:ClearCssHighlight()
	autocmd FileType css             call g:ClearCssHighlight()
augroup END

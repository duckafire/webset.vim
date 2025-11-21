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
	\ contains=cssRule,cssValueRegion

sy match cssSelectOperator '[+~>,]'

sy match  cssAttrSelectOperator contained /\v[~|^$*]?\=/ contains=cssAttrSelectValue
sy match  cssAttrSelectSpecAttr contained /\vdata\-%(\w|\-)*/
sy region cssAttrSelectValue    matchgroup=cssSelectOperator contained start='="\?' end='\v"?%( [iIsS]?|[iIsS]?\])'

hi! def cssSelectOperator     ctermfg=yellow  ctermbg=none cterm=none
hi! def cssRulesRegionStyle   ctermfg=blue    ctermbg=none cterm=bold
hi! def cssAttrSelectSpecAttr ctermfg=white   ctermbg=none cterm=italic
hi! def cssAttrSelectValue    ctermfg=magenta ctermbg=none cterm=none

hi! def link cssAttrSelectRegionStyle cssSelectOperator
hi! def link cssFuncRegionStyle       cssSelectOperator
hi! def link cssAttrSelectOperator    cssSelectOperator

" RULES
sy match cssRule contained /\v<%(word\-%(wrap|spacing|break)|voice\-%(stress|rate|range|pitch|family|duration|balance|volume)|display|direction|cursor|crop|contain|content|columns|clear|chains|caption-side)>/
sy match cssRule contained /\v<%(interpolation-mode|isolation|region-fragment|widows|white-space|volume|visibility|vertical-align|user-select|tap-highlight-color|table-layout|tab-size|string-set|speech-rate|size)>/
sy match cssRule contained /\v<%(running|right|richness|resize|position|pointer-events|play-during|osx-font-smoothing|orphans|order|opacity|max-lines|move-to|mix-blend-mode|lighting-color|letter-spacing|left|quotes)>/
sy match cssRule contained /\v<%(presentation-level|stress|height|hanging-punctuation|glyph-orientation-vertical|gap|filter|zoom|z-index|writing-mode|will-change|width|src|fill|empty-cells|elevation|dominant-baseline)>/
sy match cssRule contained /\v<%(unicode\-%(range|bidi)|transition%(\-%(timing\-function|property|duration|delay))?|transform%(\-%(style|origin|box))?|touch\-%(callout|action)|wrap\-%(through|inside|flow|before|after))>/
sy match cssRule contained /\v<text\-%(wrap|underline-position|rendering|overflow|orientation|justify|indent|align%(\-%(last|all))?|combine\-upright|%(emphasis)%(\-%(style|position|color))?|%(decoration)%(\-%(style|skip|line|color))?|transform|spac%(ing|e\-%(trim|collapse))|size\-adjust|shadow)?>/
sy match cssRule contained /\v<%(stroke%(\-%(width|opacity|miterlimit|linejoin|linecap|dash%(offset|corner|array|adjust)|alignment))?|ruby\-%(position|merge|align)|shape\-%(outside|margin|inside|image\-threshold|snap\-%(type|align)))>/
sy match cssRule contained /\v<%(rest%(\-%(before|after))?|speak%(\-%(punctuation|numeral|header|as))?|scroll\-%(behavior|snap\-%(type|align|%(margin|padding)%(\-%(top|right|left|bottom|%(block|inline)%(\-%(start|end))?))?)))>/
sy match cssRule contained /\v<%(rotation%(\-point)?|scrollbar\-%(width|color)|polar\-%(origin|distance|angle|anchor)|pitch%(\-range)?|perspective%(\-origin)?|page%(\-%(policy|break\-%(inside|before|after)))?)>/
sy match cssRule contained /\v<%(pause%(\-%(before|after))?|over%(scroll\-behavior|flow%(\-%(y|x|wrap|style|anchor))?)|outline%(\-%(width|style|offset|color))?|offset\-%(start|end|before|after)|object\-%(position|fit))>/
sy match cssRule contained /\v<%(marquee\-%(style|speed)|motion%(\-%(rotation|path|offset))?|mask%(\-%(type|size|repeat|position|origin|mode|image|composite|clip|border%(\-%(width|source|slice|repeat|outset|mode))?))?)>/
sy match cssRule contained /\v<%(nav-%(up|right|left|down)|%(min|max)\-%(width|height)|marquee\-%(loop|direction)|marker%(\-%(start|side|segment|pattern|mid|knockout\-%(right|left)|end))?|line%(\-%(snap|height|grid|break)))>/
sy match cssRule contained /\v<%(%(%(padding|margin)\-)?%(top|right|bottom|left|block|inline)|%(padding|margin)|list\-style%(\-%(type|position|image))?|justify\-%(self|items|content)|image\-%(resolution|rendering|orientation))>/
sy match cssRule contained /\v<%(initial\-letter%(\-%(wrap|align))?|hyphen%(s|ate\-%(character|limit%(\-%(zone|lines|last|chars))?))|float%(\-%(reference|offset|defer))?|flex%(\-%(wrap|shrink|grow|flow|direction|basis))?)>/
sy match cssRule contained /\v<%(grid%(\-%(template%(\-%(rows|columns|areas))?|%(row|column)%(\-%(start|gap|end))?|gap|auto%(\-%(rows|flow|columns))?|area))?|footnote\-%(policy|display)|flood\-%(opacity|color))>/
sy match cssRule contained /\v<font%(\-%(weight|synthesis|style|stretch|smoothing|size%(\-adjust)?|kerning|family|display|language\-override|feature\-settings|variant%(\-%(position|numeric|ligatures|east\-asian|caps|alternates))?))?>/
sy match cssRule contained /\v<%(cue%(\-%(before|after))?|counter\-%(%(re)?set|increment)|break\-%(inside|before|after)|column%(\-%(width|span|rule%(\-%(width|style|color))?|gap|fill|count))?|flow%(\-%(into|from))?)>/
sy match cssRule contained /\v<%(color%(-interpolation-filters)?|clip%(\-%(rule|path))?|caret%(\-%(shape|color|animation))?|box\-%(suppress|snap|sizing|shadow|decoration\-break)|border\-%(top|bottom)\-%(left|right)\-radius)>/
sy match cssRule contained /\v<%(border\-%(width|style|spacing|radius|image%(\-%(width|source|slice|repeat|outset))?|color|collapse|boundary)|align%(ment\-baseline|\-%(self|items|content))|bookmark\-%(state|level|label))>/
sy match cssRule contained /\v<%(%(baseline\-shift|backface\-visibility|backdrop\-filter|azimuth|aspect\-ratio|appearance|all)|background%(\-%(size|repeat|position|origin|image|color|clip|blend\-mode|attachment))?)>/
sy match cssRule contained /\v<%(animation%(\-%(timing\-function|play-state|name|iteration\-count|fill\-mode|duration|direction|delay))?|border%(\-%(top|right|bottom|left)%(\-%(width|style|color))?)?)>/

hi! def link cssRule cssRulesRegionStyle

" COMMENTS
sy region cssComment start='/\*' end='\*/' contains=cssCommentTitle,cssCommentTag

sy match   cssCommentTitle contained /\v%(^|\/\*)\s*\zs(\u|\s)+:/
sy keyword cssCommentTag   contained CAUTION DEBUG EDIT NOTE TODO WARN WARNING

hi! def cssComment      ctermfg=darkgray ctermbg=none  cterm=none
hi! def cssCommentTitle ctermfg=cyan     ctermbg=none  cterm=none
hi! def cssCommentTag   ctermfg=yellow   ctermbg=black cterm=standout,bold

" VALUES
sy region cssValueRegion matchgroup=cssSelectOperator contained start=':' end=';'
	\ contains=cssHexCodeColor,cssConstantColor,cssValueOperator

sy match cssValueOperator contained '[,+\-\*/%]'

sy match cssHexCodeColor contained /\v#[a-fA-F0-9]{3}[a-fA-F0-9]?>/
sy match cssHexCodeColor contained /\v#[a-fA-F0-9]{6}%([a-fA-F0-9]{2})?>/

sy match cssConstantColor contained /\v<%(alice|cadet|cornflower|dark|darkslate|deepsky|dodger|light|lightsky|lightsteel|medium|mediumslate|midnight|powder|royal|sky|slate|steel)?blue>/
sy match cssConstantColor contained /\v<%(%(dark|darkslate|light|lightslate|slate|dim)?gr[ae]y|%(dark|indian|mediumviolet|orange|paleviolet)?red|%(forest|lawn|lime|mediumsea|mediumspring|pale|sea|spring|yellow)?green)>/
sy match cssConstantColor contained /\v<%(light%(coral|cyan|goldenrodyellow|green|pink|salmon|seagreen|yellow)|dark%(cyan|goldenrod|green|khaki|magenta|olivegreen|orange|orchid|salmon|seagreen|turquoise|violet))>/
sy match cssConstantColor contained /\v<%(medium%(aquamarine|orchid|purple|turquoise)|%(deep|hot)?pink|%(coral|cyan|%(pale)?goldenrod|salmon|%(green)?yellow|%(blue)?violet)|%(paleturquoise|antiquewhite|aqua%(marine)?))>/
sy match cssConstantColor contained /\v<%(azure|beige|bisque|black|blanchedalmond|brown|burlywood|chartreuse|chocolate|cornsilk|crimson|firebrick|floralwhite|fuchsia|gainsboro|ghostwhite|gold|honeydew|indigo)>/
sy match cssConstantColor contained /\v<%(ivory|khaki|lavender%(blush)?|lemonchiffon|lime|linen|magenta|maroon|mintcream|mistyrose|moccasin|navajowhite|navy|oldlace|olive%(drab)?|orange|orchid|papayawhip)>/
sy match cssConstantColor contained /\v<%(peachpuff|peru|plum|purple|rebeccapurple|rosybrown|saddlebrown|sandybrown|seashell|sienna|silver|snow|tan|teal|thistle|tomato|turquoise|wheat|white%(smoke)?)>/

hi! def cssHexCodeColor ctermfg=green ctermbg=none cterm=none

hi! def link cssValueOperator cssSelectOperator
hi! def link cssConstantColor cssHexCodeColor

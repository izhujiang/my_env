Keyboards of vim
=========================
title: vim usage guide<br>
author: Jiang Zhu<br>
date created: 18th Feb. 2018<br>
date updated:<br>

-------------------------
## 1. Key sheets
### Part I
Alphabet| Meaning |Cap-Alph |Meaning |	samples
:-------:|:--------|:-------:|:-------|:------
a | Append command| A|  Append in EOL| -
b|Move to beginning of previous word|B |Big word|=ge/E(builtin)<br>3B
c/C|Change command |C| Change till EOL|cw<br>cc<br>c$<br>ci/aw/{
d/D|Delete command |D| Delete till EOL| [d,w,…]<br> dw<br> d3e<br> dfm<br> 3dd<br>d3j
e/E|Move to end of next word| | | 3e<br>ge/E
f/F|Find [character] within line| | | 3fa
g|Go to<br>gg - goto first line<br>gf - goto file<br>ge/E - previous word end<br>gd<br>gt/gT<br>Swap case:<br>gu/gU/g~{motion}|[n]G|	Move to line [n] or last line<br>3G<br>G - goto last line | -
h	|Move left	|H	|H/M/L, Move cursor to top/middle/end line of screen|-
i	|Insert command|I| |3i<Esc>
j	|Move next line	|J/gJ	|join two lines with/without space|3j
k	|Move previous line	|K	|:help current keyword|3k
l	|Move right	|L	|screen bottom|-
m[a-z]	|bookmark	|M	|screen middle|m[a-z] - set <br>'[a-z] - jump<br>''(double ')<br>:marks
n/N	|Next Find| | | 3n
o/O|	Open up new line| | |3o/O\<Esc>
p/P|	Paste command| | | 3p
q[a-z]|	Record macro, <br>and play macro with @[a-z] or @@(	the last macro)|Q|	Ex mode| -
r[.]|	Replace character	|R|	Replace command|3rx
s|	Substitue command		Vs R Comand|S| |-
t/T|	till|	|	Back till|vs. f/F
u|	Undo|   U|	Resort line| 3u
v| Visual mode, combine with motion and text object			"v{num}e<br>vw|V| | 3v<br>\<Crtl>v\<shift>i\<Esc><br>vaw/vab()/vaB{}/vib/viB
w/W|	Move to the beginning of next word| | | 3w/W
x|	Delete character|	X|	Backspace|3x/X<br>xp
y[w, …]|	Yank|	Y[n]/yy	|Yank [n] lines|3yy<br>ggyG<br>yi/a/tw/{/(
z|	"1. Scrolling relative to cursor<br> z\<cr>: redraw with line [count] at top of window<br>zt<br>zz<br>z.<br>zb<br>z-<br>z{height}<br> 2. Scrolling horizontally <br>zl<br>zh<br>ZL<br>zH<br>zs<br>ze|	Z|	"ZZ-Quit with save<br> ZQ-Quit without save"|..

:h g
:h z
Key | Meaning |  Key | Meaning
:-------:|:--------|:------:|:--------

:h [

:h <C+w>

### Part II
Key | Meaning |  Key | Meaning
:-------:|:--------|:------:|:--------
!| Filter Operation| |-
~|	Upper /lower character| |-
@|	@a Run macro a<br>@@ Run last macro| '\[a-z]| 'a jump to mark a, y'a yank text to mark a.
%|	Move to matching character: {}\[]() \/\* \*\/ #if…| |-
\*	| Find next word under cursor|	#	|Find previous word under cursor
0/^/\|/-/+	|move to BOL (cur/pre/next) 	|$|	Move to EOL
(|-|)|-
{|jump to previous paragraph|}|jump to next paragraph
[|-|		]|-
:|	EX command	|;|	repeat t/T/f/F motion|
.|Repeat the last change() | | -
/|Search, and repeat search with n/N	|?	|Search backward, and repeat search with n/N|
<|Unindet	|>	|Indent|

### Part III
Operation and Action

Operator| Meaning | Sample
:---:|:--|:--
c| | caw<br>cip
d| | 
y| | 
~| | 
g~| | 
gu| | 
gU | 
!| | 
=| | 
gq | 
g? | 
>| | 
<| | 
zf| | 
g@ | | 


### Part IV
Key | \<Ctrl> + Key |Meaning |Sample
:-------:|----:|:--------|:------:|:--------
A	|\<ctrl>+	a	|addition on number/character | 10\<C-a/x>:  +10/-10 to number or character in current cursor
B	|\<ctrl>+	b	|move back one full screen  |-
C	|\<ctrl>+	c	|  |-
D	|\<ctrl>+	d	|move forward 1/2 screen  |-
E	|\<ctrl>+	e	|  |-
F	|\<ctrl>+	f	|move forward one full screen  |-
G	|\<ctrl>+	g	|  |-
H	|\<ctrl>+	h	|  |-
I	|\<ctrl>+	i	|  |-
J	|\<ctrl>+	j	|  |-
K	|\<ctrl>+	k	|  |-
L	|\<ctrl>+	l	|  |-
M	|\<ctrl>+	m	|  |-
N	|\<ctrl>+	n	|  |-
O	|\<ctrl>+	o	|  |-
P	|\<ctrl>+	p	|  |-
Q	|\<ctrl>+	q	|  |-
R	|\<ctrl>+	r	|  |-
S	|\<ctrl>+	s	|  |-
T	|\<ctrl>+	t	|  |-
U	|\<ctrl>+	u	|move back 1/2 screen  |-
V	|\<ctrl>+	v	|  |-
W |\<ctrl>+ ws/v/n<br>ww<br>wh/j/k/l<br>wr/R/x/X/K/J/H/L/T<br>w=/-N/+N/\_/<>/<br>wq<br>wo|Window operation(split, switch, move, resize and quit), <br>and ref more window command.|-
X	|\<ctrl>+	x	|  subtraction on numbers |-
Y	|\<ctrl>+	y	|  |-
Z	|\<ctrl>+	z	|  |-


### Part V
Key | \<Ctrl> + Key |Meaning |Sample
:-------:|----:|:--------|:------:|:--------
!| | | |
~| | | |
@| | | |
%| | | |
\*| | | |
^| \<ctrl> + ^|Quick toggle between the current and the alternate files | |
(|-| | | |
{| | | |
[| | | |
:| | | |
.| | | |
/| | | |
<| | | |


### Reference

+ [Vim Cheat Sheet](https://vim.rtorr.com/)

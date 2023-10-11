Keyboards of vim
=========================
title: Vim Command by Catalog<br>
author: Jiang Zhu<br>
date created: 22th Feb. 2018<br>
date updated:<br>

-------------------------
## Modes
## 1. Nomal Mode
### Registers
* Addressing a register: "{register}
* The unnamed register("")
* The yank register("0)
* The named registers("a-"z)
* The black hole register("\_)
* The system clipboard("+) and selection("\*) registers
* The expression register("=)
* More registers:
    - "% Name of the current file
    - "# Name of the alternate file
    - ". Last insert text
    - ": Last Ex command
    - "/ Last search pattern

### Copy and Paste
#### Delete, Yank, and Put with Vim’s Unnamed Register
* xp command, transposing characters
* ddp command, transposing lines
* yyp command, duplicating lines

The p and P commands are great for pasting multiline regions of text.
But for short sections of character-wise text, the <C-r>{register} mapping can be more intuitive.

When pasting from a line-wise register, the p and P commands put the text below or above the current line.  
Vim also provides gp and gP commands. These also put the text before or after the current line, but they leave the cursor positioned at the end of the pasted text instead of at the beginning.

From Insert mode, we can insert the contents of the unnamed register by pressing <C-r>",
or we can insert the contents of the yank register by pressing <C-r>0.

## Motions(Move around within a file)
### Common motions
* Using the h, j, k, and l keys over the arrow keys to move the cursor around
* Move Word-Wise using w, b, e, and ge command(W, B, E, and gE as well).
* character search commands(f/F/t/T {char} and [; ,] - search/reverse again) allow us to move quickly within a line, and they work beautifully in Operator-Pending mode.  
  Usually use f and F in Normal mode, and t and T in Operator-Pending mode. For example: f,dt.
* Search to navigate: /, ?, n, N
* Operate with a search Motion: v[c, d, y]i[a]/{chars}
* Trace selection with text objects: v[d,c,y]i/a}/]/>/)/'/"/`/t/w/W/s/p, espceal vi}[a", i>, ...] act text objects selection sequentially.
* Jump between matching parentheses
    * % command lets us jump between opening and closing sets ( [],(),{},<> )
    * Enable matchit.vim to support % command jump between other pairs of keywords(as program language keywords if/else)

### Bookmarks
* Manual marks:
Vim’s marks allow us to jump quickly to locations of interest within a document.  
m{a-zA-Z}, `{a-zA-Z} commands, make a handy pair. And lowercase marks are local to each individual buffer, whereas uppercase marks are globally accessible.

* Automatic Marks:

Keystrokes | Buffer Contents
:------:|:---------
`` | Position before the last jump within current file `. Location of last change
`^ | Location of last insertion
`[ | Start of last change or yank
`] | End of last change or yank `< Start of last visual selection `> End of last visual selection


### Jumps
#### What is jump:
As a rule of thumb, long-range motions may be classi-fied as a jump, but short-range motions are just motions.
Moving directly to a line number with [count]G counts as a jump, but moving up or down one line at a time does not.
The sentence-wise and paragraph- wise motions are jumps, but the character-wise and word-wise motions are not.

Command | Effect
:------:|:---------
[count]G | Jump to line number
//pattern<cr><br> /?pathen<cr><br>/n/N | Jump to next/previous occurrence of pattern Jump to matching parenthesis
% | Jump to start of previous/next sentence Jump to start of previous/next paragraph Jump to top/middle/bottom of screen
(/) | Jump to file name under the cursor
{/} | Jump to definition of keyword under the cursor Jump to a mark
H/M/L | Jump to top/middle/bottom of screen
gf |  Jump to file name under the cursor
<C-]> |  Jump to definition of keyword under the cursor Jump to a mark
’{mark}/`{mark} | Jump to a mark

#### Traverse the jump list
Vim can maintain multiple jump lists at the same time. In fact, each separate window has its own jump list.

Command | Buffer Contents
:------:|:---------
<C-o> <br> <C-i> | the <C-o> command is like the back button, while the complementary <C-i> command is like the forward button.
:jumps| inspect the contents of the jump list

#### Change list
Vim records the location of our cursor after each change.
* Inspect the change list by :changes
* g; and g, can traverse backward and forward through the change list.
* `. references the position of last change, while `^ mark tracks the postion of the cursor the last time
that Insert mode was stopped. And gi command quickly carry on where leaving the Insert mode.

#### Jump to the filename under the cursor
Vim treats filenames in our document as a kind of hyperlink.  
When configured properly, we can use the gf command to go to the filename under the cursor.
* gf commmand. <C-]> command play similar role.
* ‘suffixesadd’ option, likes: set suffixesadd+=.rb
* ‘path’ option, referenced functionality that was provided by a third-party library
* snap vetween files using global marks.  
A global mark(uppercase letters) is a kind of bookmark that allows us to jump between files.`{letter} command.  
Try to get into a habit of setting a global mark before using any commands that interact with the quickfix list, such as :grep, :vimgrep, and :make.
The same goes for the commands that interact with the buffer and argument lists, such as :args {arglist} and :argdo

## Insert Mode

## Visual Mode

## Ex Mode

:[range]copy {address}  
:t short for copy

:[range]move {address}  
:m short for move

 Repeating the last Ex command is as easy as pressing __@:__


The syntax for defining a range is very flexible. We can mix and match line numbers, marks, and patterns, and we can apply an offset to any of them.

Symbol |Address
:------:|:---------
1 |First line of the file
$ |Last line of the file
0 |Virtual line above first line of the file . Line where the cursor is placed
'|m Line containing mark m
'< |Start of visual selection
'> |End of visual selection
% |The entire file (shorthand for :1,$)

The :normal command allows us to combine the expressive nature of Vim’s Normal mode commands with the range of Ex commands. It’s a powerful combination!
For example:  
* :%normal A;  
* :%normal i//  
* :'<,'>normal .  

Tab-Complete Your Ex Commands:  
* \<TAB>  <S-TAB>  
* :<C-d>  
*  <ctrl + n>  <ctrl + p>  
:col<C-d>  
:colorscheme \<TAB>

Insert the Current Word at the Command Prompt:  
At Vim’s command line, the <C-r><C-w> mapping copies the word under the cursor and inserts it at the command-line prompt.
when press the * key to find all the words wanted to be replaced, and move the cursor to the word you want to insert and type the command
:%s//<C-r><C-w>/g  

Open Command Window using:
* Open the command-line window with history of searches
* Open the command-line window with history of Ex commands
* ctrl-f Switch from Command-Line mode to the command-line window

Run Commands in Shell:  
We can easily invoke external programs without leaving vim:  

Command | Effect
--------|--------
:shell  | Start a interactive shell(return to vim by type exit)
<ctrl+z>| Suspends the process that's running vim and return control to bash.(fg resume vim)
:!{cmd} | Execute {cmd} with the shell
:read !{cmd}  | Execute {cmd} in the shell and insert its standard output below the cursor
:[range]write !{cmd} | Execute {cmd} in the shell with [range] lines as standard input
:[range]!{filter} | Filter the specified [range] throught external program {filter}

Samples:  
:!ruby %    # excuting current ruby file  
:read !ls  
:2,$!sort -t',' -k2

Vim provides a convenient shortcut for setting the range of a :[range]!{filter} command such as this. The !{motion} operator command drops us into Command-Line mode and prepopulates the [range] with the lines covered by the specified {motion} (see :h !).  
For example:  
!G, Vim opens a prompt with the :.,$!


## Fils management and workspace

### 1.3 Multi-files Operations
vim -o/O file1 file2 ...  
or using files explorer
:edit {file}
:edit %<Tab>
:edit %:h<Tab>
:edit %%
:find {filename}

Save or quite

Command | Effect
--------|--------
:w[rite] |Write the contents of the buffer to disk
:e[dit]! | Read the file from disk back into the buffer (that is, revert changes)
:qa[ll]! | Close all windows, discarding changes without warning
:wa[ll]  | Write all modified buffers to disk

### 1.4 Buffer and buffer list
Track Open Files with the Buffer List

Command | Effect
--------|--------
:ls / :buffer  | list all the buffers that have been loaded into memory
<ctrl-^> | quickly toggle betheen the current and alternate files, %--current buffer, #--alternate buffer
:bd | unload loaded buffer by name, number or current buffer, :bdelete N1 N2 N3 or :N,M bdelete
:bf/n/p/l <br>:b[number or buffer name] | traverse the buffer list
:bufdo <cmd> | Execute {cmd} in each buffer in the buffer list

### Augs and augs list
Group Buffers into a Collection with the Argument List. The buffer list is like desktop, the argument list is like a separate workspace.

Command | Effect
--------|--------
:args |  examine the argument list
:args {arglist} | populating the argument list is by specifying filenames,  by Glob or by backtick expansion. <br> :args \**/*.js \**/*.css <br> :args `cat .chapters`
:next :prev, :first, :last  <br> :\[count] n\[next] \[++opt] \[+cmd]| traverse the files in the argument list 
:argdo \<cmd> | gg

See more: arga, argd, arge,,

### 1.6 Window

Command | Effect
--------|--------
<C-w>s <br> <C-w>v <br> :sp[lit] {file} <br>:vsp[lit] {file}| Split the current window horizontally/vertically
<C-w>w | Cycle between open windows
<C-w>h/j/k/l | Switch the active window
:cl[ose] | Close the active window
:on[ly]<br> <C-w>c | Close all windows except the active one
<C-w>= | Equalize width and height of all windows
[N] <C-w>\_ | Maximize height of the active window, and et active window height to [N] rows
[N] <C-w>\| | Maximize width of the active window

load file or explore files in current window:  
:edit: file or :E[xplore]: dir like: :e %:h<tab>/file and E: %%


### 1.5 Tab
Unlike other text editors, VIM use tab pages to organize split windows into a collection of workspaces.  
In Vim, a tab page is a container that can hold a collection of windows

Command | Effect
--------|--------
:tabe[dit] {filename}| Open {filename} in a new tab
<C-w>T| Move the current window into its own tab
:tabc[lose] | Close the current tab page and all of its windows
:tabo[nly]| Keep the active tab page, closing all others
:tabn[ext] {N} <br> {N}gt | Switch to tab page number {N}/the next tab page
:tabp[revious] | Switch to the previous tab page
:tabmove [N] | rearrange tab page to N or end.

### Also see
:tabdo, :argdo, :bufdo and :windo.

## Plugins

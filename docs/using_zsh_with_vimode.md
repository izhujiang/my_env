Oh-My-Zsh: vi-mode
==============

#### 1. vi-mode
This plugin increase vi-like zsh functionality.

Use ESC or CTRL-[ to enter Normal mode.

#### 2. History
ctrl-p : Previous command in history <br>
ctrl-n : Next command in history <br>
/ : Search backward in history <br>
n : Repeat the last / <br>
Mode indicators <br>
Normal mode is indicated with red <<< mark at the right prompt, when it wasn't defined by theme. <br>

#### 3. Vim edition
v : Edit current command line in Vim
#### 4.Movement
$ : To the end of the line <br>
^ : To the first non-blank character of the line <br>
0 : To the first character of the line <br>
w : [count] words forward <br>
W : [count] WORDS forward <br>
e : Forward to the end of word [count] inclusive <br>
E : Forward to the end of WORD [count] inclusive <br>
b : [count] words backward <br>
B : [count] WORDS backward <br>
t{char} : Till before [count]'th occurrence of {char} to the right <br>
T{char} : Till before [count]'th occurrence of {char} to the left <br>
f{char} : To [count]'th occurrence of {char} to the right <br>
F{char} : To [count]'th occurrence of {char} to the left <br>
; : Repeat latest f, t, F or T [count] times <br>
, : Repeat latest f, t, F or T in opposite direction <br>
#### 5. Insertion
i : Insert text before the cursor <br>
I : Insert text before the first character in the line <br>
a : Append text after the cursor <br>
A : Append text at the end of the line <br>
o : Insert new command line below the current one <br>
O : Insert new command line above the current one <br>
#### 6. Delete and Insert
ctrl-h : While in Insert mode: delete character before the cursor <br>
ctrl-w : While in Insert mode: delete word before the cursor <br>
d{motion} : Delete text that {motion} moves over <br>
dd : Delete line <br>
D : Delete characters under the cursor until the end of the line <br>
c{motion} : Delete {motion} text and start insert <br>
cc : Delete line and start insert <br>
C : Delete to the end of the line and start insert <br>
r{char} : Replace the character under the cursor with {char} <br>
R : Enter replace mode: Each character replaces existing one <br>
x : Delete [count] characters under and after the cursor <br>
X : Delete [count] characters before the cursor <br>

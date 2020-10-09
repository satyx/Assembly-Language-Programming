;reverse a binary number
.model small
.code
Mov AL,01010101b
XOR BX,BX
Mov CX,8
L:
SHL AL,1
RCR BL,1
LOOP L
Mov DL,BL
Sub DL,73
Mov AH,2
Int 33
Mov AH,4CH
Int 33
END

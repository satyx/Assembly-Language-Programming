;print a string
.model small
.data
HELLO DB 'Hello World$'
.code
Mov AX,@data
Mov DS,AX
Mov Ah,9
LEA DX,HELLO
Int 33
Mov AH,76
Int 33
End

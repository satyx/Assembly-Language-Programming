.model small
.stack 100H
.code
XOR CX,CX
Mov AH,1
Int 33
l1:
	cmp AL,0DH
	je print
	INC CX
	push AX
	Int 21h
	jmp l1

print:
	Mov AH,2
	Pop DX
	Int 21h
	Sub CX,1
	jnz print

Mov AH,76
Int 21H
End

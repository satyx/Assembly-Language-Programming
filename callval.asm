.model small
.stack 100h
.data
	inpmsg db "Enter Number:$"
	outmsg db "Sum:$"
	num1 dw 20
	num2 dw 50
.code
MAIN PROC
	Mov AX,@data
	Mov DS,AX
	LEA BX,num1
	call inp
	LEA BX,num2
	call inp
	Mov AX,num1
	Mov BX,num2
	Push AX
	Push BX
	call _add
	call display

	Mov AH,4CH
	Int 33

MAIN ENDP

inp PROC
	Mov AH,9
	LEA DX, inpmsg
	Int 33
	XOR CX,CX
	l:
		XOR AX,AX
		Mov AH,1
		int 33
		cmp AL,0DH
		je store
		Sub AL,'0'
		XOR AH,AH
		Push AX
		Mov AX,CX
		Mov CX,10
		Mul CX
		Pop CX
		Add CX,AX
		jmp l
	store:
		Mov [BX],CX
	ret
inp ENDP

display PROC
	Push AX
	Mov AH,9
	LEA DX, outmsg
	Int 33
	Pop AX
	XOR BX,BX
	XOR CX,CX
	Mov BX,10
	l2:
		Xor DX,DX
		div BX
		Add DL,'0'
		Push DX
		Inc CX
		cmp  AX,0
		ja l2
	
	Mov AH,2
	print:
		Pop DX
		Int 33
		loop print
display ENDP

_add PROC
	Mov BP,SP
	Push BP
	MOV AX,[BP+2]
	Add AX,[BP+4]
	Pop BP
	ret 4
_add ENDP
END

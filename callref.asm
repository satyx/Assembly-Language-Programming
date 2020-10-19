.model small
.stack 100h
.data
	inpmsg db "Enter Number:$"
	outmsg db "Sum:$"
	num1 dw 10
	num2 dw 10
	sum dw 0
.code
MAIN PROC
	Mov AX,@data
	Mov DS,AX
	
	LEA SI,num1
	call inp
	Push SI
	LEA SI,num2
	call inp
	Push SI
	
	LEA SI,sum
	Push SI
	
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
		Mov [SI],CX
	ret
inp ENDP

display PROC
	Mov AH,9
	LEA DX, outmsg
	Int 33
	Mov AX,sum
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
	ret
display ENDP

_add PROC
	Mov BP,SP
	Push BP
	Mov SI,[BP+2]
	
	Mov BX,[BP+4]
	Mov CX,[BX]
	
	Add [SI],CX
	Mov BX,[BP+6]
	Mov CX,[BX]
	
	Add [SI],CX
	
	Pop BP
	ret 6
_add ENDP
END

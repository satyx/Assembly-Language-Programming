.model small
.stack 100h
.data
	l1 db 0
	l2 db 0
	txt db 20 dup(?)
	pat db 20 dup(?)
.code
MAIN PROC
	

	Mov AX,@data
	MOv DS,AX
	LEA SI,txt
	Mov AH,1
	XOR CX,CX
	lp1:
		Int 33
		cmp AL,0DH
		je storeTxt
		Mov [SI], AL
		Inc SI
		Inc CX
		jmp lp1
	storeTxt:
		Mov [SI],'$'
		Inc CX
		Mov l1,CL
		XOR CX,CX
		LEA SI,pat
	
	lp2:
		Int 33
		cmp AL,0DH
		je storePat
		Mov [SI], AL
		Inc SI
		Inc CX
		jmp lp2
	storePat:
		Mov [SI],'$'
		Inc CX
		Mov l2,CL
	Mov AH,9
	LEA DX,txt
	Int 33
	LEA DX,pat
	Int 33
	
	XOR CX,CX
	XOR BX,BX
	Mov CL,l1
	Sub CL,l2
	LEA DI,txt
	LEA SI,pat
	txtloop:
		Push BX
		XOR SI,SI
		patloop:
			XOR BH,BH
			cmp [DI+BL],[SI+BH]
			je l02
			INC BH
			INC BL
			cmp BH,l2
			jl patloop
		l02:
		cmp BH,l2
		je l03
		Pop BX
		Inc BL
		cmp BL,CL
		jle txtloop
	
	l03:
	Mov AH,76
	Int 21H

MAIN ENDP
END

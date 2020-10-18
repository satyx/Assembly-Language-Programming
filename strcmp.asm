;implementing strcmp function of C

.model small
.stack 100h
.data

str db 30 dup(?)
pat db 20 dup(?)
success db 'Success$'
failure db 'Failure$'
l1 db 0
l2 db 0
.code
MAIN PROC
	MOV AX,@data
	Mov DS,AX
	LEA SI,str
	LEA DI,l1
	call inp
	LEA DI,l2
	LEA SI,pat
	call inp

	XOR CX,CX
	Mov CL,l1
	cmp CL,l2
	jge upd
	jmp after_upd
	upd:
	Mov CL,l2
	after_upd:
	
	XOR AX,AX
	XOR BX,BX
	
	LEA SI,str
	LEA DI,pat
	XOR BX,BX
	lstart:
		XOR DL,DL
		Mov DL,[BX+SI]
		cmp DL,[BX+DI]
		jne unmatch
		Inc BL
		cmp BL,CL
		jl lstart
	
	match:
		LEA DX,success
		jmp display
	unmatch:
		LEA DX,failure
	display:
		Mov AH,9
		Int 21H
	Mov AH,76
	Int 21H
MAIN ENDP

INP PROC
	Push AX
	Push SI
	Push DI
	XOR CX,CX
	Mov AH,1
	rec:
		Int 21h
		cmp AL,0DH
		je restore
		Mov [SI],AL
		INC SI
		Inc CX
		jmp rec
	restore:
		Mov [SI],'$'
	Mov [DI],CL
	Pop DI
	Pop SI
	Pop AX
	ret
INP ENDP
END


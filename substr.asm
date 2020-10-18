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

	Mov AL,l1
	cmp AL,l2
	jl nfound

	XOR CX,CX
	Mov CL,l1
	Sub CL,l2
	
	XOR AX,AX
	XOR BX,BX
	
	LEA SI,str
	LEA DI,pat
	
	lstart:
		XOR BX,BX
		XOR CH,CH
		lnest:
			XOR DL,DL
			Mov DL,[BX+SI]
			cmp DL,[BX+DI]
			jne unmatch
			Inc BX
			cmp BL,l2
			jl lnest
			jmp nxtiter
			unmatch:
				Mov CH,1
		nxtiter:
			cmp CH,0
			je found
			Inc AX
			Inc SI
			cmp AL,CL
			jl lstart
	jmp nfound
			
	found:
		LEA DX,success
		jmp display
	nfound:
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


.model small
.stack 100h
.data
	arr DW 20 dup(0)
.code

MAIN PROC
	MoV AX,@data
	Mov DS,AX
	LEA SI, arr
	XOR CX,CX
	XOR BX,BX
	Mov AH,1
	l1:
		Int 33
		cmp AL, 0DH
		je done
		cmp AL, 20H
		je delim
		
		CALL upd
		jmp l1
		
		delim:
			Mov [SI],BX
			Add SI,2
			Inc CX
			XOR BX,BX
			jmp l1
		done:
			Mov [SI],BX
			Add SI,2
			Inc CX
			XOR BX,BX
	LEA SI,arr
	l2:
		call outdec
		ADD SI,2
		LOOP l2	
	
	Mov AH,76
	Int 21H
MAIN ENDP

outdec PROC
	Push AX
	Push BX
	Push CX
	Push DX
	Push SI
	Mov AX,[SI]
	MOV CX,0
	Mov BX,10
	
	l5:	
		XOR DX,DX
		Div BX
		push DX
		INC CX
		cmp AX,0
		ja l5
	Mov AH,2
	l6:
		Pop DX
		Add DL,48
		int 21h
		Loop l6
	Mov DL,32
	int 33
	pop SI
	pop DX
	pop CX
	pop BX
	pop AX
	ret
outdec endp
	

upd PROC
	Push AX
	Push CX
	And AX,000FH;
	Push AX
	Mov AX,10
	Mul BX
	Pop BX
	Add BX,AX
	Pop CX
	Pop AX
	ret
upd ENDP
END

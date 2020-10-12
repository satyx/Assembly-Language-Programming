.model small
.stack 100h
.data
	no EQU 'N'
	n DW 50
	num DB 10000 dup('P')
.code
MAIN PROC
	Mov AX,@Data
	Mov DS,AX
	
	XOR BX,BX
	inp:
		int 21h
		cmp AL,0DH
		je store
		call update
		jmp inp
		store:
			Mov SI,BX
			Mov n,BX
			
	mov SI,1
	Mov [num+SI],no
	Inc SI
	XOR BX,BX
	XOR AX,AX

	XOR CX,CX
	Mov CX,0002H
	
	l:
		Mov SI,CX
		Mov AX,CX
		Mov BX,AX
		Mul BX
		Mov SI,AX
		
		
		l2:
			cmp SI,n
			ja _l2
			Mov [num+SI],no
			Add SI,CX
			jmp l2

		_l2:
		Inc CX
		cmp CX,n
		jb l
	k:
	Mov SI,1
	XOR CX,CX
	Mov CX,n
		
	Mov SI,1
	print:
		call outdec
		Mov AH,2
		Mov DL,':'
		Int 21h
		XOR DX,DX
		Mov DL,[num+SI]
		Int 33
		Mov DX,9
		Int 33
		Inc SI
		loop print
	
	Mov DL,10
	Int 33
	exit:
	Mov AH,76
	Int 33
			
MAIN ENDP

outdec PROC
	Push AX
	Push SI
	Push BX
	Push CX
	XOR CX,CX
	Mov AX,SI
	Mov BX, 10
	l3:
		XOR DX,DX
		Div BX
		Push DX
		Inc CX
		cmp AX,0
		jg l3
	Mov AH,02H
	l4:
		Pop DX
		Add DL,'0'
		Int 21H
		LOOP l4
	Pop CX
	Pop BX
	Pop SI
	Pop AX
	ret
outdec ENDP

update PROC
	Push AX
	Push SI
	And Ax,000FH;
	Push AX
	Mov AX,BX
	Mov Bx,10
	Mul Bx
	Pop BX
	Add BX,AX
	Pop SI
	Pop AX
	ret
update ENDP
END

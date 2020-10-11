.model small
.stack 100h
.data
	inp DB 'Enter the number:$'
	true DB 'Prime$'
	false DB 'Not Prime$'
	num DW 10
	
.code
MAIN PROC
	Mov AX,@data
	Mov DS,AX
	LEA DX,inp
	Mov AH,9
	Int 21h
	XOR BX,BX
	XOR AX,AX
	Mov AH,1
	number:
		Int 33
		cmp AL,0DH
		je store
		call update
		jmp number
		store:
			Mov num,BX

	Mov BX,2
	cmp num,2
	jl not_prime
	
	check:
		cmp num,BX
		jle prime
		
		XOR DX,DX
		Mov AX,num
		Div BX
		cmp DX,0
		je not_prime
		INC BX
		jmp check

	prime:
	LEA DX,true
	Mov AH,9
	Int 21h
	jmp exit
	
	not_prime:
		LEA DX,false
		Mov AH,9
		Int 21h
			
	exit:
		Mov AH,76
		Int 21H
MAIN ENDP

update PROC
	PUSH AX
	AND AX,000FH;
	Push AX
	Mov AX,BX
	Mov BX,10
	Mul BX
	Pop BX
	Add BX,AX
	POP AX
	ret
update ENDP
END

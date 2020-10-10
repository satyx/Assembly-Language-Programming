.model small
.code

XOR BX,BX
MOV CL,4
Mov AH,1
Int 21h

whileL:
	cmp AL,0DH
	JE printans
	cmp AL,39H
	JG letter
	AND AL,0FH
	jmp s1
	letter:
		Sub AL,37H
	s1:
		SHL BX,CL
		OR BL,AL
		Int 21h
		jmp whileL

printans:
	Mov AH,2
	Mov DL,BH
	Int 33
	Mov DL,BL
	Int 33

Mov AH, 4CH
Int 21h
END

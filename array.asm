;take three number each one digit. Determine their sum s and print the s-th character from A
.model small
.data
arr DB 41H,43H,45H,24H

.code
MAIN PROC
	Mov AX,@DATA
	Mov DS, AX
	Mov AH,1
	Int 33
	Sub AL,30H
	Mov [arr],AL
	Int 33
	Sub AL,30H
	Mov [arr+1],AL
	Int 33
	Sub AL,30H
	Mov [arr+2],AL
	Mov AH,2
	CALL HEY
	Int 33
	Mov AH,76
	Int 33
MAIN ENDP

HEY PROC
	Mov DL,[arr]
	Add DL,[arr+1]
	Add DL,[arr+2]
	Add DL,'A'
	ret
HEY ENDP
End

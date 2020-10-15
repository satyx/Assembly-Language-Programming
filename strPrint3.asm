; output in the given format qwert,wert,ert,rt,t,qwer,wer,er,r,qwe,we,e,;qw,w,q,
.model small
.data
	arr db 11 dup(0)
.code
Mov AX,@data
Mov DS,AX
LEA SI,arr
Mov AH,1

XOR CX,CX
Mov CX,5
l:
	Int 33
	Mov [SI],AL
	Inc SI
	loopend: loop l
Mov [SI],','
Inc SI
Mov [SI],'$'
LEA DX,arr
Mov CX,5
Mov AH,9
l2:
	push CX
	LEA DX,arr
	l3:
		Int 21h
		Add DX,1
		Loop l3
	Sub SI,2
	Mov [SI],','
	Inc Si
	Mov [SI],'$'
	Pop CX
	loop l2
	
MOv AH,4CH
Int 33
END

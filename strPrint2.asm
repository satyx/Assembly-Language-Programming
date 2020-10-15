;Read 5 letters and out in the given format: eg input : qwert then o/p qwert,qwer,qwe,qw,q,
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
LEA DX,arr
Mov CX,5
Mov AH,9
l2:
	Mov [SI],','
	Inc SI
	Mov [SI],'$'
	Sub SI,2
	Int 21h
	
	Loop l2
MOv AH,4CH
Int 33
END

/*
Move:   (byte type register): Mov reg,num - 176+reg,num ; Mov reg1,reg2 - 138, 192+8*reg1+reg2 
		(word type register): Mov reg,num - 184+reg,num ; Mov reg1,reg2 - 139, 192+8*reg1,reg2 
Interrupt: Int: 205	
Jump: Jmp 10: 235 10   (Pass 4 instructions) Eg: 180 2 178 71 235 4 205 33 205 33 205 33 180 76 205 33 will output only one G. Because 4 lines are by passed.
235,4,180,76,205,33,180,2,178,72,205,33,235,-12 o/p H. Jumping 12 lines back.
machine codes
000:AL,AX,[BX+SI]
001:CL,CX,[BX+DI]
010:DL,DX,[BP+SI]
011:BL,BX,[BP+DI]
100:AH,SP,[SI]
101:CH,BP,[DI]
110:DH,SI,[direct]
111:BH,DI,[BX]

*/


#include <stdio.h>
#include <string.h>
int main()
{
	printf("*********Press Enter and then EOF character(EOF condition is triggered by pressing ctrl+D once if cursor is at the beginning of the line or twice otherwise in linux or ctrl+Z in windows) to terminate input***********\n");
	int reg[8];
	int arr[4]; //0:SP, 1 :BP, 2:SI,3:DI
	int mc[10000];
	int pc = 0;
	int i=0;
	int code = 0;
	char ch='\0';
	while((ch = getchar())!=EOF)
	{
		if(ch==' ' || ch=='\n')
		{
			if(code!=0)
				mc[pc++] = code;
			code = 0;
		}
		else
		{
			code = (code*10)+(ch-'0');
		}
	}
	mc[pc] = code;
	pc = 0;
	
	while(1)
	{
		if(mc[pc]>175 && mc[pc]<184)
		{
			reg[mc[pc]-176] = mc[pc+1];
			pc+=2;
		}
		else if(mc[pc]>=184 && mc[pc]<192)
		{
			int src = mc[pc]-184;
			pc++;
			if(src<4)
			{
				reg[src] = mc[pc+1];
				reg[src+4] = mc[pc+2];
			}
			else
			{
				arr[src-4] = mc[pc+1]*256 + mc[pc+2];
			}
			pc+=2;
			
		}
		else if(mc[pc]==205)
		{
			pc++;
			if(mc[pc]==33)
			{
				if(reg[4]==1){
					
					printf("Waiting to read input:");
					reg[0] = getchar();
				}
				if(reg[4]==2)
					printf("%c",reg[2]);
				if(reg[4]==76)
					break;
				pc++;
			}
		}
		else if(mc[pc]==138)
		{
			pc++;
			reg[(int)((mc[pc]-192)/8)] = reg[(mc[pc]-192)%8];
			pc++;
		}
		else if(mc[pc]==139)
		{
			pc++;
			int src = (int)((mc[pc]-176)/8), dst = (mc[pc]-176)%8+4;
			if(src<4)
			{
				if(dst<4)
				{
					reg[src] = reg[dst];
					reg[src+4] = reg[dst+4];
				}
				else
				{
					reg[src] = arr[dst-4]%256;
					reg[src+4] = arr[dst-4]/256;
				}
			}
			else
			{
				if(dst<4)
				{
					arr[src-4] = reg[dst];
					arr[src-4] = arr[src-4]*256+reg[dst+4];
				}
				else
				{
					arr[src-4] = arr[dst-4];
				}
			}
			
		}
		else if(mc[pc] == 235)
		{
			pc++;
			pc += mc[pc]+1;
		}
	}
	return 0;
}

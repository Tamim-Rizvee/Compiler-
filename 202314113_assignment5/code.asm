.MODEL SMALL
.STACK 100H
.DATA
	 t1 db ?
	 t2 db ?
	 t2 db ?
	a db ?
	c db ?
	d db ?

.CODE
MAIN PROC
MOV AX , 10
MOV a ,AX
MOV AX , 5
MOV c ,AX
MOV AX , c
MOV BX , 2
MUL BX
MOV AX , a
MOV BX , t1
ADD AX , BX
MOV AX , t2
MOV BX , 12
SUB AX , BX
MOV AX , t3
MOV d ,AX
MOV AX , a
MOV BX , c
SUB AX , BX
MOV AX , 2
MOV BX , 3
SUB AX , BX
MOV AX , t2
MOV BX , 5
MUL BX
MOV AX , t1
MOV BX , t3
SUB AX , BX
MOV AX , t1
MOV d ,AX
MAIN ENDP
END MAIN
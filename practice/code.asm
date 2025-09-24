.MODEL SMALL
.STACK 100H
.DATA
a DW ?
t1 DW ?
t2 DW ?
t3 DW ?
t4 DW ?
.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX 
MOV ax, 10
MOV a, ax
MOV ax, 20.5
MOV b, ax
MOV ax, a
MOV bx, b
ADD ax, bx
MOV t1, ax
MOV ax, t1
MOV bx, 9
ADD ax, bx
MOV t2, ax
MOV ax, t2
MOV c, ax
MAIN ENDP
END
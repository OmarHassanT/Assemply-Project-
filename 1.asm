.MODEL SMALL
.STACK 100H
.data
NUM DB 0H  
COUNT DB 0H 
COUNT2 DB 05H 
arr DB 26 DUP (0)
str DB "Abc$"
.code 


print PROC
;LOPDIV:
MOV DL , 0AH
DIV DL
MOV DL,AH
ADD DL,30H
MOV AH , 02H 
INT 21H
MOV AH,0H
CMP AL,0H
;JNZ LOPDIV
RET
print ENDP
‏ 




MAIN PROC
;Initialize DS
MOV AX,@DATA
MOV DS,AX  

;***********INITIA*****************
MOV CX,30H 
MOV SI, 400H 
MOV BL,00H
N1: MOV [SI] , BL 
INC SI 
LOOP N1  

;***********READING*****************
  
L1: MOV SI ,400H
MOV AH ,01H 
INT 21H 

CMP AL,20H  			; SPACE 
JNE LABEL1 
JMP LAST 
LABEL1 : MOV BL , AL
SUB BL,61H
MOV BH,00H
ADD SI ,BX 
MOV CL,01H
ADD  [SI], CL 

;MOV DL, [SI]
;ADD DL,31H
;MOV AH ,02H 
;INT 21H

LAST:CMP AL ,23H
JNE L1  

;***********READING*****************




MOV CX, 26H
MOV SI, 400H

MOV DL, 10 
MOV AH,02H
INT 21H 
KHARA:MOV AL, [SI]
CMP AL,00H 
JNE SAMARA 
JMP SOSO

SAMARA:
PUSH AX 
MOV DL, COUNT 
ADD DL,61H 
MOV AH,02H
INT 21H 

POP AX 
PUSH AX 
MOV DL, ' ' 
MOV AH,02H
INT 21H 

POP AX 
PUSH AX 
MOV DL, '|' 
MOV AH,02H
INT 21H 


POP AX 
PUSH AX

MOV BL ,AL 
LOLO:  

MOV DL,"*"
MOV AH,02H
INT 21H 
DEC BL 
JNZ LOLO 
;---------------
;ADD DL,30H 
;MOV AH,02H
;INT 21H 
;----------
POP AX 
MOV DL, 10 
MOV AH,02H
INT 21H 


SOSO:INC SI
INC COUNT
LOOP KHARA  

MOV CX, 02H 

ISLAM:MOV DL, ' ' 
MOV AH,02H
INT 21H 
LOOP ISLAM  

MOV BL , 04H 
LORA: 
MOV CX ,05H 
LOSER: MOV DL,'-'
MOV AH, 02H
INT 21H 
LOOP LOSER 

MOV DL,'|'
MOV AH, 02H
INT 21H  

DEC BL 

JNZ LORA   




MOV DL, 10 
MOV AH,02H
INT 21H 
 






MOV CX, 02H 

ISLAM2:MOV DL, ' ' 
MOV AH,02H
INT 21H 
LOOP ISLAM2 

MOV CX ,05H 
LOSER2: MOV DL,' '
MOV AH, 02H
INT 21H 
LOOP LOSER2 


MOV DL,'5'
MOV AH, 02H
INT 21H 
 

MOV CX ,05H 
LOSER4: MOV DL,' '
MOV AH, 02H
INT 21H 
LOOP LOSER4 

MOV DL,'1'
MOV AH, 02H
INT 21H 


MOV DL,'0'
MOV AH, 02H
INT 21H 



MOV CX ,04H 
LOSER7: MOV DL,' '
MOV AH, 02H
INT 21H 
LOOP LOSER7  

MOV DL,'1'
MOV AH, 02H
INT 21H 


MOV DL,'5'
MOV AH, 02H
INT 21H 
 

MOV CX ,04H 
LOSER10: MOV DL,' '
MOV AH, 02H
INT 21H 
LOOP LOSER10  

MOV DL,'2'
MOV AH, 02H
INT 21H 



MOV DL,'0'
MOV AH, 02H
INT 21H 































MOV AH,4CH
INT 21h
MAIN ENDP
END MAIN 


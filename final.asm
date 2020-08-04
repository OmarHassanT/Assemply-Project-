.MODEL SMALL
.STACK 100H
.data
NUM DB 0H  
COUNT DB 0H 
COUNT2 DB 05H 
arr DB 26 DUP (0)
NUM2 DB 0H
RESULTE DB 0H
COUNT3 DB 0H
seqnum DB 0H
justnum DB 0H
justnum2 DB 0H
seqnumARR1 DB 0H
seqnumARR2 DB 0H
sumResult DB 0H
str DB "Abc$"
string1 DB "1. Matrices Multiplication $"
string2 DB "2. Character Histogram$"
string3 DB "3. Exit$"
string4 DB "Enter your choice:$"
string5 DB "Enter a string of characters::$"
str1 DB "Enter matrix dimension: $"
str2 DB "Enter first matrix:$"
str3 DB "Enter second matrix:$"
str4 DB "First entered matrix is: $"
str5 DB "Second entered matrix is: $"
str6 DB "Result of matrix multiplication is: $"


.code 

print PROC
PUSH CX
PUSH DX
PUSH AX

MOV CL , AL
MOV AH,00H
LOPDIV:
MOV DL , 0AH
DIV DL
PUSH AX
MOV AH,00H
CMP AL,00H
JNZ LOPDIV

MOV AL,CL
LOPDIV2:
MOV DL , 0AH
DIV DL
POP CX
MOV DL,CH
PUSH AX
ADD DL,30H
MOV AH , 02H 
INT 21H
POP AX
MOV AH,00H
CMP AL,00H
JNZ LOPDIV2

MOV DL , ' '
MOV AH , 02H 
INT 21H
POP AX
POP DX
POP CX
RET
print ENDP

PRINTLIN PROC
PUSH CX
PUSH DX
PUSH AX
MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H
MOV AL,justnum2
MOV justnum,AL;
POP AX
POP DX
POP CX
RET
PRINTLIN ENDP


Exit PROC 

MOV AH,4CH
INT 21h

RET
Exit ENDP

MATMUL PROC  

MOV DL, 10      	; code for new line 
MOV AH,02H
INT 21H 


;----------------------------------------
LEA DX,str1			; Print string on screen (Enter matrix dimension)
MOV AH,09h
INT 21H 
;----------------------------------------

;----------------------------------------
MOV AH,01H  		; read dimention of matrix  
INT 21H  
SUB AL,30H 
MOV justnum,AL
MOV justnum2,AL

;----------------------------------------

;---------------------------------------- 
PUSH AX
;----------------------------------------
MOV BL, AL	;N * N= N^2
MUL BL
;----------------------------------------

;--------------------------------------
MOV seqnum,AL			; STORE N^2 IN VARIABLE
MOV seqnumARR1,AL
MOV seqnumARR2,AL
MOV CX ,AL 
MOV BH,AL				;BH==CX
;-------------------------------------
MOV DL, 10               ; "PRINT NEW LINE "
MOV AH , 02H 
INT 21H 

;--------------------------------------
LEA DX,str2		; Print string on screen (Enter first matrix:)
MOV AH,09H
INT 21H 
;-------------------------------------- 

MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 

;--------------------------------------
MOV SI,400H			;  location 400H
L1:MOV AH,01H  		
INT 21H  
SUB AL,30H 						
MOV [SI], AL	
MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 	
INC SI 
DEC seqnumARR1					
JNZ L1


MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 
;---------------------------------------
LEA DX,str3		; Print string on screen (Enter second matrix:)
MOV AH,09H
INT 21H   
;--------------------------------------

;--------------------------------------
MOV DI,500H		;location 400H
L2:MOV AH,01H  		
INT 21H  
SUB AL,30H 
MOV [DI], AL	
MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H
INC DI 
DEC seqnumARR2		
JNZ L2
;---------------------------------------  
  ;---------------------------------------
MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 
;----
LEA DX,str4		; Print string on screen (First entered matrix is: )
MOV AH,09h
INT 21H 

MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 

MOV AL,justnum2
MUL justnum2		;N*N = N^2
MOV CH,00H
MOV CX , AL
MOV SI,400H
;.........PRINT First entered matrix ........
laap: MOV AL,[SI]
CALL Print
INC SI
DEC justnum
JZ LCA3
JMP LCA23
LCA3:CALL PRINTLIN
LCA23: 
loop laap

MOV AL,justnum2
MOV justnum,AL
;----
;------------------------------------------
LEA DX,str5			; Print string on screen (Enter matrix dimension)
MOV AH,09h
INT 21H 

MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 
MOV AL,justnum2  ; FOR USING ITRITION OF ARRAY
MUL justnum2

;.........PRINT SECAND entered matrix ........

MOV CH,00H
MOV CX , AL
MOV SI,500H
laapA: MOV AL,[SI]
CALL Print
INC SI
DEC justnum
JZ LCA34
JMP LCA234
LCA34:CALL PRINTLIN
LCA234: 
loop laapA

MOV AL,justnum2		; RETURN justnum FOR THE LAST NUMBER
MOV justnum,AL
  
;************************ PROCESSING *******************
;-----------------------------------------
POP AX
MOV NUM , AL

MOV COUNT3,AL		;initialization

MOV DL ,0H
MOV BL ,0H
MOV CL ,0H	
MOV BP ,600H	
;-----------------------------------------
FIRSTLOOP :		;first loop
MOV BL , 00H

SECANDLOOP:		;second loop
MOV sumResult,00H
MOV DL,00

THRELOOP:		;therd loop
;-----------------------

PUSH DX
ADD DL,CL  ; arr1[Cl+Dl]
MOV AL,DL
MOV AH,00H
ADD AX,400H
MOV SI,AX
MOV AL,[SI]
POP DX

;------------------------
MOV AL,DL  ;
MUL NUM    ; arr2[DL.n+Bl]
ADD AL,BL  ;
MOV AH,00H
ADD AX ,500H
MOV DI,AX
MOV AL,[DI]
;-------------------------

;-------------------------
MOV AL , [SI]  ;
MOV RESULTE,AL ; arr1[SI].arr2[DI]
MOV AL , [DI]  ;
MUL RESULTE 
MOV RESULTE, AL 
;-------------------------

;-------------------------
MOV DH,RESULTE ; result += arr1[SI].arr2[DI]
ADD sumResult ,  DH ;  
;--------------------------

INC DL
CMP DL, NUM
JC THRELOOP		;end loop three

;-------------------------
MOV AH,00H
MOV AL , sumResult ;
PUSH AX				;push sumResult after finsh
MOV [BP], AX
INC BP
;-------------------------
INC BL
CMP BL, NUM
JC SECANDLOOP		;;end loop two

ADD CL,NUM
DEC COUNT3
JNZ FIRSTLOOP		;;end loop one
;**********************************************************  END PROCESSING ******************* 

MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 

PUSH DX
LEA DX,str6		; Print string on screen (Result of matrix multiplication)
MOV AH,09h
INT 21H 
MOV DL, 10				;"PRINT NEW LINE"
MOV AH , 02H 
INT 21H 

;....................PRINT THE RESULT.........
MOV BP,600H
MOV AX,0000H
POP DX
ll9:
;POP AX
MOV AX,[BP]
CALL Print
INC BP
DEC justnum
JZ LCA
JMP LCA2
LCA:CALL PRINTLIN		; IF FINSHED LINE PRINT NEW LINE
LCA2: DEC seqnum
JNZ LL9 
JMP BALAPOSE

RET
MATMUL ENDP   




HISTO PROC 
;***********INITIA*****************
MOV CX,30H 
MOV SI, 400H 						; initalizing zero values of memory  from range 400  to -> 
MOV BL,00H
N1: MOV [SI] , BL 
INC SI 
LOOP N1  

;***********READING***************** 

MOV DL, 10      	; code for new line 
MOV AH,02H
INT 21H 

LEA DX,string5		; print Enter a string of characters:
MOV AH,09h
INT 21H   


LIBB1: MOV SI ,400H
MOV AH ,01H 
INT 21H 

CMP AL,20H  			; compare if the entered value is space or not 
JNE LABEL1 				;  go to  label when condition is not space 
JMP LAST 				;  go to  label when condition is space 
LABEL1 : MOV BL , AL       
SUB BL,61H				; subtract from 61h  in order to make small letter in range from 0 ->26
MOV BH,00H
ADD SI ,BX 				; for compatability with 16-bit register (si)
MOV CL,01H						
ADD  [SI], CL 			; increment according to the frequncey of the letter such as (ltt) we have 2 (t) 


LAST:CMP AL ,23H 		;  compare if the entered value is # or not (=>(#) as ending mark for the input)  
JNE LIBB1  

;***********END READING*****************

 

MOV CX, 26H
MOV SI, 400H

MOV DL, 10      	; code for new line 
MOV AH,02H
INT 21H 

KHARA:MOV AL, [SI]		; move the value of memory to AL in order to make processing 
CMP AL,00H 
JNE SAMARA 
JMP SOSO

SAMARA:
PUSH AX 				; print the characters in output such as (a| b|)
MOV DL, COUNT 
ADD DL,61H 
MOV AH,02H
INT 21H 

POP AX 				   ; Preserve The Value  of AX
PUSH AX 
MOV DL, ' ' 		   ; print space between letters and (|)
MOV AH,02H
INT 21H 

POP AX 
PUSH AX 
MOV DL, '|' 		 ; print (|) between letters and (*)
MOV AH,02H
INT 21H 


POP AX 
PUSH AX

MOV BL ,AL 
LOLO:  

MOV DL,"*"			; print  (*)   
MOV AH,02H
INT 21H 
DEC BL 
JNZ LOLO 
;---------------

;----------
POP AX 
MOV DL, 10  			;  new line 
MOV AH,02H
INT 21H 


SOSO:INC SI
INC COUNT
LOOP KHARA  

MOV CX, 02H 

ISLAM:MOV DL, ' ' 	; print 2 spaces for shifting  at last line 
MOV AH,02H
INT 21H 
LOOP ISLAM  

MOV BL , 04H 
LORA: 
MOV CX ,05H 
LOSER: MOV DL,'-' 	; print dash 
MOV AH, 02H
INT 21H 
LOOP LOSER 

MOV DL,'|'			; print (|) after every 5 dashes  in last line in output 
MOV AH, 02H
INT 21H  

DEC BL
JNZ LORA  


MOV DL, 10          ; print new line 
MOV AH,02H
INT 21H 
 


MOV CX, 02H 
ISLAM2:MOV DL, ' ' 		; print  sapaces 
MOV AH,02H
INT 21H 
LOOP ISLAM2 

MOV CX ,05H 
LOSER2: MOV DL,' '		; print spaces 
MOV AH, 02H
INT 21H 
LOOP LOSER2 


MOV DL,'5'			; print 5 
MOV AH, 02H
INT 21H 
 

MOV CX ,05H 
LOSER4: MOV DL,' ' 		;print spaces 
MOV AH, 02H
INT 21H 
LOOP LOSER4 

MOV DL,'1'			; print 1 
MOV AH, 02H
INT 21H 


MOV DL,'0'		 	; print spaces 
MOV AH, 02H
INT 21H 



MOV CX ,04H 
LOSER7: MOV DL,' '		; print space 
MOV AH, 02H
INT 21H 
LOOP LOSER7  

MOV DL,'1'				; print 1 
MOV AH, 02H
INT 21H 


MOV DL,'5'				; print 5 
MOV AH, 02H
INT 21H 
 

MOV CX ,04H 
LOSER10: MOV DL,' '		; print spaces 
MOV AH, 02H
INT 21H 
LOOP LOSER10  

MOV DL,'2'				;print 2 
MOV AH, 02H
INT 21H 



MOV DL,'0'				;print 0 
MOV AH, 02H
INT 21H 

RET
HISTO ENDP


MAIN PROC
;Initialize DS
MOV AX,@DATA
MOV DS,AX  


BALAPOSE: 


MOV DL, 10          ; print new line 
MOV AH,02H
INT 21H 

LEA DX,string1		; Print Matrices Multiplication
MOV AH,09h
INT 21H  

MOV DL, 10      	; code for new line 
MOV AH,02H
INT 21H 


LEA DX,string2		; Print Character Histogram	
MOV AH,09h
INT 21H 

MOV DL, 10      	; code for new line 
MOV AH,02H
INT 21H 


LEA DX,string3		; Print Exit
MOV AH,09h
INT 21H 

MOV DL, 10      	; code for new line 
MOV AH,02H
INT 21H 



LEA DX,string4		; Enter your choice:
MOV AH,09h
INT 21H 



MOV AH,01H 			; READ THE CHOICE 
INT 21H 
SUB AL,30H 

CMP AL,01H 
JE MATRIXMUL 
;JMP INVALIDDDD 
;MATRIXMUL  : CALL  MATMUL
;JMP BALAPOSE

INVALIDDDD :
CMP AL,02H
JE HISTOLABEL 
CMP AL,03H
JMP EXITLABEL 
HISTOLABEL: CALL HISTO 
 JMP BALAPOSE
EXITLABEL: CALL EXIT 
 JMP BALAPOSE 
 MATRIXMUL  : CALL  MATMUL
 JMP BALAPOSE 




MOV AH,4CH
INT 21h
MAIN ENDP
END MAIN 


.MODEL SMALL
.STACK
.DATA
 
inst3 DB "Adja meg a hatter szinkodjat!",10,13,"0 - fekete",10,13,"1 - kek",10,13,"2 - zold",10,13,"3 - cian",10,13,"4 - piros",10,13,"5 - lila",10,13,"6 - barna",10,13,"7 - szurke",10,13,"8 - sotetszurke",10,13,"9 - vilagoskek",10,13,"10 - vilagoszold",10,13,"11 - vilagoscian",10,13,"12 - vilagospiros",10,13,"13 - vilagoslila",10,13,"14 - sarga",10,13,"15 - feher",10,13,0
szinkod DB ?

.CODE
main proc

MOV AX, @data ;Adatszegmens be�ll�t�sa 
        
MOV DS, AX
MOV AX, 0B800h ;K�pernyo-mem�ria szegmensc�me ES-be 

MOV ES, AX  

PUSH BX
LEA BX, inst3 ;Az adat_3 c�me BX-be 
;CALL write_string ;Ki�r�s
call read_decimal 
MOV szinkod, DL
POP BX 
   
MOV AH, 06h    ; Scroll up function
XOR AL, AL     ; Clear entire screen
XOR CX, CX     ; Upper left corner CH=row, CL=column
MOV DX, 184FH  ; lower right corner DH=row, DL=column
MOV BH, szinkod 
SHL BH, 4
INT 10H

MOV AH, 4Ch ;Program befejez�se
INT 21h
main endp
          

read_decimal proc
PUSH AX ;AX ment�se a verembe
PUSH BX ;BX ment�se a verembe
MOV BL, 10 ;BX-be a sz�mrendszer alapsz�ma, ezzel szorzunk
XOR AX, AX ;AX t�rl�se
read_decimal_new:
CALL read_char ;Egy karakter beolvas�sa
CMP DL, CR ;ENTER ellenorz�se
JE read_decimal_end ;V�ge, ha ENTER volt az utols� karakter
SUB DL, "0" ;Karakterk�d minusz �0� k�dja
MUL BL ;AX szorz�sa 10-zel
ADD AL, DL ;A k�vetkezo helyi �rt�k hozz�ad�sa
JMP read_decimal_new ;A k�vetkezo karakter beolvas�sa
read_decimal_end:
MOV DL, AL ;DL-be a be�rt sz�m
POP BX ;AB vissza�ll�t�sa
POP AX ;AX vissza�ll�t�sa
RET ;Visszat�r�s a h�v� rutinba
read_decimal endp
         
read_char proc ;Karakter beolvas�sa. A beolvasott karakter DL-be ker�l
PUSH AX ;AX ment�se a verembe
MOV AH, 1 ;AH-ba a beolvas�s funkci�k�d
INT 21h ;Egy karakter beolvas�sa, a k�d AL-be ker�l
MOV DL, AL ;DL-be a karakter k�dja
POP AX ;AX vissza�ll�t�sa
RET ;Visszat�r�s a h�v� rutinba
read_char endp

write_char proc ;A DL-ben l�vo karakter ki�r�sa a k�pernyore
PUSH AX ;AX ment�se a verembe
MOV AH, 2 ; AH-ba a k�pernyore �r�s funkci�k�dja
INT 21h ; Karakter ki�r�sa
POP AX ;AX vissza�ll�t�sa
RET ;Visszat�r�s a h�v� rutinba
write_char endp 
                  
CR EQU 13 ;CR-be a kurzor a sor elej�re k�d
LF EQU 10 ;LF-be a kurzor �j sorba k�d   

cr_lf proc
PUSH DX ;DX ment�se a verembe
MOV DL, CR
CALL write_char ;kurzor a sor elej�re
MOV DL, LF
CALL write_char ;Kurzor egy sorral lejjebb
POP DX ;DX vissza�ll�t�sa
RET ;Visszat�r�s a h�v� rutinba
cr_lf endp                   
  
write_string proc ;BX-ben c�mzett karaktersorozat ki�r�sa 0 k�dig.
PUSH DX ;DX ment�se a verembe
PUSH BX ;BX ment�se a verembe
write_string_new:
MOV DL, [BX] ;DL-be egy karakter bet�lt�se
OR DL, DL ;DL vizsg�lata
JZ write_string_end ;0 eset�n kil�p�s
CALL write_char ;Karakter ki�r�sa
INC BX ;BX a k�vetkezo karakterre mutat
JMP write_string_new ;A k�vetkezo karakter bet�lt�se
write_string_end:
POP BX ;BX vissza�ll�t�sa
POP DX ;DX vissza�ll�t�sa
RET ;Visszat�r�s
write_string endp 

END main 
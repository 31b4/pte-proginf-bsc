.MODEL SMALL
.STACK
.DATA
 
inst1 DB "Adja meg az attributum erteket! (egesz szam, 128*vill+16*hatter+karakterszin)",10,13,0
inst3 DB "Adja meg a kiirando karaktert!",10,13,0

kar DB ? ;Ki�rand� karakter
att DB ? ;Ki�r�s attrib�tuma 

.CODE
main proc

MOV AX, @data ;Adatszegmens be�ll�t�sa 
        
MOV DS, AX
MOV AX, 0B800h ;K�pernyo-mem�ria szegmensc�me ES-be 

MOV ES, AX
XOR AX, AX ;AX t�rl�se
MOV BL, 160 ;Szorz� bet�lt�se BL-be

PUSH BX 
LEA BX, inst1 ;Az adat_1 c�me BX-be
CALL write_string ;Ki�r�s  
call read_att
call cr_lf

LEA BX, inst3 ;Az adat_3 c�me BX-be
CALL write_string ;Ki�r�s
call read_charcode
call cr_lf
POP BX 

MOV AL, kar ;AL-be a karakterk�d
MOV AH, att ;AH-ba a karakter attrib�tuma
 
PUSH AX      ; K�pernyo letorlese
XOR AX, AX
MOV AL, 3h
INT 10h
POP AX

MOV DI, 1838 
MOV ES:[DI], AX ;Bet�lt�s a k�pernyo-mem�ria kisz�m�tott c�m�re

MOV AH, 4Ch ;Program befejez�se
INT 21h

main endp
            
read_charcode proc
    
    PUSH AX ;AX ment�se a verembe
    MOV AH, 1 ;AH-ba a beolvas�s funkci�k�d
    INT 21h ;Egy karakter beolvas�sa, a k�d AL-be ker�l
    MOV kar, AL ;DL-be a karakter k�dja
    POP AX ;AX vissza�ll�t�sa
    RET ;Visszat�r�s a h�v� rutinba              
                                                    
read_charcode endp            
            
read_att proc
    PUSH AX
    PUSH BX
    MOV BL, 10
    XOR AX, AX
read_att_new:
    CALL read_char
    CMP DL, CR
    JE read_att_end
    SUB DL, "0"
    MUL BL
    ADD AL, DL
    JMP read_att_new

read_att_end:
    MOV att, AL
    POP BX
    POP AX
    RET
read_att endp
   

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
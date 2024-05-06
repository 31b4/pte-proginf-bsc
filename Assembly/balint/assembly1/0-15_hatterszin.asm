.MODEL SMALL
.STACK
.DATA
 
inst3 DB "Adja meg a hatter szinkodjat!",10,13,"0 - fekete",10,13,"1 - kek",10,13,"2 - zold",10,13,"3 - cian",10,13,"4 - piros",10,13,"5 - lila",10,13,"6 - barna",10,13,"7 - szurke",10,13,"8 - sotetszurke",10,13,"9 - vilagoskek",10,13,"10 - vilagoszold",10,13,"11 - vilagoscian",10,13,"12 - vilagospiros",10,13,"13 - vilagoslila",10,13,"14 - sarga",10,13,"15 - feher",10,13,0
szinkod DB ?

.CODE
main proc

MOV AX, @data ;Adatszegmens beállítása 
        
MOV DS, AX
MOV AX, 0B800h ;Képernyo-memória szegmenscíme ES-be 

MOV ES, AX  

PUSH BX
LEA BX, inst3 ;Az adat_3 címe BX-be 
;CALL write_string ;Kiírás
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

MOV AH, 4Ch ;Program befejezése
INT 21h
main endp
          

read_decimal proc
PUSH AX ;AX mentése a verembe
PUSH BX ;BX mentése a verembe
MOV BL, 10 ;BX-be a számrendszer alapszáma, ezzel szorzunk
XOR AX, AX ;AX törlése
read_decimal_new:
CALL read_char ;Egy karakter beolvasása
CMP DL, CR ;ENTER ellenorzése
JE read_decimal_end ;Vége, ha ENTER volt az utolsó karakter
SUB DL, "0" ;Karakterkód minusz ”0” kódja
MUL BL ;AX szorzása 10-zel
ADD AL, DL ;A következo helyi érték hozzáadása
JMP read_decimal_new ;A következo karakter beolvasása
read_decimal_end:
MOV DL, AL ;DL-be a beírt szám
POP BX ;AB visszaállítása
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba
read_decimal endp
         
read_char proc ;Karakter beolvasása. A beolvasott karakter DL-be kerül
PUSH AX ;AX mentése a verembe
MOV AH, 1 ;AH-ba a beolvasás funkciókód
INT 21h ;Egy karakter beolvasása, a kód AL-be kerül
MOV DL, AL ;DL-be a karakter kódja
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba
read_char endp

write_char proc ;A DL-ben lévo karakter kiírása a képernyore
PUSH AX ;AX mentése a verembe
MOV AH, 2 ; AH-ba a képernyore írás funkciókódja
INT 21h ; Karakter kiírása
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba
write_char endp 
                  
CR EQU 13 ;CR-be a kurzor a sor elejére kód
LF EQU 10 ;LF-be a kurzor új sorba kód   

cr_lf proc
PUSH DX ;DX mentése a verembe
MOV DL, CR
CALL write_char ;kurzor a sor elejére
MOV DL, LF
CALL write_char ;Kurzor egy sorral lejjebb
POP DX ;DX visszaállítása
RET ;Visszatérés a hívó rutinba
cr_lf endp                   
  
write_string proc ;BX-ben címzett karaktersorozat kiírása 0 kódig.
PUSH DX ;DX mentése a verembe
PUSH BX ;BX mentése a verembe
write_string_new:
MOV DL, [BX] ;DL-be egy karakter betöltése
OR DL, DL ;DL vizsgálata
JZ write_string_end ;0 esetén kilépés
CALL write_char ;Karakter kiírása
INC BX ;BX a következo karakterre mutat
JMP write_string_new ;A következo karakter betöltése
write_string_end:
POP BX ;BX visszaállítása
POP DX ;DX visszaállítása
RET ;Visszatérés
write_string endp 

END main 
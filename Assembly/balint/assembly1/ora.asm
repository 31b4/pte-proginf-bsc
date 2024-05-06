.MODEL SMALL
.STACK
.DATA?
adat DB 100 DUP (?) 
.CODE

main proc 
MOV AX, DGROUP ;Adatszegmens beállítása
MOV DS, AX
LEA BX, adat ;Az adatterület címe BX-be
CALL read_string ;Karaktersorozat beolvasása
CALL cr_lf ;Soremelés
CALL write_string ;Karaktersorozat visszaírása
MOV AH,4Ch ;Kilépés
INT 21h 
main endp

CR EQU 13
LF EQU 10 

write_char proc ;A DL-ben lévő karakter kiírása a képernyőre
PUSH AX ;AX mentése a verembe
MOV AH, 2 ; AH-ba a képernyőre írás funkciókódja
INT 21h ; Karakter kiírása
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba 
write_char endp

read_char proc ;Karakter beolvasása. A beolvasott karakter DL-be kerül
PUSH AX ;AX mentése a verembe
MOV AH, 1 ;AH-ba a beolvasás funkciókód
INT 21h ;Egy karakter beolvasása, a kód AL-be kerül
MOV DL, AL ;DL-be a karakter kódja
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba
read_char endp 

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
INC BX ;BX a következő karakterre mutat
JMP write_string_new ;A következő karakter betöltése
write_string_end:
POP BX ;BX visszaállítása
POP DX ;DX visszaállítása
RET ;Visszatérés
write_string endp 

read_string proc
PUSH DX ;DX mentése a verembe
PUSH BX ;BX mentése a verembe
read_string_new:
CALL read_char ;Egy karakter beolvasása
CMP DL, CR ;ENTER ellenőrzése
JE read_string_end ;Vége, ha ENTER volt az utolsó karakter
MOV [BX], DL ;Mentés az adatszegmensre
INC BX ;Következő adatcím
JMP read_string_new ;Következő karakter beolvasása
read_string_end:
XOR DL, DL
MOV [BX], DL ;Sztring lezárása 0-val
POP BX ;BX visszaállítása
POP DX ;DX visszaállítása
RET ;Visszatérés
read_string endp 

END main
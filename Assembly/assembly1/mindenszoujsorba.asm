.MODEL SMALL
.STACK
.DATA
adat DB "Fasz nigger genya",0
.CODE
main proc
MOV AX, DGROUP ;Adatszegmens beállítása
MOV DS, AX
LEA BX, adat
CALL write_string
MOV AH,4Ch ;Kilépés
INT 21h
main endp
write_string proc ;BX-ben címzett karaktersorozat kiírása 0 kódig.
PUSH DX ;DX mentése a verembe
PUSH BX ;BX mentése a verembe
write_string_new:
MOV DL, [BX] ;DL-be egy karakter betöltése
OR DL, DL ;DL vizsgálata
JZ write_string_end ;0 esetén kilépés
MOV AL, DL
CMP AL, 32
JE skip
JMP kiir
write_string_end:
POP BX ;BX visszaállítása
POP DX ;DX visszaállítása
RET ;Visszatérés

skip:
INC BX ;BX a következő karakterre mutat
CALL cr_lf
JMP write_string_new

kiir:
CALL write_char ;Karakter kiírása
INC BX
JMP write_string_new

write_string endp 



write_char proc 	;A DL-ben l�v� karakter ki�r�sa a k�perny�ben
    PUSH AX		;AX ment�se a verembe
    MOV AH,2		;AH-ba a k�perny�re �r�s funkci�k�dja
    INT 21h		;Karakter ki�r�sa
    POP AX		;AX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
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

END main 

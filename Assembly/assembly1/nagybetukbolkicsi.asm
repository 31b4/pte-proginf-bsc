.MODEL SMALL
.STACK
.DATA
adat DB "TUROSFASZ99"
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
CMP DL,"A"
JB kiir
CMP DL, "Z"
JA kiir
ADD DL,"a"-"A"
JMP kiir
write_string_end:
POP BX ;BX visszaállítása
POP DX ;DX visszaállítása
RET ;Visszatérés

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
END main 

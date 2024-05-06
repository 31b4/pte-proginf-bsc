MODEL SMALL
.STACK
.DATA
.CODE
main PROC
    MOV AX, dgroup ;Adatszegmens beállítása
    MOV AX, 0B800h ; Képernyő-memória szegmenscíme ES-be
    MOV ES, AX

    ; Állítsuk be a képernyőt 80x25-ös felbontásra.
    MOV AH, 0h ; Képernyőüzemmód
    MOV AL, 3h ; 80x25-ös felbontás, színes üzemmód
    INT 10H

    ; Bekeretező karakter beállítása
    CALL read_char
    MOV AL, DL ; Kiírandó karakter
    MOV AH, 4;Tetszőleges attribútum
    MOV DI, 0
    fill:
        MOV ES:[DI], AX ; Karakter beírása a képernyő-memóriába
        ADD DI, 2
        CMP DI, 4000   ; A képernyő egy sorának hossza (80 karakter * 2 byte/karakter)
        JL fill
    MOV AH, 4Ch ; Kilépés
    INT 21h
main ENDP
read_char proc		;Karakter beolvas�sa. A beolvasott karakter a DL-be ker�l
    PUSH AX		;AX ment�se a verembe
    MOV AH,1		;AH-ba a beolvas�s funkci�k�d
    INT 21h		;Egy karakter beolvas�sa, a k�d AL-be ker�l
    MOV DL, AL		;DL-be a karakter k�dja
    POP AX		;AX vissza�ll�t�sa		;Visszat�r�s a h�v� rutinba
    RET
read_char endp
END main
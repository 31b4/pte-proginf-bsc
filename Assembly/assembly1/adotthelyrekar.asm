.MODEL SMALL
.STACK
.DATA
    x DB 1
    y DB 1
    kar DB "X"	 ; Karakter ami hely�re helyettes�teni fogunk
.CODE
main proc
    CALL kiir
    MOV AH, 4Ch
    INT 21h
main endp
kiir proc
    MOV AX, dgroup ;Adatszegmens beállítása
    MOV AH, 0h ;Képernyőüzemmód
    MOV AL, 3h ;80x25-ös felbontás, színes üzemmód
    INT 10H 
    MOV DS, AX
    MOV AX, 0B800h ;Képernyő-memória szegmenscíme ES-be
    MOV ES, AX
    XOR AX, AX ;AX törlése
    MOV BL, 160 ;Szorzó betöltése BL-be
    CALL read_decimal
    MOV AL, DL
    DEC AL ;AL-1, az 1. karakter a memória 0. címén van
    MUL BL ;AL szorzása 160-nal
    MOV DI, AX ;DI-be a sorszámból számított memóriahely
    XOR AX, AX ;AX törlése 
    CALL read_decimal
    MOV AL, DL
    DEC AL ;AL-1, az 1. karakter a memória 0. címén van
    SHL AL, 1 ;AL szorzása 2-vel (1-el balra shift)
    ADD DI, AX ;DI-hez hozzáadjuk az oszlopszámból
    ;számított memóriahelyet 
    CALL read_char
    MOV AL, DL ;AL-be a karakterkód
    MOV AH, 4 ;TETSZŐLEGES ATTRIBÚTUM
    MOV ES:[DI], AX ;Betöltés a képernyő-memória kiszámított címére 
    RET
kiir endp
read_char proc		;Karakter beolvas�sa. A beolvasott karakter a DL-be ker�l
    PUSH AX		;AX ment�se a verembe
    MOV AH,1		;AH-ba a beolvas�s funkci�k�d
    INT 21h		;Egy karakter beolvas�sa, a k�d AL-be ker�l
    MOV DL, AL		;DL-be a karakter k�dja
    POP AX		;AX vissza�ll�t�sa		;Visszat�r�s a h�v� rutinba
    RET
read_char endp
CR EQU 13		;CR-be a kurzor a sor elej�re k�d
read_decimal proc
    PUSH AX		;AX ment�se a verembe
    PUSH BX		;BX ment�se a verembe
    MOV BL,10		;BX-be a sz�mrendszer alapsz�ma, ezzel szorzunk
    XOR AX,AX		;AX t�rl�se
read_decimal_new:
    CALL read_char	;Egy karakter beolvas�sa
    CMP DL,CR		;Enter ellen�rz�se
    JE read_decimal_end ;V�ge, ha ENTER volt az utols� karakter
    SUB DL,"0"		;Karakterk�d minusz 0 k�dja
    MUL BL		;AX szorz�sa 10-zel
    ADD AL,DL		;A k�vetkez� helyi�rt�k hozz�ad�sa
    JMP read_decimal_new    ;A k�vetkez� karakter beolvas�sa
read_decimal_end:
    MOV DL,AL		;DL-be a be�rt sz�m
    POP BX		;BX vissza�ll�t�sa
    POP AX		;AX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
read_decimal endp
LF EQU 10		;LF-be a kurzor �j sorba k�d
write_char proc 	;A DL-ben l�v� karakter ki�r�sa a k�perny�ben
    PUSH AX		;AX ment�se a verembe
    MOV AH,2		;AH-ba a k�perny�re �r�s funkci�k�dja
    INT 21h		;Karakter ki�r�sa
    POP AX		;AX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
write_char endp

cr_lf proc
    PUSH DX		;DX ment�se a verembe
    MOV DL,CR
    CALL write_char	;Kurzor a sor elej�re
    MOV DL,LF
    CALL write_char	;Kurzor egy sorral lejjebb
    POP DX		;DX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
cr_lf endp
END main
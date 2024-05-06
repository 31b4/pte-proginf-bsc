.MODEL SMALL
.STACK
.DATA
.CODE
main proc
    MOV AX, 0B800h ; Set video memory segment to ES
    MOV ES, AX
    ; Set video mode to 80x25 text mode with 16-color attribute
    MOV AH, 0h
    MOV AL, 3h
    INT 10h
    ; Calculate the offset for the center of the screen
    MOV DI, 1838 ; 80 characters per line * 12

    ; Read a character from input
    CALL read_char
    MOV AL, DL ; Character to display
    CALL cr_lf
    ; Read an integer from input
    CALL read_decimal
    MOV AH, DL ; Attribute (integer) for the character

    ; Write the character and attribute to the center of the screen
    MOV ES:[DI], AX

    ; Exit the program
    MOV AH, 4Ch
    INT 21h
main endp


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
END MAIN
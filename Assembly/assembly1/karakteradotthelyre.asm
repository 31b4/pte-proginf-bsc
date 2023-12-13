.model small
.stack
.data
    x DB 1
    y DB 1
    kar DB "X"	 ; Karakter ami hely�re helyettes�teni fogunk
    att db 2  ; Tetsz�leges attrib�tum
    
    feltetel_1a DB "Kerem adjon meg egy egesz szamot! (X koordinata) ",0
    feltetel_1b DB "Kerem adjon meg egy egesz szamot! (Y koordinata) ",0
    feltetel_1c DB "Kerem adjon meg egy tetszoleges szoveget! ",0
.code
main proc
    mov ax, dgroup
    mov ds, ax

    ; Feladatok szubrutinjainak megh�v�sa
    call karakter_adott_helyre

    mov ah, 4Ch
    int 21h
main endp

karakter_adott_helyre proc
    push bx
    push dx
    lea bx, feltetel_1a
    call write_string
    call read_decimal
    mov x, dl ; Elt�roljuk x koordin�t�t
    lea bx, feltetel_1b
    call write_string
    call read_decimal
    mov y, dl ; Elt�roljuk y koordin�t�t
    lea bx, feltetel_1c
    call write_string
    ret
endp karakter_adott_helyre

CR EQU 13		;CR-be a kurzor a sor elej�re k�d
LF EQU 10		;LF-be a kurzor �j sorba k�d

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

read_char proc		;Karakter beolvas�sa. A beolvasott karakter a DL-be ker�l
    PUSH AX		;AX ment�se a verembe
    MOV AH,1		;AH-ba a beolvas�s funkci�k�d
    INT 21h		;Egy karakter beolvas�sa, a k�d AL-be ker�l
    MOV DL, AL		;DL-be a karakter k�dja
    POP AX		;AX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
read_char endp

write_char proc 	;A DL-ben l�v� karakter ki�r�sa a k�perny�ben
    PUSH AX		;AX ment�se a verembe
    MOV AH,2		;AH-ba a k�perny�re �r�s funkci�k�dja
    INT 21h		;Karakter ki�r�sa
    POP AX		;AX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
write_char endp

write_string proc
    push dx
    push bx
write_string_new:
    mov dl, [bx]
    or dl, dl
    jz write_string_end
    call write_char
    inc bx
    jmp write_string_new
write_string_end:
    pop bx
    pop dx
    ret
write_string endp

end main

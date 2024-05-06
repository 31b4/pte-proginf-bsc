.model small
.stack
.data
    res DB 1
.code
main proc
    MOV AX, @data
    CALL read_decimal
    MOV AL, DL
    CALL read_decimal
    MUL DL
    CALL read_decimal
    MUL DL
    MOV DL, AL
    call write_decimal
    mov ah, 4Ch
    int 21h
main endp
CR EQU 13		;CR-be a kurzor a sor elej�re k�d
LF EQU 10
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
    CMP DL, 255
    JA read_decimal
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

write_char proc 	;A DL-ben l�v� karakter ki�r�sa a k�perny�ben
    PUSH AX		;AX ment�se a verembe
    MOV AH,2		;AH-ba a k�perny�re �r�s funkci�k�dja
    INT 21h		;Karakter ki�r�sa
    POP AX		;AX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
write_char endp

write_decimal proc
   PUSH AX		;AX ment�se a verembe
   PUSH CX		;CX ment�se a verembe
   PUSH DX
   PUSH SI
   XOR DH,DH
   MOV AX,DX
   MOV SI,10
   XOR CX,CX

decimal_non_zero:
   XOR DX,DX
   DIV SI
   PUSH DX
   INC CX
   OR AX,AX
   JNE decimal_non_zero

decimal_loop:
    POP DX
    CALL write_hexa_digit
    LOOP decimal_loop
    POP SI
    POP DX
    POP CX
    POP AX
    REt 	      ;	Visszat�r�s a h�v� rutinba
write_decimal endp

write_hexa_digit proc
    PUSH DX		;DX ment�se a verembe
    CMP DL,10		;DL �sszehasonl�t�sa 10-zel
    JB non_hexa_letter	;Ugr�s, ha kisevv 10-n�l
    ADD DL,"A"-"0"-10	;A-F bet�t kell ki�rni

    non_hexa_letter:
       ADD DL,"0"	;Az ASCII k�d megad�sa
       CALL write_char	;A karakter ki�r�sa
       POP DX		;DX vissza�ll�t�sa
       RET		;Visszat�r�s a h�v� rutinba
write_hexa_digit endp
END main
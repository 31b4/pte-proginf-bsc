CR EQU 13     ;CR-be a kurzor a sor elejére kód
LF EQU 10     ;LF-be a kurzor új sorba kód

.model small
.stack
.data
    x DB ?
    y DB ?
    attrib DB 0 ; Például itt fehér karakter a fekete háttéren
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Karakter beolvasása a konzolról
    call read_char
    mov dl, al       ; A beolvasott karakter elmentése

    ; X és Y koordináták beolvasása a konzolról
    call clear_screen ; Képernyő törlése
    lea dx, input_x   ; X koordináta beolvasásának üzenete
    mov ah, 09h       ; AH-be a string kiírás funkciókódja
    int 21h           ; Üzenet megjelenítése

    call read_decimal ; X koordináta beolvasása
    mov x, dl         ; X koordináta elmentése

    lea dx, input_y   ; Y koordináta beolvasásának üzenete
    mov ah, 09h       ; AH-be a string kiírás funkciókódja
    int 21h           ; Üzenet megjelenítése

    call read_decimal ; Y koordináta beolvasása
    mov y, dl         ; Y koordináta elmentése

    ; Karakter megjelenítése a megadott koordinátákon
    call write_char_at ; Karakter kiírása a megadott koordinátákon

    mov ah, 4Ch       ; Kilépés
    int 21h
main endp

clear_screen proc
    mov ah, 06h     ; AH-be a görgetés funkciókódja
    mov al, 0       ; AL-be a törlési attribútum
    mov bh, 07h     ; BH-be a kezdő sorszám
    mov dh, 24      ; DH-be a befejező sorszám
    mov dl, 79      ; DL-be az utolsó oszlop
    int 10h         ; Képernyő törlése
    ret
clear_screen endp

input_x db "Kerem adja meg az X koordinatat: $"
input_y db "Kerem adja meg az Y koordinatat: $"

write_char_at proc ; A DL-ben lévő karaktert az X és Y koordinátákra kiírja az attribútummal
    push ax      ; AX és BX mentése a verembe
    push bx
    push cx      ; CX mentése a verembe
    push dx      ; DX mentése a verembe

    mov ah, 02h  ; AH-be a karakter kiírás funkciókódja
    mov bh, 00h  ; BH-be a videómódot (0 = szabvány)
    mov dl, x    ; DL-be az X koordináta
    mov dh, y    ; DH-be az Y koordináta
    mov cx, 01h  ; CX-be a karakter ismétlődési száma
    int 10h      ; Karakter kiírása

    pop dx       ; DX visszaállítása
    pop cx       ; CX visszaállítása
    pop bx       ; BX és AX visszaállítása
    pop ax
    ret          ; Visszatérés a hívó rutinba
write_char_at endp

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
end main

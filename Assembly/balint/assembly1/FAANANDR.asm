.model small
.stack
.data
    x DB 1
    y DB 1
    kar DB "X"	 ; Karakter ami hely�re helyettes�teni fogunk
    att db 2  ; Tetsz�leges attrib�tum
    szoveg DB 100 DUP(?) ; Ide t�roljuk el a felhaszn�l� �ltal �rt sz�veget
    feltetel_1a DB "K�rem adjon meg egy eg�sz sz�mot! (X koordin�ta) ",0
    feltetel_1b DB "K�rem adjon meg egy eg�sz sz�mot! (Y koordin�ta) ",0
    feltetel_1c DB "K�rem adjon meg egy tetsz�leges sz�veget! ",0
    feltetel_2 DB "K�rem adjon meg egy b�jtos sz�mot! ",0
    feltetel_2b DB "A szorz�s eredm�nye: ",0
.code
main proc
    mov ax, dgroup
    mov ds, ax

    ; Feladatok szubrutinjainak megh�v�sa
    call elsoFeladat
    call masodikFeladat

    mov ah, 4Ch
    int 21h
main endp

; ZH feladatok

elsoFeladat proc
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
    lea bx, szoveg
    call read_string  ; Elt�roltuk BX-be a sz�veget
also_hatar: ; Itt ellen�rizz�k, hogy nagybet�-e
    mov dl, [bx]
    or dl, dl
    jz write_string_end ; Ellen�rizz�k a kil�p� felt�telt
    cmp dl, "A" ; Ellen�rizz�k, hogy a karakter nagyobb-e vagy egyenl� A-val
    jae felso_hatar
    mov kar, dl ; Ha nem nagybet� akkor ki�rjuk
    jmp kiir
felso_hatar:
    cmp dl, "Z" ; Ellen�rizz�k, hogy a karakter egyenl�, vagy kisebb Z-n�l
    jbe kisbetu
    mov kar, dl ; Ha nagyobb, mint Z akkor csak ki�rjuk
    jmp kiir
kisbetu:
    mov kar, dl ; Bemozgatjuk a kar adatszegmensbe, amit egy m�sik szubrutin haszn�l
    add kar, "a"-"A" ; Hozz�adjuk a k�dok k�l�nbs�g�t, ezzel kisbet�v� alak�tva
    jmp kiir
kiir:
    mov dl, kar
    call graph_display ; Megh�vom a grafikus szubrutint �s X,Y koordin�t�ra ki�rom
    inc x   ; Inkrement�ljuk X-t, hogy v�zszintesen �rja tov�bb
    inc bx
    jmp also_hatar
write_string_end:
    pop dx
    pop bx
    ret
elsoFeladat endp

masodikFeladat proc
    push ax
    push dx
    lea bx, feltetel_2
    call write_string	; Ki�rjuk, hogy mit v�runk be �s bek�rj�k, (h�romszor)
    call read_decimal
    mov al, dl	; Az els� �rt�ket AL-be mentj�k, �t fogjuk innent�l kezdve szorozni
    call write_string
    call read_decimal
    mul dl
    call write_string
    call read_decimal
    mul dl

    ; Ha megvolt a szorz�s, akkor ki�rjuk az eredm�nyt
    lea bx, feltetel_2b
    call write_string
    mov dl, al
    call write_decimal

    pop dx
    pop ax
    ret
masodikFeladat endp

graph_display proc	; Grafikus k�perny�re �r�shoz szubrutin
    push ax
    push bx
    push dx

    mov ax, 0B800h
    mov es, ax
    xor ax, ax	; AX t�rl�se
    mov bl, 160 ; Szorz� bet�lt�se Bl-be (2*80 => ez�rt 160)
    mov al, y	; AL-be ker�l Y �rt�ke
    dec al	; Cs�kkentj�k az �rt�k�t (kivonunk bel�le egyet)
    mul bl	; Szorzunk bl-el
    mov di, ax	; DI-be ker�l a
    xor ax, ax
    mov al, x
    dec al
    shl al, 1	; Al szorz�sa kett�vel, 1-el balra shift (kettes sz�mrendszer)
    add di, ax

    mov al, kar
    mov ah, att
    mov es:[di], ax

    pop dx
    pop bx
    pop ax
    ret
graph_display endp

CR EQU 13		;CR-be a kurzor a sor elej�re k�d
LF EQU 10		;LF-be a kurzor �j sorba k�d

cr_lf proc
    PUSH DX		;DX ment�se a verembe
    MOV DL,CR
    CALL write_char	;Kurzor a sor elej�re
    MOV DL,LF
    CALL write_char	;Kurzor egy sorral lejjebb
    POP DX		;DX vissza�ll�t�sa
    RET 		;Visszat�r�s a h�v� rutinba
cr_lf endp

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

read_string proc
    push dx
    push bx
read_string_new:
    call read_char
    cmp dl, cr		;ENTER ellen�rz�se
    je read_string_end
    mov [bx], dl
    inc bx
    jmp read_string_new
read_string_end:
    xor dl, dl
    mov [bx], dl
    pop bx
    pop dx
    ret
read_string endp

write_string proc
    push dx
    push bx
write_string_new:
    mov dl, [bx]
    or dl, dl
    jz write_string_end2
    call write_char
    inc bx
    jmp write_string_new
write_string_end2:
    pop bx
    pop dx
    ret
write_string endp

end main

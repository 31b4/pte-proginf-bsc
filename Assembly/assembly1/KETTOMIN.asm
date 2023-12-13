.model small
.stack
.data
    x DB 1
    y DB 1
    kar DB "X"
    szoveg DB 100 DUP(?)
    att DB 4
    feltetel DB "KÇrem adjon meg egy b†jtos sz†mot!",0
.code
main proc
    ; Olvassuk be x, y, kar Çs att adatszegmens ÇrtÇkeit
    mov ax, dgroup
    mov ds, ax
    lea bx, x		; Beolvassuk X ÇrtÇkÇt
    call read_decimal
    mov [bx], dl
    lea bx, y		; Beolvassuk Y ÇrtÇkÇt
    call read_decimal
    mov [bx], dl
    xor bx, bx
    lea bx, szoveg	; Beolvassuk az attrib£tum ÇrtÇkÇt
    call read_string
    call write_str
    call cr_lf
    call bajtos

    ;call graph_display

    mov ah, 4Ch
    int 21h
main endp

; M†sodik zh feladat
bajtos proc
    xor cx, cx
    mov ax, dgroup
    mov ds, ax
    lea bx, feltetel

    call write_string
    call cr_lf
    call read_decimal
    mov al, dl
    call write_string
    call cr_lf
    call read_decimal
    mul dl
    call write_string
    call cr_lf
    call read_decimal
    mul dl
    mov dl, al
    call write_decimal

    ret
bajtos endp

; Elsã zh feladat
write_str proc
    push dx
    push bx
    ;dec x
write_string_new:
    inc x
    mov dl, [bx]
    or dl, dl
    jz write_string_end
    ; EllenãrizzÅk, hogy nagybet˚-e
    cmp dl, "A"
    jae felso_hatar
felso_hatar:
    cmp dl, "Z"
    jbe low_case
    jmp kiir
low_case:
    add dl, 32
    jmp kiir
kiir:
    mov kar, dl
    call graph_display
    inc bx
    jmp write_string_new
write_string_end:
    pop bx
    pop dx
    ret
write_str endp

graph_display proc
    push ax
    push bx
    push dx

    mov ax, 0B800h
    mov es, ax
    xor ax, ax	; AX tîrlÇse
    mov bl, 160 ; Szorz¢ betîltÇse Bl-be (2*80 => ezÇrt 160)
    mov al, y	; AL-be kerÅl Y ÇrtÇke
    dec al	; CsîkkentjÅk az ÇrtÇkÇt (kivonunk belãle egyet)
    mul bl	; Szorzunk bl-el
    mov di, ax	; DI-be kerÅl a
    xor ax, ax
    mov al, x
    dec al
    shl al, 1	; Al szorz†sa kettãvel, 1-el balra shift (kette sz†mrendszer)
    add di, ax

    mov al, kar
    mov ah, att
    mov es:[di], ax

    pop dx
    pop bx
    pop ax
    ret
graph_display endp

CR EQU 13		;CR-be a kurzor a sor elejÇre k¢d
LF EQU 10		;LF-be a kurzor £j sorba k¢d

cr_lf proc
    PUSH DX		;DX mentÇse a verembe
    MOV DL,CR
    CALL write_char	;Kurzor a sor elejÇre
    MOV DL,LF
    CALL write_char	;Kurzor egy sorral lejjebb
    POP DX		;DX vissza†ll°t†sa
    RET 		;VisszatÇrÇs a h°v¢ rutinba
cr_lf endp

write_hexa_digit proc
    PUSH DX		;DX mentÇse a verembe
    CMP DL,10		;DL îsszehasonl°t†sa 10-zel
    JB non_hexa_letter	;Ugr†s, ha kisevv 10-nÇl
    ADD DL,"A"-"0"-10	;A-F bet˚t kell ki°rni

    non_hexa_letter:
       ADD DL,"0"	;Az ASCII k¢d megad†sa
       CALL write_char	;A karakter ki°r†sa
       POP DX		;DX vissza†ll°t†sa
       RET		;VisszatÇrÇs a h°v¢ rutinba
write_hexa_digit endp

write_decimal proc
   PUSH AX		;AX mentÇse a verembe
   PUSH CX		;CX mentÇse a verembe
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
    REt 	      ;	VisszatÇrÇs a h°v¢ rutinba
write_decimal endp

read_decimal proc
    PUSH AX		;AX mentÇse a verembe
    PUSH BX		;BX mentÇse a verembe
    MOV BL,10		;BX-be a sz†mrendszer alapsz†ma, ezzel szorzunk
    XOR AX,AX		;AX tîrlÇse
read_decimal_new:
    CALL read_char	;Egy karakter beolvas†sa
    CMP DL,CR		;Enter ellenãrzÇse
    JE read_decimal_end ;VÇge, ha ENTER volt az utols¢ karakter
    SUB DL,"0"		;Karakterk¢d minusz 0 k¢dja
    MUL BL		;AX szorz†sa 10-zel
    ADD AL,DL		;A kîvetkezã helyiÇrtÇk hozz†ad†sa
    JMP read_decimal_new    ;A kîvetkezã karakter beolvas†sa
read_decimal_end:
    MOV DL,AL		;DL-be a be°rt sz†m
    POP BX		;BX vissza†ll°t†sa
    POP AX		;AX vissza†ll°t†sa
    RET 		;VisszatÇrÇs a h°v¢ rutinba
read_decimal endp

read_char proc		;Karakter beolvas†sa. A beolvasott karakter a DL-be kerÅl
    PUSH AX		;AX mentÇse a verembe
    MOV AH,1		;AH-ba a beolvas†s funkci¢k¢d
    INT 21h		;Egy karakter beolvas†sa, a k¢d AL-be kerÅl
    MOV DL, AL		;DL-be a karakter k¢dja
    POP AX		;AX vissza†ll°t†sa
    RET 		;VisszatÇrÇs a h°v¢ rutinba
read_char endp

write_char proc 	;A DL-ben lÇvã karakter ki°r†sa a kÇpernyãben
    PUSH AX		;AX mentÇse a verembe
    MOV AH,2		;AH-ba a kÇpernyãre °r†s funkci¢k¢dja
    INT 21h		;Karakter ki°r†sa
    POP AX		;AX vissza†ll°t†sa
    RET 		;VisszatÇrÇs a h°v¢ rutinba
write_char endp

read_string proc
    push dx
    push bx
read_string_new:
    call read_char
    cmp dl, cr		;ENTER ellenãrzÇse
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

.MODEL SMALL
.STACK
.CODE
main proc		;F‹program
    CALL read_char	;Karakter beolvas sa
    XOR DH,DH		;DH t”rl‚se
    call cr_lf

    CALL write_decimal	;Karakterk¢d konvert l sa decim lis sz mm  ‚s ki¡r sa
    call cr_lf

    call read_char
    xor dh, dh
    call cr_lf
    call write_decimal

    MOV AH,4Ch		;AH-ba a visszat‚r‚s funkci¢k¢dja
    INT 21h		;Visszat‚r‚s az oper ci¢s rendszerbe
main endp

CR EQU 13		;CR-be a kurzor a sor elej‚re k¢d
LF EQU 10		;LF-be a kurzor £j sorba k¢d

cr_lf proc
    PUSH DX		;DX ment‚se a verembe
    MOV DL,CR
    CALL write_char	;Kurzor a sor elej‚re
    MOV DL,LF
    CALL write_char	;Kurzor egy sorral lejjebb
    POP DX		;DX vissza ll¡t sa
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
cr_lf endp

read_char proc		;Karakter beolvas sa. A beolvasott karakter a DL-be kerl
    PUSH AX		;AX ment‚se a verembe
    MOV AH,1		;AH-ba a beolvas s funkci¢k¢d
    INT 21h		;Egy karakter beolvas sa, a k¢d AL-be kerl
    MOV DL, AL		;DL-be a karakter k¢dja
    POP AX		;AX vissza ll¡t sa
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
read_char endp

write_char proc 	;A DL-ben l‚v‹ karakter ki¡r sa a k‚perny‹ben
    PUSH AX		;AX ment‚se a verembe
    MOV AH,2		;AH-ba a k‚perny‹re ¡r s funkci¢k¢dja
    INT 21h		;Karakter ki¡r sa
    POP AX		;AX vissza ll¡t sa
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
write_char endp

write_binary proc
    PUSH BX		;BX ment‚se a verembe
    PUSH CX		;CX ment‚se a verembe
    PUSH DX		;DX ment‚se a verembe
    MOV BL,DL		;DL m sol sa BL-be
    MOV CX,8		;Ciklusv ltoz¢(CX) be lll¡t sa

    binary_digit:
	XOR DL,DL	;DL t”rl‚se
	RCL BL,1	;Rot l s balra eggyel, kil‚p‹ bit CF-be
	ADC DL,"0"	;DL = DL + 48 +CF
	CALL write_char      ;Bin ris digit ki¡r sa
	LOOP binary_digit    ;Vissza a ciklus elej‚re
	POP DX		;DX vissza ll¡t sa
	POP CX		;CX vissza ll¡t sa
	POP BX		;BX vissza ll¡t sa
	RET		;Visszat‚r‚s a h¡v¢ rutinba
write_binary endp

write_hexa proc
    PUSH CX		;CX ment‚se a verembe
    PUSH DX		;DX ment‚se a verembe
    MOV DH,DL		;DL ment‚se
    MOV CL,4		;Shift-el‚s sz ma CX-be
    SHR DL,CL		;DL shiftel‚se 4 helylel jobbra

    CALL write_hexa_digit   ;HExadecim lsi digit ki¡r sa
    MOV DL,DH		;Az eredeti ‚rt‚k visszat”lt‚se DL-be
    AND DL,0Fh		;A fels‹ n‚gy bit t”rl‚se

    CALL write_hexa_digit   ;Hexadecim lis digit ki¡r sa
    POP DX		;DX vissza ll¡t sa
    POP CX		;CX vissza ll¡t sa
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
write_hexa endp

write_hexa_digit proc
    PUSH DX		;DX ment‚se a verembe
    CMP DL,10		;DL ”sszehasonl¡t sa 10-zel
    JB non_hexa_letter	;Ugr s, ha kisevv 10-n‚l
    ADD DL,"A"-"0"-10	;A-F betût kell ki¡rni

    non_hexa_letter:
       ADD DL,"0"	;Az ASCII k¢d megad sa
       CALL write_char	;A karakter ki¡r sa
       POP DX		;DX vissza ll¡t sa
       RET		;Visszat‚r‚s a h¡v¢ rutinba
write_hexa_digit endp

write_decimal proc
   PUSH AX		;AX ment‚se a verembe
   PUSH CX		;CX ment‚se a verembe
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
    REt 	      ;	Visszat‚r‚s a h¡v¢ rutinba
write_decimal endp

read_decimal proc
    PUSH AX		;AX ment‚se a verembe
    PUSH BX		;BX ment‚se a verembe
    MOV BL,10		;BX-be a sz mrendszer alapsz ma, ezzel szorzunk
    XOR AX,AX		;AX t”rl‚se
read_decimal_new:
    CALL read_char	;Egy karakter beolvas sa
    CMP DL,CR		;Enter ellen‹rz‚se
    JE read_decimal_end ;V‚ge, ha ENTER volt az utols¢ karakter

    SUB DL,"0"		;Karakterk¢d minusz 0 k¢dja
    MUL BL		;AX szorz sa 10-zel
    ADD AL,DL		;A k”vetkez‹ helyi‚rt‚k hozz ad sa
    JMP read_decimal_new    ;A k”vetkez‹ karakter beolvas sa

read_decimal_end:
    MOV DL,AL		;DL-be a be¡rt sz m
    POP BX		;BX vissza ll¡t sa
    POP AX		;AX vissza ll¡t sa
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
read_decimal endp

read_hexa proc
    PUSH AX		;AX ment‚se a verembe
    PUSH BX		;BX ment‚se a verembe
    MOV BL,10h		;BX-be a sz mrendszer alapsz ma, ezzel sz¢rzunk
    XOR AX,AX		;AX t”rl‚se

read_hexa_new:
    CALL read_char	;Egy karakter beolvas sa
    CMP DL,CR		;ENTER ellen‹rz‚se
    JE read_hexa_end	;V‚ge, ha enter volt az utols¢ karakter

    CALL upcase 	;Kisbetût  talak¡tja nagy 
    SUB DL,"0"		;Karakterk¢d minusz nulla k¢dja
    CMP DL,9		;Sz mjegy karakter?
    JBE read_hexa_decimal   ;Ugr s, ha decim lis sz mjegy
    SUB DL,7		;Betû eset‚n m‚g 7-et levonunk
read_hexa_decimal:
    MUL BL		;AX szorz sa az alappal
    ADD AL,DL		;A k”vetkez‹ helyi‚rt‚k hozz ad sa
    JMP read_hexa_new	;A k”vetkez‹ karakter beolvas sa
read_hexa_end:
    MOV DL,AL		;DL-be a be¡rt sz m
    POP BX		;BX vissza ll¡t sa
    POP AX		;AX vissza ll¡t sa
    RET
read_hexa endp

upcase proc		;DL-ben l‚v‹ kisbetû  talak¡t sa nagybetûv‚
    CMP DL,"a"		;A karakterk¢d ‚s a k¢dj nak ”sszehasonl¡t sa
    JB upcase_end	;A k¢d kisebb, mint a, nem kisbetû
    CMP DL,"z"		;A karakterk¢d ‚s z k¢dj nak ”sszehasonl¡t sa
    JA upcase_end	;A k¢d nagyobb mint z, nem kisbetû
    SUB DL,"a"-"A"	;DL-b‹l a k¢dok kl”nbs‚g‚t
upcase_end:
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
upcase endp

read_binary proc
    PUSH AX		;AX ment‚se a verembe
    XOR AX,AX		;AX t”rl‚se
read_binary_new:
    CALL read_char	;Egy karakter beolvas sa
    CMP DL,CR		;Enter ellen‹rz‚se
    JE read_binary_end	;V‚ge, ha enter volt az utols¢ karakter
    SUB DL,"0"		;Karakterk¢d minusz 0 k¢dja
    SAL AL,1		;Szorz s 2-vel,shift eggyel balra
    ADD Al,DL		;A k”vetkez‹ helyi‚rt‚k hozz ad sa
    JMP read_binary_new ;A k”vetkez‹ karakter beolvas sa
read_binary_end:
    MOV DL,AL		;DL-be be¡rt sz m
    POP AX		;AX vissza ll¡t sa
    RET 		;Visszat‚r‚s a h¡v¢ rutinba
read_binary endp

END main		;END+a f‹program neve

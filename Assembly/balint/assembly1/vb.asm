.MODEL SMALL
.STACK
.CODE

main PROC  
    CALL read_hexa   ; Read the first hexadecimal value
    PUSH AX          ; Push the first value onto the stack

    CALL read_hexa   ; Read the second hexadecimal value
    PUSH AX          ; Push the second value onto the stack
    CALL compare
   
main ENDP
CR EQU 13       
read_hexa proc
    PUSH AX ;AX mentése a verembe
    PUSH BX ;BX mentése a verembe
    MOV BL, 10h ;BX-be a számrendszer alapszáma, ezzel szorzunk
    XOR AX, AX ;AX törlése
read_hexa_new:
    CALL read_char ;Egy karakter beolvasása
    CMP DL, CR  ;ENTER ellenőrzése
    JE read_hexa_end ;Vége, ha ENTER volt az utolsó karakter
    CALL upcase ;Kisbetű átalakítása naggyá
    SUB DL, "0" ;Karakterkód minusz ”0” kódja
    CMP DL, 9 ;Számjegy karakter?
    JBE read_hexa_decimal ;Ugrás, ha decimális számjegy
    SUB DL,7 ;Betű esetén még 7-et levonunk
    read_hexa_decimal:
    MUL BL ;AX szorzása az alappal
    ADD AL, DL ;A következő helyi érték hozzáadása
    JMP read_hexa_new ;A következő karakter beolvasása
    read_hexa_end:
    MOV DL, AL ;DL-be a beírt szám
    POP BX ;BX visszaállítása
    POP AX ;AX visszaállítása
    RET ;Visszatérés a hívó rutinba
read_hexa endp 

upcase proc ;DL-ben lévő kisbetű átalakítása nagybetűvé
    CMP DL, "a" ;A karakterkód és ”a” kódjának összehasonlítása
    JB upcase_end ;A kód kisebb, mint ”a”, nem kisbetű
    CMP DL, "z" ;A karakterkód és ”z” kódjának összehasonlítása
    JA upcase_end ;A kód nagyobb, mint ”z”, nem kisbetű
    SUB DL, "a"-"A" ;DL-ből a kódok különbségét
    upcase_end:
    RET ;Visszatérés a hívó rutinba
upcase endp 

read_char proc              ;Karakter beolvasása. A beolvasott karakter DL-be kerül
    PUSH AX                 ;AX mentése a verembe
    MOV AH,8                ;AH-ba a beolvasás funkciókód (echo nélkül)
    INT 21h                 ;Egy karakter beolvasása, a kód AL-be kerül 
    MOV DL,AL               ;DL-be a karakter kódja
    POP AX                  ;AX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
read_char endp

write_hexa PROC             ;A DL-ben lévő két hexa számjegy kiírása
    PUSH CX                 ;CX mentése a verembe
    PUSH DX                 ;DX mentése a verembe
    MOV DH, DL              ;DL mentése
    MOV CL, 4               ;Shift-elés száma CX-be
    SHR DL, CL              ;DL shift-elése 4 hellyel jobbra
    CALL write_hexa_digit   ;Hexadecimálisdigitkiírása
    MOV DL, DH              ;Az eredeti érték visszatöltése DL-be
    AND DL, 0Fh             ;A felső négy bit törlése
    CALL write_hexa_digit   ;Hexadecimálisdigitkiírása
    POP DX                  ;DX visszaállítása
    POP CX                  ;CX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
write_hexa ENDP

write_hexa_digit PROC
    PUSH DX                 ;DX mentése a verembe
    CMP DL, 10              ;DL összehasonlítása 10-zel
    JB non_hexa_letter      ;Ugrás, ha kisebb 10-nél
    ADD DL, "A"-"0"-10      ;A – F betűt kell kiírni
non_hexa_letter:
    ADD DL, "0"             ;Az ASCII kód megadása
    CALL write_char         ;A karakter kiírása
    POP DX                  ;DX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
write_hexa_digit ENDP

write_char proc
    PUSH AX
    MOV AH, 2
    INT 21h
    POP AX
    RET
write_char endp

compare proc
    POP BX
    POP AX
    CMP AX, BX
    JB second_is_larger
    CALL write_hexa
    JMP exit_program
second_is_larger:
    MOV AX, BX 
    CALL write_hexa
    JMP exit_program

exit_program:
    MOV AH, 4Ch      
    INT 21h

compare endp


 


END main

.MODEL SMALL
.STACK
.CODE
main proc ;Főprogram
CALL read_decimal ;Osztandó beolvasása
MOV AL, DL
CALL cr_lf
CALL read_decimal ;Osztó beolvasása
MOV BL, DL
CALL cr_lf
XOR DX, DX ;DH (maradék), DL (hányados) törlése
MOV CX, 8 ;Ciklusszám
Cycle:
SHL AL,1 ;Osztandó eggyel balra, CR-be a kilépő bit
RCL DH,1 ;Maradék eggyel balra, belép a CR tartalma
SHL DL,1 ;Hányados eggyel balra
CMP DH, BL
JB Next ;A maradék kiseb,mint az osztó
SUB DH, BL ;Az osztó kivonása a maradékból
INC DL ;Hányados növelése
Next:
LOOP Cycle
Stop:
CALL write_decimal ;Hányados (DL) kiírása
CALL cr_lf ;Soremelés
MOV DL, DH
CALL write_decimal ;Maradék (CL) kiírása
MOV AH,4Ch ;Kilépés
INT 21h
main endp

read_char PROC              ;Karakter beolvasása. A beolvasott karakter DL-be kerül
    PUSH AX                 ;AX mentése a verembe
    MOV AH,8                ;AH-ba a beolvasás funkciókód (echo nélkül)
    INT 21h                 ;Egy karakter beolvasása, a kód AL-be kerül 
    MOV DL,AL               ;DL-be a karakter kódja
    POP AX                  ;AX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
read_char ENDP

read_decimal PROC
    PUSH AX                 ;AX mentése a verembe
    PUSH BX                 ;BX mentése a verembe
    MOV BL, 10              ;BX-be a számrendszer alapszáma, ezzel szorzunk
    XOR AX, AX              ;AX törlése
read_decimal_new: 
    CALL read_char          ;Egy karakter beolvasása
    CMP DL, CR              ;ENTER ellenőrzése
    JE read_decimal_end     ;Vége, ha ENTER volt az utolsó karakter
    SUB DL, "0"             ;Karakterkód minusz ”0” kódja
    MUL BL                  ;AX szorzása 10-zel
    ADD AL, DL              ;A következő helyi érték hozzáadása
    JMP read_decimal_new    ;A következő karakter beolvasása
read_decimal_end:
    MOV DL, AL              ;DL-be a beírt szám
    POP BX                  ;AB visszaállítása
    POP AX                  ;AX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
read_decimal ENDP


write_char PROC             ;A DL-ben lévő karakter kiírása a képernyőre
    PUSH AX                 ;AX mentése a verembe
    MOV AH,2                ;AH-ba a képernyőre írás funkciókódja
    INT 21h                 ;Karakter kiírása
    POP AX                  ;AX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
write_char ENDP

write_decimal PROC
    PUSH AX                 ;AX mentése a verembe
    PUSH CX                 ;CX mentése a verembe
    PUSH DX                 ;DX mentése a verembe
    PUSH SI                 ;SI mentése a verembe
    XOR DH, DH              ;DH törlése
    MOV AX, DX              ;AX-be a szám
    MOV SI, 10              ;SI-ba az osztó
    XOR CX, CX              ;CX-be kerül az osztások száma
decimal_non_zero:
    XOR DX, DX              ;DX törlése
    DIV SI                  ;DX:AX 32 bites szám osztása SI-vel, az eredmény AX- be, a maradék DX-be kerül
    PUSH DX                 ;DX mentése a verembe
    INC CX                  ;Számláló növelése
    OR AX, AX               ;Státuszbitek beállítása AX-nek megfelelően
    JNE decimal_non_zero    ;Vissza, ha az eredmény még nem nulla
decimal_loop:
    POP DX                  ;Az elmentett maradék visszahívása
    CALL write_hexa_digit   ;Egy decimális digit kiírása
    LOOP decimal_loop
    POP SI                  ;SI visszaállítása
    POP DX                  ;DX visszaállítása
    POP CX                  ;CX visszaállítása
    POP AX                  ;AX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
write_decimal ENDP

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

write_binary PROC           ;kiírandó adat a DL-ben
    PUSH BX                 ;BX mentése a verembe
    PUSH CX                 ;CX mentése a verembe
    PUSH DX                 ;DX mentése a verembe
    MOV BL, DL              ;DL másolása BL-be
    MOV CX, 8               ;Ciklusváltozó (CX) beállítása
binary_digit:       
    XOR DL, DL              ;DL törlése
    RCL BL, 1               ;Rotálás balra eggyel, kilépő bit a CF-be
    ADC DL, "0"             ;DL = DL + 48 + CF
    CALL write_char         ;Bináris digit kiírása
    LOOP binary_digit       ;Vissza a ciklus elejére
    POP DX                  ;DX visszaállítása
    POP CX                  ;CX visszaállítása
    POP BX                  ;BX visszaállítása
    RET                     ;Visszatérés a hívó rutinba
write_binary ENDP

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

	CR EQU 13 ;CR-be a kurzor a sor elejére kód
	LF EQU 10 ;LF-be a kurzor új sorba kód


cr_lf PROC
		PUSH DX ;DX mentese a verembe
		MOV DL, CR
		CALL write_char ;kurzor a sor elejere
		MOV DL, LF
		CALL write_char ;Kurzor egy sorral lejjebb
		POP DX ;DX visszaallitasa
		RET ;Visszateres a hivo rutinba
	cr_lf ENDP

END main
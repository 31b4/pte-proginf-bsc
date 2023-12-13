.MODEL SMALL
.STACK
.DATA
 
inst1 DB "Adja meg az attributum erteket! (egesz szam, 128*vill+16*hatter+karakterszin)",10,13,0
inst3 DB "Adja meg a kiirando karaktert!",10,13,0

kar DB ? ;Kiírandó karakter
att DB ? ;Kiírás attribútuma 

.CODE
main proc

MOV AX, @data ;Adatszegmens beállítása 
        
MOV DS, AX
MOV AX, 0B800h ;Képernyo-memória szegmenscíme ES-be 

MOV ES, AX
XOR AX, AX ;AX törlése
MOV BL, 160 ;Szorzó betöltése BL-be

PUSH BX 
LEA BX, inst1 ;Az adat_1 címe BX-be
CALL write_string ;Kiírás  
call read_att
call cr_lf

LEA BX, inst3 ;Az adat_3 címe BX-be
CALL write_string ;Kiírás
call read_charcode
call cr_lf
POP BX 

MOV AL, kar ;AL-be a karakterkód
MOV AH, att ;AH-ba a karakter attribútuma
 
PUSH AX      ; Képernyo letorlese
XOR AX, AX
MOV AL, 3h
INT 10h
POP AX

MOV DI, 1838 
MOV ES:[DI], AX ;Betöltés a képernyo-memória kiszámított címére

MOV AH, 4Ch ;Program befejezése
INT 21h

main endp
            
read_charcode proc
    
    PUSH AX ;AX mentése a verembe
    MOV AH, 1 ;AH-ba a beolvasás funkciókód
    INT 21h ;Egy karakter beolvasása, a kód AL-be kerül
    MOV kar, AL ;DL-be a karakter kódja
    POP AX ;AX visszaállítása
    RET ;Visszatérés a hívó rutinba              
                                                    
read_charcode endp            
            
read_att proc
    PUSH AX
    PUSH BX
    MOV BL, 10
    XOR AX, AX
read_att_new:
    CALL read_char
    CMP DL, CR
    JE read_att_end
    SUB DL, "0"
    MUL BL
    ADD AL, DL
    JMP read_att_new

read_att_end:
    MOV att, AL
    POP BX
    POP AX
    RET
read_att endp
   

read_char proc ;Karakter beolvasása. A beolvasott karakter DL-be kerül
PUSH AX ;AX mentése a verembe
MOV AH, 1 ;AH-ba a beolvasás funkciókód
INT 21h ;Egy karakter beolvasása, a kód AL-be kerül
MOV DL, AL ;DL-be a karakter kódja
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba
read_char endp

write_char proc ;A DL-ben lévo karakter kiírása a képernyore
PUSH AX ;AX mentése a verembe
MOV AH, 2 ; AH-ba a képernyore írás funkciókódja
INT 21h ; Karakter kiírása
POP AX ;AX visszaállítása
RET ;Visszatérés a hívó rutinba
write_char endp 
                  
CR EQU 13 ;CR-be a kurzor a sor elejére kód
LF EQU 10 ;LF-be a kurzor új sorba kód   

cr_lf proc
PUSH DX ;DX mentése a verembe
MOV DL, CR
CALL write_char ;kurzor a sor elejére
MOV DL, LF
CALL write_char ;Kurzor egy sorral lejjebb
POP DX ;DX visszaállítása
RET ;Visszatérés a hívó rutinba
cr_lf endp                   
 
 
write_string proc ;BX-ben címzett karaktersorozat kiírása 0 kódig.
PUSH DX ;DX mentése a verembe
PUSH BX ;BX mentése a verembe
write_string_new:
MOV DL, [BX] ;DL-be egy karakter betöltése
OR DL, DL ;DL vizsgálata
JZ write_string_end ;0 esetén kilépés
CALL write_char ;Karakter kiírása
INC BX ;BX a következo karakterre mutat
JMP write_string_new ;A következo karakter betöltése
write_string_end:
POP BX ;BX visszaállítása
POP DX ;DX visszaállítása
RET ;Visszatérés
write_string endp 


END main 
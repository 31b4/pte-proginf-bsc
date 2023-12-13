.MODEL SMALL
.STACK
.DATA
    prompt1 DB "X koordinata megadasa: ", 0
    prompt2 DB "Y koordinata megadasa ", 0
    prompt3 DB "Kiirando szoveg megadasa ", 0
.DATA?
    x DB 1 DUP (?)
    y DB 1 DUP (?)
    attr DB 1 DUP (?)
.CODE

main proc
    MOV AX, dgroup ;Adatszegmens beállítása
    MOV DS, AX

    CALL kordinata_input

    CALL szoveg_input

    CALL delete_screen
    ;Állítsuk be a képernyőt 80x25-ös felbontásra.
    MOV AH, 0h ;Képernyőüzemmód
    MOV AL, 3h ;80x25-ös felbontás, színes üzemmód
    INT 10h

    MOV attr, 40

    CALL write_string_graphic

    MOV AH,4Ch ;Kilépés a programból
    INT 21h

main endp



szoveg_input proc
    LEA BX, prompt3
    CALL write_string
    CALL new_line
    CALL read_string
szoveg_input endp

delete_screen proc
    mov AH, 06h    ; AH = 06h: Törlés
    mov AL, 0      ; AL = 0: Karakter a képernyőn
    mov CX, 0      ; CX = 0: Kezdeti pozíció (bal felső sarok)
    mov dh, 24     ; DH = 24: Sorok száma
    mov DL, 79     ; DL = 79: Oszlopok száma
    int 10h        ; Int 10h BIOS meghívása
    mov AH, 02h    ; AH = 02h: Kurzor pozíció beállítása
    mov BH, 0      ; BH = 0: Oldal 0
    mov DH, 0      ; DH = 0: Sor 0
    mov DL, 0      ; DL = 0: Oszlop 0
    int 10h        ; Int 10h BIOS meghívása
delete_screen endp

write_string_graphic proc
    PUSH DX ;DX mentése a verembe
    PUSH BX ;BX mentése a verembe
write_string_new_graphic:
    MOV DL, [BX] ;DL-be egy karakter betöltése
    OR DL, DL ;DL vizsgálata
    JZ write_string_end_graphic ;0 esetén kilépés
    CALL write_screen
    INC x
    INC BX ;BX a következő karakterre mutat
    JMP write_string_new_graphic ;A következő karakter betöltése
write_string_end_graphic:
    POP BX ;BX visszaállítása
    POP DX ;DX visszaállítása
    RET ;Visszatérés
write_string_graphic endp
kordinata_input proc
    LEA BX, prompt1
    CALL write_string
    LEA BX, x
    CALL read_decimal
    MOV [BX], DL

    LEA BX, prompt2
    CALL write_string
    LEA BX, y
    CALL read_decimal
    MOV [BX], DL
kordinata_input endp
new_line proc
    PUSH DX

    ;Sor eleje (10-as parancs), kiírjuk hogy megtörténjen
    MOV DL, 10
    CALL write_char
    ;új sor (13-es parancs), kiírjuk hogy megtörténjen
    MOV DL, 13
    CALL write_char

    POP DX

    RET
new_line endp

read_decimal proc
    PUSH AX
    PUSH BX

    MOV BL, 10
    XOR AX, AX; AX Törlése
read_decimal_new:
    CALL read_char; Beolvassuk DL-be a karaktert
    CMP DL, 13 ; DL-t összevetjük a 13-al azaz enterrel
    JE read_decimal_end ; Ha enter akkor ugrunk

    SUB DL, "0" ; Karakter minusz 0 karakter 
    MUL BL ; AL*DL=AX, de amúgy a DL-be tárolódik vagy mi
    ADD AL, DL ; A következő helyiérték hozzáadása
    JMP read_decimal_new ; a következő karakter beolvasásáa

read_decimal_end:
    MOV DL, AL

    POP BX
    POP AX

    RET
read_decimal endp

write_string proc ;BX-ben címzett karaktersorozat kiírása 0 kódig, kisbetűssé alakítással.
    PUSH DX ;DX mentése a verembe
    PUSH BX ;BX mentése a verembe
write_string_new:
    MOV DL, [BX] ;DL-be egy karakter betöltése
    OR DL, DL ;DL vizsgálata
    JZ write_string_end ;0 esetén kilépés
    CALL write_char ;Karakter kiírása
    INC BX ;BX a következő karakterre mutat
    JMP write_string_new ;A következő karakter betöltése
write_string_end:
    POP BX ;BX visszaállítása
    POP DX ;DX visszaállítása
    RET ;Visszatérés
write_string endp

convert_to_lowercase proc ;DL-ben lévő nagybetű átalakítása kisbetűvé
    CMP DL, "A" ;A karakterkód és ”A” kódjának összehasonlítása
    JB convert_to_lowercase_end ;A kód kisebb, mint ”A”, nem nagybetű
    CMP DL, "Z" ;A karakterkód és ”Z” kódjának összehasonlítása
    JA convert_to_lowercase_end ;A kód nagyobb, mint ”Z”, nem nagybetű
    ADD DL, "a"-"A" ;DL-hez a kódok különbségét hozzáadjuk, hogy kisbetű legyen
convert_to_lowercase_end:
    RET ;Visszatérés a hívó rutinba
convert_to_lowercase endp


write_char proc
    PUSH AX

    ;AH 2-es parancs az a kiírás, kiírja ami a DL-ben van (Data Low)
    MOV AH, 2
    INT 21h

    POP AX
    RET
write_char endp

read_string proc
    PUSH DX ;DX mentése a verembe
    PUSH BX ;BX mentése a verembe
read_string_new:
    CALL read_char ;Egy karakter beolvasása
    CMP DL, 13 ;ENTER ellenőrzése
    JE read_string_end ;Vége, ha ENTER volt az utolsó karakter
    MOV [BX], DL ;Mentés az adatszegmensre
    INC BX ;Következő adatcím
    JMP read_string_new ;Következő karakter beolvasása
read_string_end:
    XOR DL, DL
    MOV [BX], DL ;Sztring lezárása 0-val
    POP BX ;BX visszaállítása
    POP DX ;DX visszaállítása
    RET ;Visszatérés
read_string endp

read_char proc
    PUSH AX ; AX-ben benne van az AL, AH, ezt beleteszem a verembe, azért mivel AH és AL-el dolgozunk,
    ;És szeretnénk hogy ez után a procedúra után is az legyen benne mint ami elötte volt
    MOV AH, 1; Beolvasás utasítás az 1
    INT 21h ; Elvégezzük az AH-ban lévő utasítást.
    ;AH-ban van az utasítás, és AL-be (Accumlator Low) fogja nekünk eltárolni azt amit beolvastunk a konzolról
    MOV DL, AL ; DL-be tároljuk el az AL-be beolvasott adatot, mivel azzal lehet dolgozni is.
    POP AX ; Vissza állítjuk AL, AH-t arra ami volt eredetileg a procedúra elött.
    RET
read_char endp

write_screen proc
    PUSH AX
    PUSH BX
    PUSH DX

    MOV AX, dgroup ;Adatszegmens beállítása 
    MOV DS, AX 
    MOV AX, 0B800h ;Képernyő-memória szegmenscíme ES-be 
    MOV ES, AX 
    XOR AX, AX ;AX törlése 
    MOV BL, 160 ;Szorzó betöltése BL-be 
    MOV AL, y ;Y koordináta betöltése AL-be 
    DEC AL ;AL-1, az 1. karakter a memória 0. címén van
    MUL BL ;AL szorzása 160-nal 
    MOV DI, AX ;DI-be a sorszámból számított memóriahely 
    XOR AX, AX ;AX törlése 
    MOV AL, x ;X koordináta betöltése AL-be 
    DEC AL ;AL-1, az 1. karakter a memória 0. címén van
    SHL AL, 1 ;AL szorzása 2-vel (1-el balra shift) 
    ADD DI, AX ;DI-hez hozzáadjuk az oszlopszámból számított memóriahelyet 
    CALL convert_to_lowercase
    MOV AL, DL ;AL-be a karakterkód 
    MOV AH, attr ;AH-ba a karakter attribútuma 
    MOV ES:[DI], AX ;Betöltés a képernyő-memória kiszámított címére

    POP DX
    POP BX
    POP AX

    RET
write_screen endp

END main
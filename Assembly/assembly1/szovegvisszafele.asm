.MODEL SMALL
.STACK
.DATA
adat DB "Fasztarisznyaniggercigany", 0  ; Adjunk hozzá null-terminátort a sztringhez
.CODE
main PROC
    MOV AX, @DATA      ; DS beállítása az adatok szegmensére
    MOV DS, AX

    LEA BX, adat
    CALL count_length

    LEA BX, adat
    ADD BX, CX        ; Az utolsó karakterre mutatunk
    CALL write_string_reverse  ; Módosított eljárás hívása

    MOV AH, 4Ch  ; Kilépés
    INT 21h
main ENDP

count_length PROC
    PUSH CX          ; CX mentése a verembe
    MOV CX, 0        ; CX nullázása
    count_length_new:
        MOV AL, [BX] ; AL-be egy karakter betöltése
        OR AL, AL     ; AL vizsgálata
        JZ count_length_end  ; Ha az AL nullás, kilépés
        INC CX
        INC BX
        JMP count_length_new
    count_length_end:
    POP CX           ; CX visszaállítása
    DEC BX           ; Null-terminátor visszaállítása
    RET
count_length ENDP

write_string_reverse PROC
    PUSH CX        ; CX mentése a verembe
    MOV CX, 0      ; CX nullázása
    write_string_reverse_new:
        DEC BX       ; BX visszaállítása a karakterre
        MOV DL, [BX] ; DL-be egy karakter betöltése
        CALL write_char  ; Karakter kiírása
        INC CX
        CMP BX, OFFSET adat ; A sztring elejéig értünk?
        JNZ write_string_reverse_new
    POP CX         ; CX visszaállítása
    RET
write_string_reverse ENDP

write_char PROC ; A DL-ben lévő karakter kiírása a képernyőben
    PUSH AX     ; AX mentése a verembe
    MOV AH, 2   ; AH-ba a képernyőre írás funkciókódja
    INT 21h     ; Karakter kiírása
    POP AX      ; AX visszaállítása
    RET         ; Visszatérés a hívó rutinba
write_char ENDP

END main

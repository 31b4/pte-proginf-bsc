.model small
.stack 100h
.data
    textMsg db 'Enter text: $'
    colMsg db 'Enter column number (0-79): $'
    text db 80 dup(' '), '$' ; Max 80 karakteres szöveg
    column db ?

.code
start:
    mov ax, @data
    mov ds, ax

    ; Szöveg bekérése
    mov ah, 9
    lea dx, textMsg
    int 21h
    lea dx, text
    mov ah, 0Ah
    int 21h

    ; Oszlopszám bekérése
    mov ah, 9
    lea dx, colMsg
    int 21h
    call ReadNumber
    mov column, al ; Az eredményt elmentjük

    ; Képernyő törlése
    call ClearScreen

    ; Szöveg kiírása függőlegesen
    call PrintVertical

    ; Kilépés
    mov ax, 4C00h
    int 21h

ReadNumber proc
    ; Egyszerű szám beolvasása (egyjegyű)
    mov ah, 1
    int 21h
    sub al, '0' ; ASCII karakterből átalakítjuk a számot
    ret
ReadNumber endp

ClearScreen proc
    ; Képernyő törlése
    mov ah, 0
    int 10h
    ret
ClearScreen endp

PrintVertical proc
    ; Szöveg függőleges kiírása
    ; Inicializálás
    mov si, offset text   ; SI regiszter a szöveg kezdetét mutatja
    mov cl, column        ; Oszlopszám CX-ben

    ; Függőleges kiírás
    verticalLoop:
        mov ah, 02h         ; AH=02h: Kurzor pozíció beállítása
        mov bh, 0           ; BH=0: Képernyő oldalának sorszáma
        mov dh, 0           ; DH=0: Sor
        mov dl, cl          ; DL=column: Oszlop
        int 10h             ; Kurzor pozíció beállítása

        mov al, [si]        ; Betöltjük az aktuális karaktert
        cmp al, '$'         ; Ha a karakter a végjel ('$'), kilépünk
        je  endPrintVertical

        ; Karakter kiírása
        mov ah, 09h         ; AH=09h: Karakter kiírása
        int 21h             ; Meghívjuk a karakter kiírás szolgáltatást

        inc si              ; Következő karakterre lépünk
        inc cl              ; Következő oszlopra lépünk

        jmp verticalLoop   ; Ugrás a következő iterációhoz

    endPrintVertical:
    ret
PrintVertical endp

end start

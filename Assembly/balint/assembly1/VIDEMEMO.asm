.model small
.stack
.code
main proc
    mov ax, 0B800h  ; K�perny� mem�ria szegmensc�me ES-be
    mov es, ax
    ; Be�ll�tjuk a k�perny�t 80*25-�s felbont�sra
    mov ah, 0h	; K�perny��zemm�d
    mov al, 3h	; 80x25-�s felbont�s, sz�nes �zemm�d
    int 10H

    mov di, 1838 ; K�perny� k�zep�nek ofszetc�me
    mov al, "*"  ; Ki�rand� karakter
    mov ah, 128+16*7+4 ; Sz�nk�d, sz�rke h�tt�r, piros karakter, villog
    mov es:[di], ax ; Karakter be�r�sa k�perny� mem�ri�j�ba

    mov ah, 4Ch
    int 21h
main endp
    END main

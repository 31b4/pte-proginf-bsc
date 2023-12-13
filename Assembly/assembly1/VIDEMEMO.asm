.model small
.stack
.code
main proc
    mov ax, 0B800h  ; KÇpernyã mem¢ria szegmensc°me ES-be
    mov es, ax
    ; Be†ll°tjuk a kÇpernyãt 80*25-îs felbont†sra
    mov ah, 0h	; KÇpernyãÅzemm¢d
    mov al, 3h	; 80x25-îs felbont†s, sz°nes Åzemm¢d
    int 10H

    mov di, 1838 ; KÇpernyã kîzepÇnek ofszetc°me
    mov al, "*"  ; Ki°rand¢ karakter
    mov ah, 128+16*7+4 ; Sz°nk¢d, szÅrke h†ttÇr, piros karakter, villog
    mov es:[di], ax ; Karakter be°r†sa kÇpernyã mem¢ri†j†ba

    mov ah, 4Ch
    int 21h
main endp
    END main

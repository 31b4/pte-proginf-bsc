ORG 100h ; Az elrendelése 100h-hoz

MOV AH, 0 ; Funkció: beolvasás karaktert anélkül, hogy várna az Enter-re
INT 16h ; 16h int 8086/8088-as szolgáltatás

MOV BL, AL ; Első karakter tárolása

MOV AH, 2 ; Funkció: karakter kiírása a képernyőre
INT 21h ; 21h int 8086/8088-as szolgáltatás

MOV AH, 0 ; Funkció: beolvasás karaktert anélkül, hogy várna az Enter-re
INT 16h ; 16h int 8086/8088-as szolgáltatás

MOV CL, AL ; Második karakter tárolása

MOV AH, 2 ; Funkció: karakter kiírása a képernyőre
INT 21h ; 21h int 8086/8088-as szolgáltatás

SUB BL, '0' ; ASCII kódból való konvertálás számmá
SUB CL, '0' ; ASCII kódból való konvertálás számmá

CMP BL, CL ; Összehasonlítás

JG greater ; Ugrás a greater címre, ha BL > CL
JL less ; Ugrás a less címre, ha BL < CL

; Ha ide érünk, akkor a két szám egyenlő
MOV DL, 'E' ; Egyenlő karakter
JMP print_result ; Ugrás a print_result címre

greater:
MOV DL, 'G' ; Nagyobb karakter
JMP print_result ; Ugrás a print_result címre

less:
MOV DL, 'L' ; Kisebb karakter

print_result:
; Az eredmény karakterének kiírása
MOV AH, 2 ; Funkció: karakter kiírása a képernyőre
INT 21h ; 21h int 8086/8088-as szolgáltatás

MOV AH, 4Ch ; Programból való kilépés
INT 21h

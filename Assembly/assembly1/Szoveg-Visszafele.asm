.MODEL SMALL
.STACK
.DATA
	String DB "TesZT szTrING", 0
	String_LEN EQU $ - String

.CODE
	MAIN PROC
		CALL clear_screen
		CALL write_string_backwards
		CALL sys_exit
	MAIN ENDP

	write_string_backwards PROC
		MOV AX, DGROUP 					; adatszegmens cimenek kinyerese
		MOV DS, AX 						; adatszegmens cimenek tarolasa DS-ben (hosszu tavu tarolas)
		LEA BX, String + String_LEN - 2 ; loop countert az utolso valos karakterre allitjuk // -2 azert kell, hogy a tulcsordulast es a binaris 0-t (= endbitet) elkerüljük
		LEA CX, String 					; segedregiszter bezetese, mely az adott szoveg elso karakterere mutat // szukseges a ciklus megallitasahoz -- igy tudjuk megallitani a kiiratast amikor elerunk a string elso karakterehez

		previous_char:
			MOV DL, [BX] 				; a pointer adott cimen található érték (= karakter) kimentése DL-be  // a cimet folyamatosan növeljük BL incrementálásval
			OR DL, DL					; DL reset 
			CALL write_char				; karakter kiiratasa
			CMP BX, CX 					; teszteljuk, hogy elertunk-e a string elso karakterehez
			JE stop						; ha elertunk visszafele a string elso karakterehez, kilepunk

			DEC BX 						; decere,emtomg loop counter so that we'll skip to the previous character
			JMP previous_char
		stop:
			RET
	write_string_backwards ENDP

    clear_screen PROC
        xor AL,AL
        xor CX,CX
        MOV DH,49          
        MOV DL,79           
        MOV BH,7         
        MOV AH,6
        INT 10h          
        RET
    clear_screen ENDP

	write_char PROC ;A DL-ben levo karakter kiirasa a kepernyore
		PUSH AX ;AX mentese a verembe
		MOV AH, 2 ; AH-ba a kepernyore iras funkciokodja
		INT 21h ; Karakter kiirasa
		POP AX ;AX visszaallitasa
		RET ;Visszateres a hivo rutinba
	write_char ENDP

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

	sys_exit PROC
		MOV AH, 4CH ; system CALL: sys_exit
		INT 21H ; interrupt to perform the previous system CALL
	sys_exit ENDP

END main
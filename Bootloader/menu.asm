org 0x7e00
jmp 0x0000:main

data:

;Titulos do menu
titulo		db "Assembloo",0
jogar	db "Jogar", 0
instrucoes	db "Instrucoes", 0
creditos	db "Creditos", 0


;Cursor
setinha		db ">", 0


;Instrucoes
linha1		db "Assembloo eh um jogo muito divertido!", 0
linha2		db "Seu objetivo eh descobrir a palavra", 0           
linha2b 	db "certa em ate 6 tentativas.", 0
linha3		db "Todas as palavras possuem 5 letras", 0
linha3b		db "e nao contem acentos.", 0
linha4		db "Caso a letra esteja na posicao correta", 0
linha4b		db "ela ficara ", 0
linha5		db "Caso ela pertenca a palavra, mas nao", 0
linha5b		db "esteja na posicao correta, ela ficara", 0
linha6 		db "E caso ela nao pertenca a palavra, o caracter nao mudara de cor.", 0
linha7 		db "Boa sorte!", 0
verde			db "VERDE", 0
amarelo		db "AMARELA", 0

;Creditos
hugo 			db "Hugo Medeiros (ham4)", 0
marcela 	db "Marcela Asfora (maa5)", 0
paulo 		db "Paulo Oliveira (prof)", 0
esc 			db "esc para voltar", 0


;Tux
tux 			db 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 0, 0, 0, 0, 15, 15, 0, 0, 0, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 15, 0, 0, 0, 0, 0, 14, 14, 0, 14, 14, 0, 14, 14, 0, 0, 0, 0, 0, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 0, 14, 14, 0, 0, 14, 14, 14, 14, 14, 14, 0, 14, 0, 0, 0, 0, 14, 14, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0, 14, 14, 14, 14, 14, 14, 14, 14, 0, 0, 0, 0, 0, 0, 15, 14, 14, 14, 14, 14, 14, 15, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0




main:
xor ax, ax
mov bx, ax
mov cx, ax
call modo_video

call printa_titulos

call tux_jogar


jmp $










getchar:			;OK
	mov ah, 0
	int 16h
	ret

printa_titulos:					;OK	
  mov ah, 02h
  mov bh, 0
  mov dh, 3      ;linha
  mov dl, 15     ;coluna
  int 10h


  mov si, titulo
  mov bl, 15	 ;white

  call printCor

  mov bl, 11	 ;light cyan

  mov ah, 02h
  mov dh, 10	 ;linha
  mov dl, 10	 ;coluna
  int 10h
  mov si, jogar
  call printCor

  mov ah, 02h
  mov dh, 15	 ;linha
  int 10h
  mov si, instrucoes
  call printCor

  mov ah, 02h
  mov dh, 20	 ;linha
  int 10h
  mov si, creditos
  call printCor
 
  ret

printCor:					;string é printada			;OK
	lodsb
	cmp al, 0
	je .exit
	call printchar
	call printCor
	.exit:
		ret
	
printchar:			;OK
	mov ah, 0xe
	int 10h
	ret

modo_video:					;colocar no modo video 		;OK
	mov ah, 0
	mov al, 13h				;0Dh - Graphics - 320x200
	int 10h

	mov ah, 0xb				;setando cor da borda/fundo
	mov bh, 0
	mov bl, 6 			    	;preto
	int 10h

	mov ah, 06h    ; funcao de scrollar pra alterar a cor da tela
	xor al, al     ; 
	xor cx, cx     ; 
	mov dl, 320
	mov dh, 200
	mov bh, 8      ; dark gray
	int 10h

	ret

tux_jogar:				;		OK
	call creditos_off
	call instrucoes_off
	call print_tux_jogar
	.leitura:
		call getchar
		cmp al, 115			; se 's' for typado
		je tux_instrucoes
		cmp al, 13 			; se '/r' - enter for apertado
		je jogo
		cmp al, 119			; se 'w' for typado
		je tux_creditos 
		jmp .leitura
	ret

print_tux_jogar:			;	OK
  mov cx, 60 
  mov dx, 71
  mov si, tux
  mov ah, 0ch
  mov bh, 0
  .loop_1:						
		inc dx
    cmp dx, 89      ; 72+17 
    je .end              
    mov cx, 60
    .loop_2:
    cmp cx, 74       ; 60+14
    je .loop_1
    lodsb         
    int 10h
    inc cx
    jmp .loop_2  
		.end: 
	  	ret

jogar_off:			;OK	
	mov cx, 60 
  mov dx, 71
  mov si, tux
  mov ah, 0ch
  mov bh, 0
  mov al, 8
  .loop_jog_off:
		inc dx
    cmp dx, 89      ; 72+17 
    je .end              
    mov cx, 60
    .loop_2:
    cmp cx, 74       ; 60+14
    je .loop_jog_off      
    int 10h
    inc cx
    jmp .loop_2  
		.end: 
	  	ret

tux_instrucoes:				;	OK
	call jogar_off
	call creditos_off
	call print_tux_instrucoes
	.leitura:
		call getchar
		cmp al, 115			; se 's' for typado
		je tux_creditos
		cmp al, 13 			; se '/r' - enter for apertado
		je show_instrucoes
		cmp al, 119			; se 'w' for typado
		je tux_jogar
		jmp .leitura
	ret

print_tux_instrucoes:		;OK	
  mov cx, 60 
  mov dx, 111
  mov si, tux
  mov ah, 0ch
  mov bh, 0
  .loop_1:							; OK
		inc dx
    cmp dx, 129      ; 112+17 
    je .end              
    mov cx, 60
    .loop_2:
    cmp cx, 74       ; 60+14
    je .loop_1
    lodsb         
    int 10h
    inc cx
    jmp .loop_2  
		.end: 
	  	ret

instrucoes_off:			;OK	
	mov cx, 60 
  mov dx, 111
  mov si, tux
  mov ah, 0ch
  mov bh, 0
  mov al, 8
  .loop_jog_off:
		inc dx
    cmp dx, 129      ; 112+17 
    je .end              
    mov cx, 60
    .loop_2:
    cmp cx, 74       ; 60+14
    je .loop_jog_off      
    int 10h
    inc cx
    jmp .loop_2  
		.end: 
	  	ret

show_instrucoes:
	call modo_video
	call printa_instrucoes
	.checagem:
		call getchar
		cmp al, 27		; check if esc is pressed 
		je main
		jmp .checagem
		ret

printa_instrucoes:		;OK	
	mov ah, 02h
  mov bh, 0
  mov dh, 3      ;linha
  mov dl, 14     ;coluna
  int 10h

  mov bl, 11 		 ;light cyan
  mov si, instrucoes
  call printCor

  mov bl, 15 		 ;white
  mov dl, 1	 	 ;coluna

  mov ah, 02h
  mov dh, 7	 ;linha
  int 10h
  mov si, linha1
  call printCor

  mov ah, 02h
  mov dh, 10	 ;linha
  int 10h
  mov si, linha2
  call printCor


  mov ah, 02h		
  mov dh, 11	 ;linha
  mov dl, 5	 	 ;coluna
  int 10h
  mov si, linha2b
  call printCor

  mov dl, 1	 	 ;coluna
  mov ah, 02h
  mov dh, 13	 ;linha
  int 10h
  mov si, linha3
  call printCor


  mov ah, 02h		;
  mov dh, 14	 ;linha
  mov dl, 8
  int 10h
  mov si, linha3b
  call printCor

  mov dl, 1	 	 ;coluna
  mov ah, 02h
  mov dh, 16	 ;linha
  int 10h
  mov si, linha4
  call printCor
  


  mov ah, 02h		
  mov dh, 17	 ;linha
  mov dl, 10	 	 ;coluna
  int 10h
  mov si, linha4b
  call printCor
  
  mov dl, 1	 	 ;coluna
  mov si, verde
  mov bl, 10 	 ; light green
  call printCor

  mov bl, 15 	 ;white
  mov ah, 02h
  mov dh, 19	 ;linha
  int 10h
  mov si, linha5
  call printCor


  mov ah, 02h		
  mov dh, 20	 ;linha
  int 10h
  mov si, linha5b
  call printCor

  mov bl, 14 	;yellow
  mov ah, 02h
  mov dh, 21 	;linha
  mov dl, 15  ;coluna
  int 10h
  mov si, amarelo
  call printCor

  mov dl, 25	;coluna

  mov bl, 13 	 ;light magenta
  mov ah, 02h
  mov dh, 24	 ;linha
  int 10h
  mov si, linha7
  call printCor

  mov bl, 12 	;light red 
	mov ah, 02h
  mov dh, 0	 	;linha
  int 10h
  mov si, esc
  call printCor


  ret

tux_creditos:				;	OK
	call jogar_off
	call instrucoes_off
	call print_tux_creditos
	.leitura:
		call getchar
		cmp al, 115			; se 's' for typado
		je tux_jogar
		cmp al, 13 			; se '/r' - enter for apertado
		je show_creditos
		cmp al, 119 		; se 'w' for typado
		je tux_instrucoes
		jmp .leitura
		ret

print_tux_creditos:			;	OK
  mov cx, 60 
  mov dx, 151
  mov si, tux
  mov ah, 0ch
  mov bh, 0
  .loop_1:						
		inc dx
    cmp dx, 169      ; 152+17 
    je .end              
    mov cx, 60
    .loop_2:
    cmp cx, 74       ; 60+14
    je .loop_1
    lodsb         
    int 10h
    inc cx
    jmp .loop_2  
		.end: 
	  	ret

creditos_off:			;OK	
	mov cx, 60 
  mov dx, 151
  mov si, tux
  mov ah, 0ch
  mov bh, 0
  mov al, 8
  .loop_jog_off:
		inc dx
    cmp dx, 169      ; 152+17 
    je .end              
    mov cx, 60
    .loop_2:
    cmp cx, 74       ; 60+14
    je .loop_jog_off      
    int 10h
    inc cx
    jmp .loop_2  
		.end: 
	  	ret

show_creditos:		;OK
	call modo_video
	call printa_creditos
	.checagem:
		call getchar
		cmp al, 27		; check if esc is pressed 
		je main
		jmp .checagem
		ret

printa_creditos:	;OK	
	mov ah, 02h
  mov bh, 0
  mov dh, 3      ;linha
  mov dl, 15     ;coluna
  int 10h

  mov bl, 11 		 ;light cyan
  mov si, creditos
  call printCor

  mov bl, 10 		 ;light green
  mov dl, 10	   ;coluna

  mov ah, 02h
  mov dh, 10	 ;linha
  int 10h
  mov si, hugo
  call printCor

  mov ah, 02h
  mov dh, 15	 ;linha
  int 10h
  mov si, marcela
  call printCor

  mov ah, 02h
  mov dh, 20	 ;linha
  int 10h
  mov si, paulo
  call printCor

  mov bl, 12 	;light red 
	mov ah, 02h
  mov dh, 0	 	;linha
  mov dl, 25 	; coluna
  int 10h
  mov si, esc
  call printCor


  ret


jogo:
    mov ax,0x860    
    mov es,ax      ;Buffer adress pointer
    xor bx,bx      
    mov ah,0x02    ;Read Sectors From Drive
    mov al,8       ;Sectors to read count
    mov ch,0       ;Cylinder
    mov cl,7       ;Sector
    mov dh,0       ;Head
    mov dl,0       ;Drive
    int 13h
    jc jogo        ;If it doesnt work, try jogo again
    
jmp 0x8600
	


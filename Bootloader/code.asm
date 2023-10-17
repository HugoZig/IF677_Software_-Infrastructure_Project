org 0x7c00        
jmp main 
data:

input times 5 db 0

flags times 10 db 0  	;checar se o numero ja foi gerado
anterior times 1 db 0 	;ultimo numero gerado

main:
xor ax, ax
mov bx, ax
mov cx, ax

call firstgenerate     ;usar da primeira vez quer for gerar
call generate 	       ;usar das proximas vezes
		       ;numero gerado fica em al

call generate

jmp $

firstgenerate:				;gera o primeiro numero a partir do clock
	call clocknumber		;numero em al
	mov dh, 0 			;limpar dh
	
	mov si, anterior
	mov byte[si], al 		;registrar numero gerado 

	mov di, flags 
	add di, ax
	inc byte[di] 			;registrar que numero ja foi gerado

	ret

generate:				;gerar da segunda vez para frente
	call clocknumber 		;gera a partir de clock
	call check 			;checa se o numero ja foi escolhido

	mov si, anterior 
	mov byte[si], al 		;registra numero gerado

	ret

clocknumber:
	mov AH, 00h      
        int 1AH      ; o valores de cx e dx sao definidos com base no clock interno      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 10    
        div  cx       ; dx possui o resto de ax/cx (de 0 a 9)

        xor ah, ah
        mov al,dl     ; al = dl (ja que dx < 10, ax = dx)
        ret

check:
	xor ah, ah
	mov dx, ax	; dx vai ser usado para comparar
	.compair:
		mov di, flags
		add di, dx
		cmp byte[di], 1 	; checa se o numero em ax ja ocorreu
		jne .isnew

	.tryagain:
		call random 		; funcao que gera um novo numero
		mov di, flags
		add di, dx
		cmp byte[di], 1 	; checa se o novo numero ja ocorreu
		jne .isnew

	.keeptrying:
		call addingthree	; a funcao so acaba quando um novo numero e gerado

	.isnew:
		inc byte[di]
		mov al, dl
		ret

random:				; gera um novo numero com base na equacao:
	xor dx, dx		; X = (Xˆ2 + Xanterior + 1) mod 10
	mul ax			
	mov si, anterior
	inc ax			
	add al, byte[si]	
	mov cx, 10
	div cx 			; novo numero em dx	
        ret		

addingthree:			; com base na equacao X = (X + 3) mod 10
	mov cx, 10 		; essa funcao so acaba quando um numero novo e encontrado
	mov bx, ax
	.procurando:
		xor dx, dx
		mov ax, bx
		add ax, 3
		mov bx, ax
		div cx 		; novo numero fica em dx
		mov di, flags
		add di, dx
		cmp byte[di], 1
		jne .achei
		jmp .procurando
	.achei:
		xor ah, ah
		ret

times 510-($-$$) db 0
dw 0xaa55


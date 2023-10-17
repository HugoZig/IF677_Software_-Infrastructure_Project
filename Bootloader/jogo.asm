;nasm -f bin LogicaJogo.asm -o LogicaJogo.bin 
;qemu-system-i386 LogicaJogo.bin 
org 0x8600
jmp 0x0000:start

palavras: db "STACK",0,"TASK",0,0,"LODSB",0,"POPA",0,0,"STORE",0,"STOSB",0,"FILE",0,0,"PILHA",0,"CHAR",0,0,"LINUX",0, "PUSHA",0,"LOOP",0,0,"MAIN",0,0,"PRINT",0,"LOAD",0,0,"MUTEX",0,"PIXEL",0,"MENU",0,0,"BOOT",0,0,"BYTE",0,0

coluna: db 0
linha: db 0
count: db 0
colunaP: dw 0
linhaP: dw 0
limiteL: dw 0
limiteC: dw 0
count2: db 0
tam: db 0
letras: times 26 db 48
reserva: times 26 db 48
qtdPalavras db 0

flags times 20 db 0     ;checar se o numero ja foi gerado
anterior times 1 db 0   ;ultimo numero gerado

resposta: times 6 db 0
entrada: times 6 db 0

vencedor: db "Parabens! Pressione enter para a proxima palavra",0
perdedor: db "BURRO",0
TerminouJogo: db "Fim",0

seal db 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 9, 9, 9, 9, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 9, 15, 15, 15, 9, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 15, 15, 15, 9, 0, 0, 9, 8, 7, 15, 15, 15, 15, 8, 7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 8, 9, 8, 8, 15, 8, 8, 15, 8, 8, 15, 15, 8, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 8, 15, 15, 15, 15, 15, 15, 15, 15, 8, 8, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 8, 0, 9, 8, 15, 8, 15, 8, 15, 15, 15, 15, 8, 15, 15, 15, 15, 15, 15, 15, 15, 9, 15, 15, 15, 15, 9, 0, 0, 9, 15, 8, 15, 8, 15, 15, 15, 15, 9, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 9, 9, 15, 15, 9, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 9, 15, 15, 15, 15, 9, 15, 15, 9, 9, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 9, 9, 9, 9, 15, 15, 15, 15, 9, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 9, 9, 9, 9, 9, 0, 9, 9, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

bear db 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 15, 15, 15, 15, 15, 15, 15, 9, 9, 9, 0, 0, 0, 0, 0, 9, 15, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 9, 15, 15, 8, 15, 8, 8, 8, 15, 8, 15, 15, 9, 0, 0, 0, 0, 0, 9, 15, 15, 13, 15, 15, 15, 8, 15, 15, 15, 13, 15, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 8, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 9, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 9, 9, 15, 15, 9, 15, 15, 15, 15, 15, 15, 15, 9, 15, 15, 9, 9, 0, 9, 15, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 15, 9, 9, 15, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 15, 9, 9, 15, 15, 15, 15, 15, 9, 15, 15, 9, 15, 15, 9, 15, 15, 15, 15, 15, 9, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0

%macro printchar 1
    mov ah, 02h
    mov bh, 0 
    mov dh, byte[linha]  ;Linha
    mov dl, byte[coluna]  ;Coluna
    int 10h

    mov ah, 0xe
    mov bh, 0
    mov bl, %1
    int 10h
%endmacro

start:
; limpando registradores
xor ax, ax
mov ds, ax
mov es, ax
mov byte[qtdPalavras], 10

call firstgenerate
call ProcurarPalavra

.loopJogo:
    cmp byte[qtdPalavras], 0
        je .fimJogo
    dec byte[qtdPalavras]

    mov byte[linha], 7 ; mudar para linha em que começa
    call modo_video
    call Tamanho
    call Tabela
    call LimparVetores
    call printfoca
    call printurso
    mov si, resposta
    call Alocarletras
    call leitura
    call GameOver

    xor ax,ax
    call generate
    call ProcurarPalavra
.esperarEnter:
    call getchar
    cmp al, 13
        je .loopJogo
    jmp .esperarEnter

.fimJogo:
    call modo_video
    mov byte[linha], 13
    mov byte[coluna], 37
    mov si, TerminouJogo
    call printStr

jmp fim

ProcurarPalavra:
mov di, resposta
mov si, palavras
mov bl, 6
mul bl
mov cl, al
    .procurando:
        cmp cl, 0
            je .achou
        inc si
        dec cl
        jmp .procurando

    .achou:
        lodsb
        stosb
        cmp al, 0
            je .fim
        jmp .achou
    .fim:
        ret


LimparVetores:
    mov si, letras
    mov di, reserva
    mov cl, 26
    .loopLV:
        mov byte[si], 48
        mov byte[di], 48
        inc si
        inc di
        dec cl
        cmp cl, 0
            jne .loopLV
        ret
Tamanho:
    mov byte[tam], 0
    mov si, resposta
    .loopT:
        lodsb

        cmp al, 0
            je .fimT

        inc byte[tam]
        jmp .loopT
    .fimT: 
        ret
        

IgualandoStrings:
mov cl, byte[tam]
mov si, resposta

.igualando:
    cmp cl, 0
        je .fimI

    lodsb
    xor bx, bx
    mov bl, al
    sub bl, 65
    
    xor dx, dx
    mov dl, byte[letras+bx]
    mov byte[reserva+bx], dl
    dec cl
    jmp .igualando
.fimI:
    ret


Alocarletras:
    xor ax, ax
    xor cx, cx
    mov cl, byte[tam]
    cld

    .checando:

        cmp cl, 0
            je .fimA

        lodsb
        
        dec cl
        xor bx, bx
        mov bl, al
        sub bl, 65

        add byte [letras+bx], 1
        jmp .checando
    .fimA:
        ret


leitura:
    .lendo:
        mov bl, byte[tam]
        cmp byte[count], bl
            je .fim

        cmp byte[linha], 22 ;7 + 3 + 3 + 3 + 3 + 3 --> 6 tentativas
            jg .fim

        mov byte[coluna], 27
        mov al, 175
        printchar 4
        
        mov byte[coluna], 31
        mov di, entrada
        call lerPalavra

        call IgualandoStrings

        mov byte[coluna], 26 ; 31-5
        mov byte[count], 0 ; resetar contador de letras certas
        mov si, entrada
        mov di, resposta
        call checarLetras

        add byte[linha], 3 ; mandar para a proxima linha

        jmp .lendo
    .fim:
        ret

getchar:
    mov ah, 0x00
    int 16h
    ret
UpperCase:
    cmp al, 97
        jl .fimUC
    
    sub al, 32
    ret

    .fimUC:
        ret
lerPalavra:
    xor cx, cx
    cld
    .lendo:
        call getchar

        cmp al, 8
            je .delete_input

        cmp al, 13
            je .Checar

        cmp cl, byte[tam] ; tamanho total de letras
            je .lendo

        call UpperCase
        stosb
        inc cl
        printchar 15
        add byte[coluna], 5 ; adicionar espaço entre as colunas
        
        jmp .lendo
    .Checar:
        cmp cl, byte[tam] ; tamanho total de letras
            je .fimL
        jmp .lendo
    .delete_input:
        cmp cl, 0
            je .lendo

        dec cl
        sub byte[coluna], 5
        dec di
        mov byte[di], 0
        call backspace
        jmp .lendo
    
    .fimL:
        ret

backspace:
    mov al, 8
    printchar 15
    mov al, ''
    printchar 15
    mov al, 8
    printchar 15
    ret

checarLetras:
    xor ax, ax
    xor cx, cx
    mov cl, byte[tam]
    cld
    .comparando:

        cmp cl, 0
            je .fimC

        add byte[coluna], 5

        dec cl

        lodsb
        xor bx, bx
        mov bl, al
        sub bl, 65

        cmp byte [reserva+bx], 48
            jg .letraExiste
        
        inc di
        jmp .comparando

    .letraExiste:
        sub byte[reserva+bx], 1
        cmp byte[di], al
           je .LugarCerto

        jmp .LugarErrado

    .LugarCerto:
        add byte[count], 1
        printchar 2
        inc di
        
        jmp .comparando

    .LugarErrado:
        printchar 14
        inc di

        jmp .comparando

    .fimC:
        ret

GameOver:
    mov bl, byte[tam]
    cmp byte[count], bl ; qtd de letras acertadas
        je .venceu
    jmp .perdeu

    .venceu:
        mov byte[coluna], 15
        mov byte[linha], 25
        mov si, vencedor
        call printStr
        ret
    .perdeu:
        call modo_video
        mov byte[linha], 13
        mov byte[coluna], 37
        mov si, perdedor
        call printStr
        ret

printStr:
    cld
    .printando:
        lodsb

        cmp al, 0
            je .fimP
        
        printchar 15
        add byte[coluna], 1
        jmp .printando

    .fimP:
        ret

Tabela:
    mov byte[count2], 6
    mov word[linhaP], 105 ;linha em que começa

    .loop:
        call MakeRow
        add word[linhaP], 48 ; lado + espaçamento entre linhas
        dec byte[count2]

        cmp byte[count2], 0
            jne .loop
        ret


MakeRow:
    mov bl, byte[tam]
    mov byte[count], bl
    mov word[colunaP], 239 ; coluna em que começa

    .loop:

        call Quadrado
        add word[colunaP], 40 ;lado + espaçamento
        dec byte[count]
        
        cmp byte[count], 0
            jne .loop
        ret


Quadrado:
    mov bx, word[linhaP]
    mov word[limiteL], bx
    add word[limiteL], 26 ;lado+1

    mov bx, word[colunaP]
    mov word[limiteC], bx
    add word[limiteC], 26 ;lado+1

    call LinhaH
    add word[linhaP], 25 ; lado do quadrado
    call LinhaH
    sub word[linhaP], 25

    call LinhaV
    add word[colunaP], 25
    call LinhaV
    sub word[colunaP], 25

    ret

LinhaV:

    mov ah, 0Ch
    mov al, 4;cor
    xor bx, bx
    mov cx, word[colunaP]; até 640
    mov dx, word[linhaP] ; até 480 
    .loop:
        int 10h
        add dx, 1
        cmp dx, word[limiteL]; limite da linha (10+100+1)
            jne .loop 
        ret

LinhaH:

    mov ah, 0Ch
    mov al, 4;cor
    xor bx, bx
    mov cx, word[colunaP]; até 640
    mov dx, word[linhaP] ; até 480 
    .loop:
        int 10h
        add cx, 1
        cmp cx, word[limiteC] ; limite da coluna
            jne .loop 
        ret

firstgenerate:              ;gera o primeiro numero a partir do clock
    call clocknumber        ;numero em al
    mov dh, 0           ;limpar dh
    
    mov si, anterior
    mov byte[si], al        ;registrar numero gerado 

    mov di, flags 
    add di, ax
    inc byte[di]            ;registrar que numero ja foi gerado

    ret

generate:               ;gerar da segunda vez para frente
    call clocknumber        ;gera a partir de clock
    call check          ;checa se o numero ja foi escolhido

    mov si, anterior 
    mov byte[si], al        ;registra numero gerado

    ret

clocknumber:
    mov AH, 00h      
        int 1AH      ; o valores de cx e dx sao definidos com base no clock interno      

        mov  ax, dx
        xor  dx, dx
        mov  cx, 20    
        div  cx       ; dx possui o resto de ax/cx (de 0 a 19)

        xor ah, ah
        mov al,dl     ; al = dl (ja que dx < 10, ax = dx)
        ret

check:
    xor ah, ah
    mov dx, ax  ; dx vai ser usado para comparar
    .compair:
        mov di, flags
        add di, dx
        cmp byte[di], 1     ; checa se o numero em ax ja ocorreu
        jne .isnew

    .tryagain:
        call random         ; funcao que gera um novo numero
        mov di, flags
        add di, dx
        cmp byte[di], 1     ; checa se o novo numero ja ocorreu
        jne .isnew

    .keeptrying:
        call addingthree    ; a funcao so acaba quando um novo numero e gerado

    .isnew:
        inc byte[di]
        mov al, dl
        ret

random:             ; gera um novo numero com base na equacao:
    xor dx, dx      ; X = (Xˆ2 + Xanterior + 1) mod 20
    mul ax          
    mov si, anterior
    inc ax          
    add al, byte[si]    
    mov cx, 20
    div cx          ; novo numero em dx 
        ret     

addingthree:            ; com base na equacao X = (X + 3) mod 10
    mov cx, 20      ; essa funcao so acaba quando um numero novo e encontrado
    mov bx, ax
    .procurando:
        xor dx, dx
        mov ax, bx
        add ax, 3
        mov bx, ax
        div cx      ; novo numero fica em dx
        mov di, flags
        add di, dx
        cmp byte[di], 1
        jne .achei
        jmp .procurando
    .achei:
        xor ah, ah
        ret

modo_video:
    mov ah, 0
    mov al, 12h
    int 10h

    mov ah, 0BH
    mov bh, 0
    mov bl, 7 ;cor
    int 10h

    ret

printfoca:
    mov dx, 211
    mov si, seal
    call foca
    ret

foca:
    .loopy:
        cmp dx, 275        
        je .rtn             ; when DX == 16, end code 
        mov cx, 62
        jmp .loopx
    .rtn:
        ret

    .loopx:
        cmp cx, 170       ; use CX for shift operations and loops
        je .incloopy    ; when CX == 16 goto inc_loop_x
        lodsb        ; loading char pointed by SI to AL and skiping to the next one
        call printsquare
        inc cx
        jmp .loopx
    .incloopy:
        add dx, 4
        jmp .loopy

printsquare:
    call printpixel
    inc dx
    call printpixel
    inc dx
    call printpixel
    inc dx
    call printpixel
    inc cx
    call printpixel
    dec dx
    call printpixel
    dec dx
    call printpixel
    dec dx
    call printpixel
    inc cx
    call printpixel
    inc dx
    call printpixel
    inc dx
    call printpixel
    inc dx
    call printpixel
    inc cx
    call printpixel
    dec dx
    call printpixel
    dec dx
    call printpixel
    dec dx
    call printpixel
    ret

printpixel:        ; 
        mov ah, 0ch        ; setting funtion code 0ch = Write graphics pixel
        mov bh, 0         ; setting page number to 0
        int 10h         ; interrupt call 10
        ret

printurso:
    mov dx, 202
    mov si, bear
    call urso
    ret

urso:
    .loopy2:
        cmp dx, 278        
        je .rtn2             ; when DX == 16, end code 
        mov cx, 470
        jmp .loopx2
    .rtn2:
        ret

    .loopx2:
        cmp cx, 546       ; use CX for shift operations and loops
        je .incloopy2    ; when CX == 16 goto inc_loop_x
        lodsb        ; loading char pointed by SI to AL and skiping to the next one
        call printsquare
        inc cx
        jmp .loopx2
    .incloopy2:
        add dx, 4
        jmp .loopy2

fim:
    jmp $
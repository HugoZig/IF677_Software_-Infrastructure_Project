org 0x7e00
jmp 0x0000:start

bear db 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 15, 15, 15, 15, 15, 15, 15, 9, 9, 9, 0, 0, 0, 0, 0, 9, 15, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 9, 15, 15, 8, 15, 8, 8, 8, 15, 8, 15, 15, 9, 0, 0, 0, 0, 0, 9, 15, 15, 13, 15, 15, 15, 8, 15, 15, 15, 13, 15, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 8, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 9, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 9, 9, 15, 15, 9, 15, 15, 15, 15, 15, 15, 15, 9, 15, 15, 9, 9, 0, 9, 15, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 15, 9, 9, 15, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 9, 15, 15, 15, 15, 9, 9, 15, 15, 15, 15, 15, 9, 15, 15, 9, 15, 15, 9, 15, 15, 15, 15, 15, 9, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0
    

start: 
        ;setting some registers to 0 
        xor ax, ax
        mov ds, ax
        mov es, ax
        mov dx, ax 

        mov si, bear
        
        ; setting video mode
        mov ah, 00h        
        mov al, 12h     
        int 10h

        mov ah, 0xb
        mov bh, 0
        mov bl, 0
        int 10h

        call loopy

loopy:
    cmp dx, 76        
    je $             ; when DX == 16, end code 
    mov cx, 0

    call loopx

loopx:
    cmp cx, 76       ; use CX for shift operations and loops
    je incloopy    ; when CX == 16 goto inc_loop_x
    lodsb        ; loading char pointed by SI to AL and skiping to the next one
    call printsquare
    inc cx
    call loopx


incloopy:
        add dx, 4
        call loopy

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

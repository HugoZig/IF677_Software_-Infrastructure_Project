org 0x7e00
jmp 0x0000:start

seal db 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 0, 9, 9, 9, 9, 0, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 9, 15, 15, 15, 9, 0, 9, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 15, 15, 15, 9, 0, 0, 9, 8, 7, 15, 15, 15, 15, 8, 7, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 0, 8, 9, 8, 8, 15, 8, 8, 15, 8, 8, 15, 15, 8, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 9, 0, 0, 0, 8, 15, 15, 15, 15, 15, 15, 15, 15, 8, 8, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 8, 0, 9, 8, 15, 8, 15, 8, 15, 15, 15, 15, 8, 15, 15, 15, 15, 15, 15, 15, 15, 9, 15, 15, 15, 15, 9, 0, 0, 9, 15, 8, 15, 8, 15, 15, 15, 15, 9, 15, 15, 15, 15, 15, 15, 15, 15, 9, 0, 9, 9, 15, 15, 9, 0, 0, 0, 9, 15, 15, 15, 15, 15, 15, 9, 15, 15, 15, 15, 9, 15, 15, 9, 9, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 9, 9, 9, 9, 15, 15, 15, 15, 9, 15, 15, 15, 15, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 15, 15, 9, 9, 9, 9, 9, 0, 9, 9, 15, 15, 15, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    

start: 
        ;setting some registers to 0 
        xor ax, ax
        mov ds, ax
        mov es, ax
        mov dx, ax 

        mov si, seal
        
        ; setting video mode
        mov ah, 00h        
        mov al, 12h     
        int 10h

        mov ah, 0xb
        mov bh, 0
        mov bl, 0
        int 10h

        call loopy

foca:
    .loopy:
        cmp dx, 64        
        je .rtn             ; when DX == 16, end code 
        mov cx, 0
        jmp .loopx
    .rtn:
        ret

    .loopx:
        cmp cx, 108       ; use CX for shift operations and loops
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

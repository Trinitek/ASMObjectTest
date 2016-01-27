
virtual
    define String_sizeof    String_end - $
    String_method_print     dw ?
    String_member_stringPtr dw ?
    String_member_length    dw ?
    String_end:
end virtual

; ax = ptr to location to put new object
; bx = pointer to string
new_String:
    pusha
    
    mov di, ax
    mov [di + String_method_print], String_print
    mov [di + String_member_stringPtr], bx
    mov ax, di
    call String_getLength
    mov [di + String_member_length], ax
    
    popa
    ret

; ax = this
String_print:
    pusha
    
    mov bx, ax
    mov si, [bx + String_member_stringPtr]
    mov ah, 0x0E
    
    .putChar:
        lodsb
        cmp al, 0
        jz .end
        int 0x10
        jmp .putChar
    
    .end:
    
    popa
    ret
    
; ax = this
; returns ax : length of string
String_getLength:
    pusha
    
    mov bx, ax
    mov si, [bx + String_member_stringPtr]
    xor cx, cx
    
    .countChar:
        lodsb
        cmp al, 0
        jz .end
        inc cx
        jmp .countChar
    
    .end:
        mov ax, cx
    
    popa
    ret
    
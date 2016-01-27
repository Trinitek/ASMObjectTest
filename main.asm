
main:
    mov ax, string1
    mov bx, char1
    call new_String
    
    mov bx, ax
    call [bx + String_method_print]
    ret
    
char1:
    db "Hello world!", 0
string1:
    
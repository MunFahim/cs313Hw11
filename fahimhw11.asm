section .data
    input: db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    inputLength equ $-input
    
    ; characters needed like space, newline, and the hex digits
    space: db ' '
    newline: db 10
    values: db '0123456789ABCDEF'

section .bss
    output: resb 80

section .text
    global _start

_start:
    
    mov esi, input        ; pointer to the input
    mov edi, output      ; pointer to the output 
    mov ecx, inputLength        ; total number of bytes that need to be transformed
    
data_loop:
    
    ; gets the first hex value from the current increment, example 0x83 would get 0x8
    mov al, [esi]            ; gets the current byte
    shr al, 4                ; moves to get the first hex value
    and al, 0x0F             ; makes sure only that byte it gotten
    mov al, [values + eax] ; converts the byte into the hex character
    mov [edi], al            ; stores it in the output 
    inc edi                  ; moves to the next position in the output
    
    ; does the same thing as above, but gets the next hex value (second hex value)
    mov al, [esi]            ; get current byte again
    and al, 0x0F             ; makes sure only the next hex value is taken
    mov al, [values + eax] ; converts the byte into hex character from values
    mov [edi], al            ; stores it into the current output 
    inc edi                  ; moves the output to next position
    
    ; adds a space after transforming 
    cmp ecx, 1               ; checks if this is the last byte
    je last_space            ; if so, then skips adding a space and jumps to newline 
    mov al, [space]          ; gets the space character
    mov [edi], al            ; adds space character to current output
    inc edi                 ; moves the output
    
last_space:
    
    ; checks to see if inputlength has been reached
    inc esi
    loop data_loop   ; loop again if not
    
    ; Add newline at the end
    mov al, [newline]  ; stores newline in al
    mov [edi], al      ; add newline in the output
    inc edi
    
    ; gets the length needed for the system write
    mov edx, edi
    sub edx, output       
    
    ; writes the out to system write and prints it
    mov eax, 4               
    mov ebx, 1               
    mov ecx, output       
    int 0x80
    
    ; exiting the program, with code 0
    mov eax, 1               
    xor ebx, ebx             
    int 0x80
.model small
.stack 100h
.data
    num1 db 0       ; First number
    num2 db 0       ; Second number
    result db ?     ; Result of operation
    operation db ?  ; Operation (+, -, *, /)
    prompt1 db "Enter first number: $"
    prompt2 db "Enter operation (+, -, *, /): $"
    prompt3 db "Enter second number: $"
    output db "Result: $", 0
    newline db 13, 10, "$"  ; New line

.code
main proc
    mov ax, @data       ; Initialize data segment
    mov ds, ax

    ; Prompt for first number
    lea dx, prompt1
    mov ah, 09h
    int 21h
    call getInput       ; Get the first number
    mov num1, al        ; Store it in num1

    ; New line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Prompt for operation
    lea dx, prompt2
    mov ah, 09h
    int 21h
    call getChar        ; Get the operation
    mov operation, al   ; Store it

    ; New line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Prompt for second number
    lea dx, prompt3
    mov ah, 09h
    int 21h
    call getInput       ; Get the second number
    mov num2, al        ; Store it in num2

    ; Perform the operation
    mov al, num1        ; Load first number
    sub al, '0'         ; Convert to numeric value
    mov bl, num2        ; Load second number
    sub bl, '0'         ; Convert to numeric value

    mov cl, operation   ; Load operation
    cmp cl, '+'         ; Check for addition
    je add
    cmp cl, '-'         ; Check for subtraction
    je subtract
    cmp cl, '*'         ; Check for multiplication
    je multiply
    cmp cl, '/'         ; Check for division
    je divide

    ; Addition
add:
    add al, bl
    jmp displayResult

    ; Subtraction
subtract:
    sub al, bl
    jmp displayResult

    ; Multiplication
multiply:
    mul bl
    jmp displayResult

    ; Division
divide:
    mov ah, 0
    div bl
    jmp displayResult

    ; Display the result
displayResult:
    add al, '0'         ; Convert back to ASCII
    mov result, al

    lea dx, newline
    mov ah, 09h
    int 21h

    lea dx, output      ; Display "Result: "
    mov ah, 09h
    int 21h

    mov dl, result      ; Display the result
    mov ah, 02h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

    ; Subroutine: Get input (single digit)
getInput:
    mov ah, 01h
    int 21h
    ret
    ; Subroutine: Get a single character
getChar:
    mov ah, 01h
    int 21h
    ret

main endp
end main

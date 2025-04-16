; bootloader.asm
[org 0x7C00]
[bits 16]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    call enable_a20

    ; Load GDT
    lgdt [gdt_descriptor]

    ; Enter protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump to flush pipeline and enter 32-bit mode
    jmp 0x08:protected_mode_entry

; ========== GDT Setup ==========
gdt_start:
gdt_null:               ; Null descriptor
    dd 0x00000000
    dd 0x00000000

gdt_code:               ; Code segment descriptor
    dw 0xFFFF           ; Limit low
    dw 0x0000           ; Base low
    db 0x00             ; Base middle
    db 10011010b        ; Access
    db 11001111b        ; Flags + Limit high
    db 0x00             ; Base high

gdt_data:               ; Data segment descriptor
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Limit
    dd gdt_start                ; Base

; ========== Enable A20 ==========
enable_a20:
    in al, 0x92
    or al, 00000010b
    out 0x92, al
    ret

; ========== 32-bit Protected Mode ==========
[bits 32]
protected_mode_entry:
    ; Update segment registers
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000      ; Stack at 0x90000

    mov edi, 0xB8000
    mov ecx, 80 * 25     ; 80 columns, 25 rows
    mov eax, 0x0F20      ; white on black space
    rep stosw
    
    ; write to video memory (0xB8000)

    mov edi, 0xB8000
    mov al, 'P'
    mov ah, 0x02          ; green on black
    stosw

hang:
    jmp hang

; Fill to 510 bytes
times 510 - ($ - $$) db 0
dw 0xAA55
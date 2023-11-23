;;;============================================================
;;; x86_64 linux assembly template
;;;
;;; Author: Sebastian Dawid (sdawid@techfak.uni-bielefeld.de)
;;;         github.com/Sebastian-Dawid
;;;
;;; Git:    git@github.com:Sebastian-Dawid/asm-template.git
;;;         https://github.com/Sebastian-Dawid/asm-template.git
;;;============================================================

;;;============================================================
;;; Definitions for syscalls (EXIT, WRITE, READ)
;;;============================================================
%define SYS_READ    0
%define SYS_WRITE   1
%define SYS_EXIT    60

;;;===========================================================
;;; Definitions for stream (STDIN, STDOUT)
;;;===========================================================
%define STDIN       0
%define STDOUT      1

;;;===========================================================
;;; Pre-initialized data
;;;===========================================================
section .data
hello_world:
    db "Hello World!", 0x0a ; 13 byte memory block containing
                            ; "Hello World!\n"

;;;===========================================================
;;; Non-initialized data
;;;===========================================================
section .bss
arr:
    resb 4                  ; 4 byte memory block

;;;===========================================================
;;; Code section
;;;===========================================================
section .text
    global _start

;;;===========================================================
;;; Procedure to write the `rdx` bytes at `rsi` to stdout
;;;===========================================================
write_to_stdout:
    push rax
    push rdi
    
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    syscall

    pop rdi
    pop rax
    ret

;;;===========================================================
;;; Entry Point
;;;===========================================================
_start:
    mov [arr], byte 0x48        ; Byte `H`
    mov [arr + 1], byte 0x69    ; Byte `i`
    mov [arr + 2], byte 0x21    ; Byte `!`
    mov [arr + 3], byte 0x0a    ; Byte `\n`

    mov rsi, arr                ; Address of our non-initialized
                                ; memory block of 4 bytes
    mov rdx, 0x4
    call write_to_stdout

    mov rsi, hello_world        ; Address of out pre-initialized
                                ; memory containing the
                                ; "Hello World!\n" string
    mov rdx, 0xd
    call write_to_stdout

    mov rax, SYS_EXIT
    mov rdi, 0
    syscall

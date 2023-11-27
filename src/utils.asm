;;;===========================================================
;;; Definitions required to write to stdout
;;;===========================================================
%define SYS_READ    0
%define SYS_WRITE   1
%define SYS_OPEN    2
%define STDOUT      1

;;;===========================================================
;;; Code section
;;;===========================================================
section .text
    global write_to_stdout  ; this procedure is exported and
                            ; can be called from outside this
                            ; file
    global read_file

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
;;; Procedure to open and read `rax` bytes of a file `rsi`
;;; into a given buffer `rdi`
;;;===========================================================
read_file:
    push rax
    push rdx
    push rdi
    push rsi
    
    mov r8, rax         ;; save the number of bytes to read
    mov r9, rdi         ;; save address of the buffer

    mov rax, SYS_OPEN   ;; open syscall
    mov rdi, rsi        ;; filepath
    mov rsi, 0          ;; O_READONLY
    syscall

    mov rdi, rax        ;; file descriptor
    mov rax, SYS_READ   ;; read syscall
    mov rsi, r9         ;; address of buffer
    mov rdx, r8         ;; size of buffer
    syscall

    pop rsi
    pop rdi
    pop rdx
    pop rax
    ret

;;;===========================================================
;;; Definitions required to write to stdout
;;;===========================================================
%define SYS_WRITE   1
%define STDOUT      1

;;;===========================================================
;;; Code section
;;;===========================================================
section .text
    global write_to_stdout  ; this procedure is exported and
                            ; can be called from outside this
                            ; file

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

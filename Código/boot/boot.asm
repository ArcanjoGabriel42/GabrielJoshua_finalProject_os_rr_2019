;; Boot sector
;; Carrega o kernel do disco para a memória
;; Chaveia o processador para 32-bits Modo Protegido
;; Executa Kenel Carregado

[org 0x7C00] ;;Carrega Bootloader no Endereço
[bits 16]

;; Endereço OFFSET onde o Kernel está localizado
KERNEL_OFFSET equ 0x1000

;;  Número do Drive já inicia no registrador dl
;;  Salva o número do drive de boot
mov [BOOT_DRIVE], dl

;; Atualizar base e ponteiro de pilha(stackpointer)
mov bp, 0x9000
mov sp, bp

;; Chama rotina que carrega o kernel na memória
call load_kernel_into_memory

;; Chaveia para Modo Protegido
call switch_to_pm
jmp $

;; Rotina que lê Kernel do disco para memória
load_kernel_into_memory:
	;; Armazena valores dos registradores na pilha
	pusha

	;; Configuração de parâmetros para rotina disk_read
	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_read

	;; Restaura valor dos registradores e retorna
	popa
	ret

[bits 32]

begin_pm:

	;; Chamada da rotina execute_kernel no Modo Protegido 32-bits
	call execute_kernel
	jmp $

execute_kernel:
	call KERNEL_OFFSET
	jmp $

%include "Código/boot/disk/disk_read.asm"
%include "Código/boot/pm/gdt.asm"
%include "Código/boot/pm/switch_to_pm.asm"
%include "Código/boot/print/print_nl.asm"
%include "Código/boot/print/print_string.asm"

BOOT_DRIVE: db 0

times 510 - ($-$$) db 0
dw 0xAA55

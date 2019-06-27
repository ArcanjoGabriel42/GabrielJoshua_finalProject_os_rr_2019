;; Sub-Rotina para chavear para o Modo Protegido
;;
;; http://wiki.osdev.org/Protected_Mode

[bits 16]

switch_to_pm:
	;; Limpa todas as interrupções
	cli

	;; Carrega o Global Descriptor Table
	lgdt [gdt_descriptor]

	;; Chaveia para o Modo Protegido
	;; Configura PE (Protection Enable) bit em CR0
	;; CR0 é um Registrador de Controle 0
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	;; Jump para instruções de 32 bits
	jmp CODE_SEG:init_pm

[bits 32]

init_pm:
	;; Atualiza registradores
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	;; Atualiza base e ponteiro da pilha
	mov ebp, 0x90000
	mov esp, ebp



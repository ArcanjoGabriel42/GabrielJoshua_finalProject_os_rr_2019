;; Sub-Rotina para imprimir uma nova linha
;; Usando Interrupções da BIOS imprime 2 caracteres ASCII:
;; Nova Linha = 0x0A
;; carriage return = 0x0D

[bits 16]

print_nl:
	;; Armazena valores dos registradores
	pusha

	;; Interrupção da BIOS
	mov ah, 0x0E
	mov al, 0x0A
	int 0x10
	mov al, 0x0D
	int 0x10

	;; Recuperação dos dados dos registradores
	popa
	ret

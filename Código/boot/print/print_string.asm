;; Sub-rotina para printar uma string

[bits 16]

print_string:
	;; store all register values
	pusha

print_string_loop:
	;; Pega primeiro caracter do endereço bx
	;; Se o caracter for igual ao simbolo NULL, retorne
	mov al, [bx]
	cmp al, 0
	je print_string_ret

	;; Se o char não for NULL, prepara interrupção da BIOS
	mov ah, 0x0E
	int 0x10

	;; Próximo endereço bx+1 ppara termos o próximo caracter
	inc bx
	jmp print_string_loop

print_string_ret:
	;; Restaura valores dos registradores
	popa
	ret

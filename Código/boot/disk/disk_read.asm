;; Implementation for sector-based hard disk and floppy disk read\write // Implementação de leitura e escrita no disco e floppy
;; Utilização da Interrupção BIOS INT 13h
;; https://en.wikipedia.org/wiki/INT_13H
;; http://stanislavs.org/helppc/int_13-2.html

[bits 16]

disk_read:
	;; Armazena todos os dados dos registradores
	pusha
	push dx

	;; Prepara dados para leitura do disco
	;; al = Números de setores a serem lidos(1 - 128)
	;; ch = track/cylinder number
	;; dh = head number
	;; cl = Número do setor

	mov ah, 0x02
	mov al, dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02
	int 0x13

	;; Em caso de erro de leitura
	;; Mostra a Mensagem
	jc disk_read_error

	;; Check se foi contado a quantidade esperada de setores
	;; Se não mostra mensagem de erro
	pop dx
	cmp dh, al
	jne disk_read_error

	;; Retorna registradores e retorna
	popa
	ret

disk_read_error:
	call print_nl
	mov bx, DISK_READ_ERROR_MSG
	call print_string
	call print_nl
	jmp $

DISK_READ_ERROR_MSG: db "Nao foi possivel encontrar o Kernel!", 0


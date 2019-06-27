# GabrielJoshua_finalProject_os_rr_2019
Repositório destinado ao projeto final da disciplina DCC 403 - Sistemas Operacionais do semestre 2019.1

Para executar o Bootloader é necessário ter o montador NASM e o simulador QEMU.

Para executar o Bootloader através do Script, apenas execute-o:

		./Exec_Boot.sh

Caso queira executar manualmente, os seguintes comando deverão ser executados:

		nasm Código/boot/boot.asm -f bin -o Código/boot.bin

		qemu-system-x86_64 Código/boot.bin


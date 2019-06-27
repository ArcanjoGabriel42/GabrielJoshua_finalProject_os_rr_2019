#!/bin/bash
nasm Código/boot/boot.asm -f bin -o Código/boot.bin

qemu-system-x86_64 Código/boot.bin
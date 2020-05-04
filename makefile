main.bin:main.asm ./inc/load.asm ./inc/printh.asm ./inc/printl.asm ./inc/strings.asm
	nasm main.asm -f bin -o boot.bin

clean:
	del boot.bin

run:
	qemu-system-x86_64 boot.bin
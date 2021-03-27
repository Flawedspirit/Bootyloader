main.bin:main.asm ./inc/enableA20.asm ./inc/load.asm ./inc/printh.asm ./inc/printl.asm ./inc/strings.asm ./inc/testA20.asm ./inc/testLM.asm
	nasm main.asm -f bin -o boot.bin

clean:
	del boot.bin

run:
	qemu-system-x86_64 -drive format=raw,file=boot.bin
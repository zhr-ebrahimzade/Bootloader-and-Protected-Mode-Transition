FILES = ./build/kernel.asm.o ./build/kernel.o
INCLUDES = -I./src
FLAGS= -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -wno-unused-function -fno-builtin -werror -wno-unused-label -wno-cpp -wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -wall -o0 -Iinc

all:
	./bin/boot.bin .bin/kernel.bin 
	rm -rf ./bin/os.bin
	dd if =./bin/boot.bin >> ./bin/os.bin
	dd if= ./bin/kernel.bin >> ./bin/os.bin
	dd if =/dev/zero bs =512 count =100 >> ./bin/os.bin

	# dd if=./msg.txt >> ./boot.bin 

	# dd if= /dev/zero bs=512 count=1 >> ./boot.bin

.bin/kernel.bin: $(FILES)
	i686-elf-ld -g -relocatable $(FILES) -o ./build/kernelfull.o
	i686-elf-gcc $(FLAGS) -T ./src/linker.ld -o ./bin/kernel.bin -ffreestanding -o0 -nostdlib ./build/kernelfull.o
./bin/boot.bin: ./src/boot/boot.asm
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.asm

./build/kernel.asm.o: ./src/kernel.asm
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o

./build/kernel.o: ./src/kernel.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c ./src/kernel.c -o ./build/kernel.o
clean:
	rm -rf ./bin/boot.bin
	rm -rf ./bin/kernel.bin
	rm -rf ./bin/os.bin
	rm -rf ${FILES}
	rm -rf ./build/kernelfull.o

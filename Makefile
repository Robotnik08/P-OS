# compile bootloader.asm with nasm -f bin bootloader.asm -o bootloader.img

bootloader.img: ./src/bootloader.asm
	mkdir -p ./bin
	nasm -f bin ./src/bootloader.asm -o ./bin/bootloader.img
	@echo "Bootloader compiled successfully."

run: bootloader.img
	qemu-system-x86_64 -drive format=raw,file=./bin/bootloader.img
	@echo "Bootloader is running in QEMU."

clean:
	rm -f ./bin/bootloader.img
	@echo "Cleaned up generated files."
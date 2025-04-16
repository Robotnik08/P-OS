# P-OS

P-OS is a simple operating system written from scratch, this is mainly for learning and fun.

My goals:

- Enter Long Mode and start making the kernel in 64-bit mode in C.
- Recreate C certain standard library functions
- Build the shell
- Implement a simple file system
- Implement my own intepreted language (Dosato)[https://github.com/Robotnik08/cdosato]
- Allow the user to load, make and run dosato programs

## Building

To build the kernel, you need to have `nasm` installed.

To build the kernel, run the following command in the root directory of the project:

```bash
nasm -f bin bootloader.asm -o bootloader.img
```

This will create a file called `bootloader.img` in the root directory of the project.

You can use an emulator like QEMU to run the kernel. To do this, run the following command:

```bash
qemu-system-x86_64 -drive format=raw,file=bootloader.img
```
This will start QEMU and load the kernel. Make sure you have QEMU installed on your system.
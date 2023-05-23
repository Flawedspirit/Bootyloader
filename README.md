# Bootloader
 A random project to refresh my assembly knowledge

 This project has no purpose. I just like learning about "black box" technology, and for most people, the bootloader that starts their OS is as black box as it gets.

 As of right now it only runs in a QEMU x86-64 emulator, but I'm working to figure out how to get it to run on bare metal.

## Compiling and Running
 **Note:** These instructions are for Fedora, but your distro of choice will almost certainly have the same packages, just installed through a different package manager.

 1. `$ sudo dnf install make nasm qemu`. **Make** is used to compile the human-readable assembly into an executable binary file, and **nasm** assembles it into x86_64 bytecode. **QEMU** is an x86_64 emulator.
 2. Clone this repo and `cd` into it.
 3. Run `make`, then run `make qemu` to start the program.
 4. ???
 5. Profit! 

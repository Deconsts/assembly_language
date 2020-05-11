use the following command in sequence:

mipsel-linux-gnu-as -o main.o main.S
mipsel-linux-gnu-as -o print_dec.o print_dec.S
mipsel-linux-gnu-ld -o main main.o print_dec.o
qemu-mipsel-static main

or

mipsel-linux-gnu-as -o hello.o hello.S
mipsel-linux-gnu-ld -o hello hello.o
qemu-mipsel-static hello

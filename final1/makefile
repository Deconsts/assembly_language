atoi:
	gcc -c test.c
	as -o atoi.o atoi.S
	gcc -o atoitest atoi.o test.o
disassembly:
	objdump -S -d atoitest > atoitest.S
clean:
	rm -f *.o atoitest atoitest.S

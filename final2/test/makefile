memcpy:
	gcc -c test.c
	as -o memcpy.o memcpy.S
	gcc -o memcpytest test.o
disassembly:
	objdump -S -d memcpytest > memcpytest.S
clean:
	rm -f *.o memcpytest memcpytest.S

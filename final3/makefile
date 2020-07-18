cpufreq:
	rm -f *.o cpufreq
	gcc -c cpufreq.c
	gcc -o cpufreq cpufreq.o
disassembly:
	objdump -S -d cpufreq > cpufreq.S
clean:
	rm -f *.o cpufreq cpufreq.S

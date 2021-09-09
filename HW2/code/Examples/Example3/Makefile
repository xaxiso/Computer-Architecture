run:
	riscv64-unknown-elf-gcc -g -Og -o sum.o -c sum.c
	riscv64-unknown-elf-gcc -g -Og -T spike.lds -nostartfiles -o sum sum.o sum.s

test:
	spike pk sum

clean:
	rm -f sum sum.o

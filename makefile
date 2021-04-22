all: calculator
	
fpu: fpu.o
	ld -m elf_i386 -o calculator calculator.o

fpu.o: fpu.s
	as -g --32 -o calculator.o calculator.s


SYSWRITE=4
SYSREAD=2
STDINT=0
STDOUT=1
SYSEXIT=1
EXIT_SUCCESS=0

.data

float1: .float 7.53
float2: .float -2.73

double1: .double 7.53
double2: .double -2.73

zero: .float 0.00

#precyzje
single: .short 0b0000000000000000
double: .short 0b0000001000000000

#zaokrąglenia
nearest: .short         0b0000000000000000
down: .short            0b0000010000000000
up: .short              0b0000100000000000
toward_zero: .short     0b0000110000000000
cw: .short 0b0001000000111111
.text
.global _start
_start:

ustawienie_slowa_sterujacego:
mov cw,%eax
mov double,%ebx
add %ebx,%eax
mov up,%ebx
add %ebx,%eax
mov %eax,cw
fldcw cw

dodawanie_float:
flds float1
flds float2
faddp

odejmowanie_float:
flds float1
flds float2
fsubp

mnozenie_float:
flds float1
flds float2
fmulp
dzielenie_float:
flds float1
flds float2
fdivp

dodawanie_double:
fldl double1
fldl double2
faddp
odejmowanie_double:
fldl double1
fldl double2
fsubp
mnozenie_double:
fldl double1
fldl double2
fmulp
dzielenie_double:
fldl double1
fldl double2
fdivp
jmp exit
wyjatki:
#NaN:
fldz
fdiv zero

#+inf:
flds float1
fdiv zero

#-inf
flds float2
fdiv zero

#+0
fldz
fdiv float1

#-0
fldz
fdiv float2
exit:
movl $SYSEXIT,%eax
movl $EXIT_SUCCESS,%ebx
int $0x80


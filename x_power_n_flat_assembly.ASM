 format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

;code to find maximum and minimum element of array
start:
     mov ecx,[num]   ;edx=10
     mov esi,0       ;esi=0
     mov eax,1       ;eax=1
     startloop:
         cmp esi,[p]   ;0<3            1<3               2<3               3<3
         je endloop                                                        ;3=3
         mul ecx       ;eax=10*1=10    eax=10*10=100     eax=100*10=1000
         mov ecx,eax   ;ecx=10         ecx=100           ecx=1000
         mov eax,[num] ;eax=10         eax=10            eax=10
         add esi,1     ;esi=1          esi=2             esi=3
         jmp startloop ;jmp            jmp               jmp

     endloop:
            mov [num],ecx
            cinvoke printf, f1,[num]
            cinvoke scanf, f6,x

exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable
p dd 3
num dd 10
x dd ?
f1 db 'Power: %d',0
f6 db '%d',0


section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'
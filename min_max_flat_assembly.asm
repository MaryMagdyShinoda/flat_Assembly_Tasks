 format pe; console
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

;code to find maximum and minimum element of array
start:
     mov esi,0
     maxloop:
              cmp esi,[size]
              jge endmaxloop
              mov edx,[arr+4*esi]
              cmp edx,[max]
              jge plus
              jnge notplus
     plus:
          mov [max],edx
          add esi,1
          jmp maxloop

     notplus:
            add esi,1
            jmp maxloop

     endmaxloop:
            cinvoke printf, f1,[max]
            mov esi,0
            jmp minloop


     minloop:
            cmp esi,[size]
            jge endminloop
            mov edx,[arr+4*esi]
            cmp edx,[min]
            jge notminfun
            jnge minfun

     minfun:
           mov [min],edx
           add esi,1
           jmp minloop

     notminfun:
              add esi,1
              jmp minloop

     endminloop:
               cinvoke printf,'  ------------  '
               cinvoke printf, f2,[min]
               cinvoke scanf, f6,x

exist:

   invoke ExitProcess, 0;

section '.data' data readable writeable
arr dd 5,8,1,6,7,2,8
size dd 7
max dd -999
min dd 999
x dd ?
f1 db 'Max of array is  %d',0
f2 db 'Min of array is  %d',0
f6 db '%d',0


section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'
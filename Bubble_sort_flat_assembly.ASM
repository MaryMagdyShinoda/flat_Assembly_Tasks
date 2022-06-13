 format pe
 entry start
 include 'win32ax.inc'
 section '.code' code readable executable

start:

 push [n]
 push arr
 call bubbleSort
 add esp,8

 push [n]
 push arr
 call printArray
 add esp,8


bubbleSort:
 push ebp
 mov ebp,esp

 push ebx
 push esi
 push edi
 push edx

 mov ebx,[ebp+12];size
 mov edi,[ebp+8] ;address

 dec ebx

 sub esp, 12

    loop1:
        cmp [i], ebx
        jge endloop1

          loop2:
               mov ecx, [j]
               mov edx, ebx
               sub edx, [i]
               mov [n1],edx
               cmp ecx, [n1]
               jge endloop2

                mov esi, [j]
                inc esi
                mov eax, [edi+ecx*4]

                call compare

                cmp [c],1
                jne endif

                   push eax
                   mov [temp1],eax
                   mov edx, [edi+4*esi]
                   mov [temp],edx

                   pop dword [edi+4*esi]

                   mov eax, [temp1]
                   mov [edi+4*esi], eax

                   mov edx, [temp]
                   mov [edi+ecx*4], edx

                endif:
                   inc [j]
                   jmp loop2

          endloop2:
                  mov [j], 0
                  inc [i]
                  jmp loop1

     endloop1:
            add esp, 12
            pop edx
            pop edi
            pop esi
            pop ebx
            pop ebp
            ret


compare:
cmp eax,[edi+4*esi]
jg greater
mov [c],0
ret
greater:
  mov [c],1
  ret


exist:
  invoke ExitProcess, 0;


printArray:
push ebp
mov ebp , esp

push esi
push ebx

mov ebx , [ebp+12] ;size
mov edi , [ebp+8]  ;address

mov [i],0

printloop:
     cmp [i],ebx
     jge endprint

     mov esi,[i]
     mov edx,[edi+4*esi]

     cinvoke printf, f1 ,edx
     inc [i]
     jmp printloop

endprint:
     cinvoke scanf, f6,x
     pop ebx
     pop esi
     pop ebp
     ret


section '.data' data readable writeable
f1 db ' %d ',0
f6 db '%d',0
arr dd 5,8,11,7,10,4,1,9
n dd 8
i dd 0
j dd 0
c dd ?
n1 dd ?
temp dd ?
temp1 dd ?
x dd ?

section '.idata' import data readable writeable
library msvcrt, 'msvcrt.dll', kernel32, 'kernel32.dll'
import msvcrt, printf, 'printf', getchar,'getchar', scanf,'scanf'
import kernel32, ExitProcess,'ExitProcess'
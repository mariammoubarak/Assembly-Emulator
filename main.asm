INCLUDE Irvine32.inc

.DATA
tempMem byte "1010101"
memoryTemp byte ?
num word  ?
decimal dword  0
temp dword ?

operandsValArr dword 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.CODE
isDumpregs proc
mov eax,operandsValArr[0]
mov ebx,operandsValArr[1]
mov ecx,operandsValArr[2]
mov edx,operandsValArr[3]
mov esi,operandsValArr[4]
mov edi,operandsValArr[5]
mov ebp,operandsValArr[6]
mov ax,operandsValArr[7]
mov bx,operandsValArr[8]
mov cx,operandsValArr[9]
mov dx,operandsValArr[10]
mov si,operandsValArr[11]
mov di,operandsValArr[12]
mov bp,operandsValArr[13]
mov al,operandsValArr[14]
mov bl,operandsValArr[15]
mov cl,operandsValArr[16]
mov dl,operandsValArr[17]
mov ah,operandsValArr[18]
mov bh,operandsValArr[19]
mov ch,operandsValArr[20]
mov dh,operandsValArr[21]

call dumpregs
ret
isDumpregs endp
;---------------------------------------------------------
isWriteint proc
mov eax,operandsValArr[0]
call writeint
ret
isWriteint endp

;---------------------------------------------------------------------------------------------------------------------
stringToDec proc


mov edi, offset tempMem
mov ecx, lengthof tempMem
mov ax,0

convert:
mov bl, [edi]
and bl, 11001111b
mov dx,10
mul dx
movzx si,bl
add ax,si


inc edi
loop convert

mov num, ax
ret
stringToDec endp




;--------------------------------------------------------------------------------------------------------------------

HexaToDec proc
mov esi, offset tempMem
mov ecx, lengthof tempMem
mov edi,0

convert:
mov al,  [esi+edi]
mov temp,ecx
;cmp al, '0'
;je endd


cmp al,'a'
jb number



cmp al, 'f'
jbe letters

letters:

cmp al,'a'
je a


cmp al,'b'
je b


cmp al,'c'
je cc


cmp al,'d'
je d


cmp al,'e'
je e


cmp al,'f'
je f

a:
mov al,10
jmp powers

b:
mov al,11
jmp powers

cc:
mov al,12
jmp powers

d:
mov al,13
jmp powers

e:
mov al,14
jmp powers

f:
mov al,15
jmp powers

number:

and al, 11001111b
powers:
cmp ecx,2
je ecx2

cmp ecx,1
je ecx1
sub ecx,2
mov ebx,16
power:
mov ebx,ebx
shl ebx,4
loop power
movzx eax, al
mul ebx
add decimal,eax
jmp endd

ecx2:
mov ebx,16
movzx eax, al
mul ebx
add decimal,eax
jmp endd

ecx1:
movzx eax, al
add decimal,eax
jmp enddd
endd:
mov ecx, temp
inc edi
dec ecx
jmp convert

enddd:
ret
HexaToDec endp



;---------------------------------------------------------------------------------------------------------------------

stringToBinary proc
mov esi, offset tempMem
mov ecx, lengthof tempMem
mov edi,0

convert:

mov al,  [esi+edi]
mov temp,ecx

and al, 11001111b
powers:
cmp ecx,2
je ecx2

cmp ecx,1
je ecx1
sub ecx,2
mov ebx,2
power:
mov ebx,ebx
shl ebx,1
loop power
movzx eax, al
mul ebx
add decimal,eax
jmp endd

ecx2:
mov ebx,2
movzx eax, al
mul ebx
add decimal,eax
jmp endd

ecx1:
movzx eax, al
add decimal,eax
jmp enddd



endd:
mov ecx, temp
inc edi
dec ecx
jmp convert

enddd:
ret
stringToBinary endp


;----------------------------------------------------------------------------------------------------------------------


main PROC

Call stringToBinary
	;CALL DumpRegs
	exit
main ENDP

END main
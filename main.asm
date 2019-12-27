INCLUDE Irvine32.inc

.DATA
tempMem byte "1010101"
memoryTemp byte ?
num word  ?
decimal dword  0
temp dword ?

operandsValArr dword 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
.CODE

;--------------------------------------------------
;Display the values of all registers
;--------------------------------------------------
isDumpregs proc
mov eax,operandsValArr[0]
mov ebx,operandsValArr[1]
mov ecx,operandsValArr[2]
mov edx,operandsValArr[3]
mov esi,operandsValArr[4]
mov edi,operandsValArr[5]
mov ebp,operandsValArr[6]
mov ax,  word ptr operandsValArr[7]
mov bx, word ptr operandsValArr[8]
mov cx, word ptr operandsValArr[9]
mov dx, word ptr operandsValArr[10]
mov si, word ptr operandsValArr[11]
mov di, word ptr operandsValArr[12]
mov bp, word ptr operandsValArr[13]
mov al, byte ptr operandsValArr[14]
mov bl, byte ptr operandsValArr[15]
mov cl,byte ptr operandsValArr[16]
mov dl,byte ptr operandsValArr[17]
mov ah,byte ptr operandsValArr[18]
mov bh,byte ptr operandsValArr[19]
mov ch, byte ptr operandsValArr[20]
mov dh, byte ptr operandsValArr[21]

call dumpregs
ret
isDumpregs endp
;---------------------------------------------------------
;Prints a signned integer to the user.
;---------------------------------------------------------
isWriteint proc
mov eax,operandsValArr[0]
call writeint
ret
isWriteint endp
;---------------------------------------------------------------------------------------------------------------------
;Converts the string(decimal) immediate value to a decimal number
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


;---------------------------------------------------------------------------------------------------------------------
;Converts the string(hexadecimal) immediate value to a decimal number
;--------------------------------------------------------------------------------------------------------------------

HexaToDec proc
mov esi, offset tempMem
mov ecx, lengthof tempMem
mov edi,0

convert:
mov al,  [esi+edi]
mov temp,ecx

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
;To muliply in the right power of 16
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
;Converts the string(Binary) immediate value to a decimal number
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
;To muliply in the right power of 2
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

call HexaToDec
	;CALL DumpRegs
	exit
main ENDP

END main
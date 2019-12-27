INCLUDE Irvine32.inc
.DATA
string byte 1000 dup(?)
movxByteSizeNotBigger byte "error A2149: byte register cannot be first operand",0
movxBothRegistersAreEqual byte "error A2070: invalid instruction operands",0
ImmediateOperandNotValid byte "error A2001: immediate operand not allowed",0
movxMemoryOperandNotValid byte "error A2000: memory operand not allowed",0
instruction byte 20 dup(?)
operand1 byte 8 dup(?)
operand2 byte 8 dup(?)
instructionSize dword ?
operand1Size    dword ?
operand2Size    dword ?
operandsValArr dword 1,1,12345678,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1
bit32 dword 8
bit16 dword 28
bit8l dword 56
bit8h dword 72
operand1Index dword 8
memoryTemp byte ?
immediateTemp byte ?
myTemp dword ?
wordcount word 1
spacecount word 0
.code
main PROC
   call extendMoves
   mov esi,offset operandsValArr
   mov eax,[esi+8]
   call writeDec
   call crlf
   mov eax,[esi+36]
   call writeDec
   call crlf
   mov eax,[esi+64]
   call writeDec
   call crlf
   mov eax,[esi+80]
   call writeDec
   call crlf

 exit
 mov ecx,100
 mov edx,offset string
 call readString

  call splitting
  mov edx,offset instruction
  call writestring
   call crlf

   mov edx,offset operand1
  call writestring
   call crlf

   mov edx,offset operand2
  call writestring
   call crlf
  
	exit
main ENDP

splitting PROC
mov ecx,eax
mov ebx,offset instruction
mov esi,offset operand1
mov edi,offset operand2

splitString:
     mov al,[edx]
	 cmp al,' '
	 je equalcondition

	 cmp al,','
	 je equalcondition

	 cmp al,';'
	 je stoplooping

	 mov spacecount,0
	 cmp wordcount,1
	 jne operand1check
	 mov [ebx],al
	 inc ebx
	 inc instructionSize
	 jmp enditeration

	 operand1check:
	 cmp wordcount,2
	 jne operand2check
	 mov [esi],al
	 inc operand1Size
	 inc esi
	 jmp enditeration

	 operand2check:
	 mov [edi],al
	 inc operand2Size
	 inc edi
	 jmp enditeration

	 equalcondition:
	 inc spacecount
	 cmp spacecount,1
	 jne enditeration
	 inc wordcount
	 jmp enditeration

     stoplooping:
	 mov ecx,1

     enditeration:
	 inc edx

loop splitString

mov edx,offset instruction
mov al,[edx]
cmp al,'c'
je extension
cmp al,'C'
je extension
jmp toend
extension:
add edx,4
mov al,' '
mov [edx],al
inc edx
mov ecx,operand1Size
mov ebx,offset operand1
extend:
   mov al,[ebx]
   mov [edx],al
   mov al,' '
   mov [ebx],al
   inc edx
   inc ebx
loop extend
 
toend:

RET
splitting ENDP


extendMoves PROC
mov esi,offset operandsValArr
;mov edi, [esi]
mov eax,bit32
cmp operand1Index,eax
jne register16bit
  add esi,bit32
  ;mov edi, [esi]
  mov bl,byte ptr[esi+2]
  mov edx,bit16
  add edx,2
  mov byte ptr operandsValArr[edx],bl
  ;mov al, byte ptr operandsValArr[edx]
  mov edx,bit8h
  add edx,3
  mov byte ptr operandsValArr[edx],bl
  ;mov al, byte ptr operandsValArr[edx]

  mov bl,byte ptr[esi+3]
  mov edx,bit16
  add edx,3
  mov byte ptr operandsValArr[edx],bl
  ;mov al, byte ptr operandsValArr[edx]
  mov edx,bit8l
  add edx,3
  mov byte ptr operandsValArr[edx],bl
  ;mov al, byte ptr operandsValArr[edx]
  jmp toend


  register16bit:
  mov eax,bit16
cmp operand1Index,eax
  jne register8bitl
   add esi,bit16
   mov ebx,[esi+2]
   mov edx,bit32
  add edx,2
  mov operandsValArr[edx],ebx
  mov edx,bit8h
  add edx,3
  mov operandsValArr[edx],ebx

  mov ebx,[esi+3]
  mov edx,bit32
  add edx,3
  mov operandsValArr[edx],ebx
  mov edx,bit8l
  add edx,3
  mov operandsValArr[edx],ebx
  jmp toend

   
   register8bitl:
   mov eax,bit8l
cmp operand1Index,eax
  jne register8bith
  add esi,bit8l
  mov ebx,[esi+3]
  mov edx,bit32
  add edx,3
  mov operandsValArr[edx],ebx
  mov edx,bit16
  add edx,3
  mov operandsValArr[edx],ebx
  jmp toend

  register8bith:
  add esi,bit8h
  mov ebx,[esi+3]
  mov edx,bit32
  add edx,2
  mov operandsValArr[edx],ebx
  mov edx,bit16
  add edx,2
  mov operandsValArr[edx],ebx
  jmp toend

  toend:
ret
extendMoves ENDP

END main

;add esi,bit32
  ;mov ebx,byte ptr[esi+2]
  ;mov edx,bit16
  ;add edx,2
  ;mov operandsValArr[edx],ebx
  ;mov edx,bit8h
  ;add edx,3
  ;mov operandsValArr[edx],ebx

  ;mov ebx,[esi+3]
  ;mov edx,bit16
  ;add edx,3
  ;mov operandsValArr[edx],ebx
  ;mov edx,bit8l
  ;add edx,3
  ;mov operandsValArr[edx],ebx
  ;jmp toend
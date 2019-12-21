
INCLUDE Irvine32.inc
.DATA
string byte 100 dup(?)
instruction byte 13 dup(?)
operand1 byte 8 dup(?)
operand2 byte 8 dup(?)
wordcount word 1
spacecount word 0
.code
main PROC
  mov edx,offset string
 
  mov ecx,100
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
PUSHAD

;mov ecx,LENGTHOF string
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
	 jmp enditeration

	 operand1check:
	 cmp wordcount,2
	 jne operand2check
	 mov [esi],al
	 inc esi
	 jmp enditeration

	 operand2check:
	 mov [edi],al
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
mov ecx,lengthof operand1
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
POPAD
RET
splitting ENDP

END main
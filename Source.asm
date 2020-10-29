.386
INCLUDE	C:\irvine32\Irvine32.inc
.stack 100h
;;		Mulltiple use registers in most assembler variants
;;		AX		Accumulator- used for user input,  can be used  to  store output (or other) variables **temporarily**  before showing on screen
;;		BX		Base Register- can be used  to  store variables temporarily
;;		CX		Counter register - as a loop counter, but can be used to store vars vtemporarily
;;		DX		Direction register  used for output **strings**, or for variables temporarily

;;		AX - Perform maths & logical ops - used as EAX, AX, AH, AL
;;		BX - indexing - used as BX alone usually
;;		CX - Loop counting - used as CX
;;		DX - Data Register - used to store data in RAM. - used as DX
;;

;;		PSW is an 8bit Program Status Word Register -  (Flags - remeber them as COPDZIAS - 
;;		C=Carry,		O=Overflow,		P=Parity (unused),		D=Direction, 
;;		Z=Zero,		A=Auxilliary(unused),							S=Signed
;;		Carry - Set when addint 2 binary values (that overflow)  - See also O-Overflow
;;		Direction - Direction that ARRAY data is stored in memory
;;		Auxilliary stores the carry of Hex Additions
;;		Signed - stores the sign when adding to binary values
;;
;;
;; output is  +x*incrment value = result 10 times.
;;	+8*+6=48 etc

.data
msg		db	"Enter a number : ",0
msg1	byte		"*"
msg2	byte		"="
msg3	db	"All finished....", 0
;msg1	db	"Entered number was ",0
msg_L		EQU $ msg				;; ? Gets the length of msg
var		dd	?							;; a variable for the user inpjut value
.code
main proc

;;EDX is used to store a pointer to an output STRING
;; WRITESTRING  outputs whatever is in EDX

;;EAX is used to store an int value for output
;; WRITEINT outputs whatever is in EAX

;; AL is used for singleCHAR output values
;; WRITECHAR outputs whatever is in AL

; put string pointer in EDX, then call WriteString
mov	edx,	offset msg		;; store in EDX our msg = "Enter a number"
call		writestring				;; Enter a number: !!
;;	EDX NOT used again , so we can reuse EDX as we wish

call	readint						;;		Read the value  entered by the user - it goes into EAX
;mov	var,	eax					;;		save the value input
push	eax						;;		save it onthe stack !!!!

mov	ecx,		10				;;		store in ECX the max value for our loop = 10
mov	ebx,		1					;;		store in EBX our loop counter value = 1

;; create a loop
;; I have modified this  to use the stack to store EAX which has the original user entered value
;;	cos we reuse AX, AL in the loop - Works well
l1:
;mov	eax,		var				;;		we will reuse this as AL, so we have to  store back into into EAX our buffer for the user entered INT value each time we start theloop - starts at zero
pop		eax						;;		same thing as above, but get it off the stack
call	writeint					;;		write it back out to the screen
push	eax						;; save it on the vstack again, cos we use AX/AL in the loop

mov		al,		msg1			;;		using EAX: display the "*"" - CHAR
call	writechar

mov		eax,		ebx			;; display whats in ebx  - our multipland which we inc each loop iteration?  Starts at 1++
call	writeint					;; incrments each time around, so 1-2-3-4....

mov		al,		msg2			;; put '=' in al so we can print it out
call	writechar

mov	eax,		var				;; our result ?
mul	ebx							;; using MUL in EBX multiplies whatever is in EAX by whatever is in EBX
call writeint
call	crlf						;; oupt EOL - CR/LF
inc	ebx						;; increment our multipland

loop		l1						;; loop back to l1 head

mov	edx,	offset msg3		;; store in EDX our msg3 = "All finished"
call		writestring				;; Enter a number: !!
;;call	readint					;; keep DOS box open

Invoke ExitProcess, 0		;; exit DOS
main endp
end main

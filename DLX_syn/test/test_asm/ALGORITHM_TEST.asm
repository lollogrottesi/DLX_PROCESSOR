#Order 5 numbers.
#r1 contains the base address.
addui r1, r0, #5

#Random values r2 to r6.
addui r2, r0, #8
addui r3, r0, #3
addui r4, r0, #12
addui r5, r0, #2
addui r6, r0, #5

sb 0(r1), r2
sb 1(r1), r3
sb 2(r1), r4
sb 3(r1), r5
sb 4(r1), r6

#Reset registers.
addui r2, r0, #0
addui r3, r0, #0
addui r4, r0, #0
addui r5, r0, #0
addui r6, r0, #0

#Load first value, r7 will contain the counter.
addui r7, r0, #0   

#for (i=5;i>0;i--)
loop_i:
lb r2, 5(r7) 
addui r7, r7, #1
lb r3, 5(r7)  
sgt r11, r2, r3
nop
bnez r11, swap

check_jmp:
seqi r10, r7, #5
bnez r10, loop_i
end:
j end


swap:
	sb 5(r8), r3
	sb 5(r7), r2
	j check_jmp

addi r5, r5, #-5
nop
nop
nop
sb 5(r0), r5
lb r6, 5(r0)
lbu r6, 5(r0) 
end:
j end
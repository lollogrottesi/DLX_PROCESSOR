lhi r5, #-40
nop
nop
nop
addi r5, r5, #50
nop
nop
nop
sw 5(r0), r5
lw r6, 5(r0)
end:
j end
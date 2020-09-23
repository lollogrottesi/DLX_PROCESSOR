lhi r1, #0x3ff4
and r2, r2, #0
nop 
sw 5(r0), r1
sw 7(r0), r2
nop
ld r1, 5(r0)
ld r3, 5(r0)
nop
addd r5, r1, r3
subd r5, r1, r3
multd r7, r1, r3
divd r9, r1, r3
end:
j end

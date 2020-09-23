lhi r5, #0x3FF3
nop
addi r5, r5, #0x8B11
nop
lhi r6, #0xC6D1
nop
addi r6, #0xE109
nop
sd 5(r0), r5
ld r8, 5(r0)
end:
j end

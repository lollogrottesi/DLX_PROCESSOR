lhi r1, #0x3FC0
movi2fp r1, r1
movi2fp r2, r1
addf r3, r1, r2 
sf 5(r0), r3
lf r4, 5(r0)
subf r4, r4, r3
end:
j end

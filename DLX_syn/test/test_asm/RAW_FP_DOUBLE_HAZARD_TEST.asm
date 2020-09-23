lhi r1, #0x4002
sw 5(r0), r1
ld r1, 5(r0)
ld r2, 5(r0)
addd r3, r1, r2 
subd r3, r1, r2
end:
j end

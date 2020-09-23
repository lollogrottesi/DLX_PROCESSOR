lhi r1, #0x3fc0
lhi r2, #0x4000
movi2fp r1, r1
movi2fp r2, r2
nef r1, r2
bfpt end
addui r3, r0, #1
end:
j end

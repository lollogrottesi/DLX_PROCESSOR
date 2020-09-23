#1.5 fp.
lhi r1, #0x3FC0
#2.0 fp.
lhi r2, #0x4000

#Mov to fp register.
movi2fp r1, r1
movi2fp r2, r2

#clear r1, r2.
addui r1, r0 , #0
addui r2, r0 , #0

#3.5 fp = 0x40600000
addf r3, r1, r2

nef r1, r2
bfpt set_r1
bfpf end

set_r1:
addui r1, r0, #1
sb 5(r0), r1
lb r2, 5(r0)

end:
j end
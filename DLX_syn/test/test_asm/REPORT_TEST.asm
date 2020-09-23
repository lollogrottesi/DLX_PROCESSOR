#2.5 = 0x40200000.
lhi r1, #0x4020

#Save 1.
addui r2, r0 #1

#Store.
sw 4(r0),r1

#Load in FP single RF.
lf r1, 4(r0)

#Move operand from integer RF to float single RF.
movi2fp r1, r1

#Convert 1 integer to float single.
cvti2f r2, r2

#Perform floating division.
divf r3,r1,r2

#Loop using FPS.
nef r2, r1
label:
bfpt label
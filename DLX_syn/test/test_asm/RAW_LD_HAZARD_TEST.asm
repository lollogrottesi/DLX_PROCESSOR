addui r1, r0, #1
nop
sb 5(r0), r1
lb r2, 5(r0)
addui r2, r2, #1
end:
j end

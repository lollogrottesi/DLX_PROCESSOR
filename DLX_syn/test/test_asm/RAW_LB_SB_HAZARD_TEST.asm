addui r1, r0, #1
sb 5(r0), r1
lb r2, 5(r0)
sb 8(r0), r2
end:
j end

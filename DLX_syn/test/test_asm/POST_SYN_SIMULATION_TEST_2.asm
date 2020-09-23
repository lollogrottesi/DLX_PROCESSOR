addui r1 r0, #1
addui r2, r0, #1

sb 0(r1), r2
addui r1 r1, #2
sb 0(r1), r2
addui r1 r1, #2
sb 0(r1), r2
addui r1 r1, #2
sb 0(r1), r2
addui r1 r1, #2
sb 0(r1), r2

end:
j end
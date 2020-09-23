addui r1, r0, #1
sb 5(r0), r1
#This code does not work.
lb r2, 5(r0)
beqz r2 end 
addui r2, r0, #2
end:
j end

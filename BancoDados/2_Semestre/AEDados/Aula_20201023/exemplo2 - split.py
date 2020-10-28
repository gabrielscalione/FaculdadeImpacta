lin = "Gabriel,9.5,7.8,False"
u = lin.split(",")
u[1]= float(u[1])
u[2]= float(u[2])
if u[3]=="False":
    u[3] = False
else:
    u[3] = True

print(u)

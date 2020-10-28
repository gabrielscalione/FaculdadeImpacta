n = int(input("Fibonacci, digite o termo final: "))

t1 = 1
t2 = 1

for k in range( 1,100,2):
    print(t1)
    termo = t1 + t2
    t1 = t2
    t2 = termo

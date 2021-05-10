def imprimeDados( nome, idade ):
    print ("%s tem %s anos." %(nome, idade))
    return;

imprimeDados( idade=30, nome="Bob" )


def add(a,b):
    print (a, "+", b, "=", a + b)
    
add(4, 12)

sum = lambda x, y:   x + y  
print(sum(2,9))


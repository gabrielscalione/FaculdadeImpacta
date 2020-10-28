
import math as m

#funcao média tradicional
def media_a(n1, n2):

    media = (n1 + n2) / 2

    return round(media,2)


#funcao média geometrica
def media_g(n1, n2):

    media = m.sqrt(n1*n2)

    return round(media,2)

#funcao média harmonica
def media_h(n1, n2):

    media = 2 / (1/n1 + 1/n2)

    return round(media,2)
    

#principal
n1 = float(input())
n2 = float(input())


media1 = media_a(n1, n2)
media2 = media_g(n1, n2)


if n1 == 0 or n2 == 0:
    media3 = 0.0
else: 
    media3 = media_h(n1, n2)

print(media1)
print(media2)
print(media3)

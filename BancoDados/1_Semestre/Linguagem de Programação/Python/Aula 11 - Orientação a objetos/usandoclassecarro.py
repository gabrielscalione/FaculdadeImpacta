Python 3.8.1 (tags/v3.8.1:1b293b6, Dec 18 2019, 22:39:24) [MSC v.1916 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py
>>> from pessoas import Pessoa
>>> 
>>> p = Pessoa()
>>> 
>>> type(p)
<class 'pessoas.Pessoa'>
>>> p.nome = "Gabriel"
>>> p.nome
'Gabriel'
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py
>>> from pessoas import Pessoa
>>> 
>>> p = Pessoa()
>>> 
>>> p.salvar()
Salvando
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py
Traceback (most recent call last):
  File "C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py", line 1, in <module>
    class Pessoa(object):
  File "C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py", line 2, in Pessoa
    nome = Nome
NameError: name 'Nome' is not defined
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py
>>> from pessoas import Pessoa
>>> 
>>> p = Pessoa()
>>> 
>>> p.nome = "Ana"
>>> p.nome
'Ana'
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py
>>> from pessoas import Pessoa
>>> 
>>> p = Pessoa()
>>> p.nome = "Maria"
>>> p.salvar()
Salvando  Maria
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/pessoas.py
>>> from pessoas import Pessoa
>>> p = Pessoa()
>>> p.nome = 'José'
>>> p.salvar("Gabriel")
Salvando  Gabriel
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Carro
>>> c= Carro()
>>> print(c.caminho)
Traceback (most recent call last):
  File "<pyshell#29>", line 1, in <module>
    print(c.caminho)
AttributeError: 'Carro' object has no attribute 'caminho'
>>> c = Carro()
>>> c.andar()
Andando pela Rua
>>> print(c.caminho)
Rua
>>> c.caminho = 'Estrada'
>>> c.caminho
'Estrada'
>>> c.andar()
Andando pela Rua
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Carro
>>> c = Carro()
>>> c.caminho
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Carro
>>> c = Carro()
Traceback (most recent call last):
  File "<pyshell#40>", line 1, in <module>
    c = Carro()
TypeError: __init__() missing 1 required positional argument: 'caminho'
>>> c = Carro('Ponte')
>>> c.caminho
'Ponte'
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Carro
c
>>> c = Carro('Ponte')
>>> c.andar()
Andando pela Ponte
>>> c.caminho = 'Praia'
>>> c.andar()
Andando pela Praia
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Carro
>>> from carros import Fusca
>>> f = Fusca('Avenida')
>>> f
<carros.Fusca object at 0x031C2028>
>>> type(f)
<class 'carros.Fusca'>
>>> f.andar()
Andando pela Avenida
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Fusca
>>> f = Fusca("Praia")
>>> f.andar()
Andando pela Praia
>>> f.correr()
Andando pela pista
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> from carros import Ferrari
>>> ferrari = Ferrari("Avenida")
>>> ferrari.andar
<bound method Ferrari.andar of <carros.Ferrari object at 0x03B56F58>>
>>> ferrari.andar()
Correndo muito
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 11 - Orientação a objetos/carros.py
>>> 
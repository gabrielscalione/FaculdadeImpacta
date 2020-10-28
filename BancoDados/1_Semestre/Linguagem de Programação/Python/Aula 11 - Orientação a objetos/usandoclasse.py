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
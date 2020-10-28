Python 3.8.1 (tags/v3.8.1:1b293b6, Dec 18 2019, 22:39:24) [MSC v.1916 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 
= RESTART: C:/Users/gabriel.scalione/Documents/FCAV Corp Sistemas/FCAV Projetos/Desenvolv/Python/Aula 10 - Estrutura de Dados/Lista.py
>>> lista = [1,2,3,4,5]
>>> lista
[1, 2, 3, 4, 5]

>>> lista[1]
2
>>> for x in lista: print(x)

1
2
3
4
5
>>> lista = [1,'Antonio',3.14, 'Nova String', True]
>>> lista
[1, 'Antonio', 3.14, 'Nova String', True]
>>> for x in lista: print(x)

1
Antonio
3.14
Nova String
True
>>> lista[2]
3.14
>>> lista[2] = 'PI'
>>> lista
[1, 'Antonio', 'PI', 'Nova String', True]
>>> lista.append('Novo Valor')
>>> lista
[1, 'Antonio', 'PI', 'Nova String', True, 'Novo Valor']
>>> lista.pop()
'Novo Valor'
>>> lista
[1, 'Antonio', 'PI', 'Nova String', True]
>>> lista.pop()
True
>>> lista.remove('Antonio')
>>> lista
[1, 'PI', 'Nova String']
>>> lista.insert(2,'Insert')
>>> lista
[1, 'PI', 'Insert', 'Nova String']
>>> lista.insert(0,'Inicio')
>>> lista
['Inicio', 1, 'PI', 'Insert', 'Nova String']
>>> 
>>> 
>>> lista.reverse()
>>> lista
['Nova String', 'Insert', 'PI', 1, 'Inicio']
>>> lista.sort()
Traceback (most recent call last):
  File "<pyshell#27>", line 1, in <module>
    lista.sort()
TypeError: '<' not supported between instances of 'int' and 'str'
>>> lista.remove(1)
>>> lista
['Insert', 'Nova String', 'PI', 'Inicio']
>>> lista.sort()
>>> lista
['Inicio', 'Insert', 'Nova String', 'PI']
>>> lista.sort(reverse = True)
>>> lista
['PI', 'Nova String', 'Insert', 'Inicio']
>>> 
>>> 
>>> tupla = (3,4,'Nome')
>>> tupla
(3, 4, 'Nome')
>>> tupla2 = 3, 5,'Nome', 'Sobrenome'
>>> tupla2
(3, 5, 'Nome', 'Sobrenome')
>>> 
>>> 
>>> 
>>> s = set()
>>> s
set()
>>> s.add(1)
>>> s
{1}
>>> s.add(12)
>>> s
{1, 12}
>>> s.add(13)
>>> s.add(13)
>>> s
{1, 12, 13}
>>> s.add(14)
>>> s
{1, 12, 13, 14}
>>> s.pop()
1
>>> s
{12, 13, 14}
>>> s.remove(13)
>>> s
{12, 14}
>>> 
>>> 
>>> 
>>> #Dictonary
>>> 
>>> d = {}
>>> d
{}
>>> type(d)
<class 'dict'>
>>> d['nome'] = "Marcos"
>>> d[''] = "Almeida"
>>> d
{'nome': 'Marcos', '': 'Almeida'}
>>> d['data_nascimento'] = '10/03/1982'
>>> d
{'nome': 'Marcos', '': 'Almeida', 'data_nascimento': '10/03/1982'}
>>> d['telefone'] = '98352345'
>>> d
{'nome': 'Marcos', '': 'Almeida', 'data_nascimento': '10/03/1982', 'telefone': '98352345'}
>>> d.pop('telefone')
'98352345'
>>> d
{'nome': 'Marcos', '': 'Almeida', 'data_nascimento': '10/03/1982'}
>>> d.popitem()
('data_nascimento', '10/03/1982')
>>> d
{'nome': 'Marcos', '': 'Almeida'}
>>> d.values()
dict_values(['Marcos', 'Almeida'])
>>> d.keys
<built-in method keys of dict object at 0x0320AC58>
>>> d.keys()
dict_keys(['nome', ''])
>>> d.pop
<built-in method pop of dict object at 0x0320AC58>
>>> d.pop()
Traceback (most recent call last):
  File "<pyshell#81>", line 1, in <module>
    d.pop()
TypeError: pop expected at least 1 argument, got 0
>>> d.popitem()
('', 'Almeida')
>>> d
{'nome': 'Marcos'}
>>> d['Sobrenome'] = 'Almeida'
>>> d
{'nome': 'Marcos', 'Sobrenome': 'Almeida'}
>>> 
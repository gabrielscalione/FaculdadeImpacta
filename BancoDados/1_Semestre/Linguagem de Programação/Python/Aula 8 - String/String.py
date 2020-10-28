Python 3.8.1 (tags/v3.8.1:1b293b6, Dec 18 2019, 22:39:24) [MSC v.1916 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> "Gabriel"
'Gabriel'
>>> 'GAbriel'
'GAbriel'
>>> '''
Teste de multilinha
para teste
na aula de Python
'''
'\nTeste de multilinha\npara teste\nna aula de Python\n'
>>> "Texto para ser fatiado"[0:6]
'Texto '
>>> "Texto para ser fatiado"[0:7]
'Texto p'
>>> "Texto para ser fatiado"[:10]
'Texto para'
>>> "Texto para ser fatiado"[0:]
'Texto para ser fatiado'
>>> "Texto para ser fatiado"[0:10:3]
'Ttpa'
>>> "Fatiamento com valor negativo"[3:-4]
'iamento com valor nega'
>>> "Fatiamento com valor negativo"[::-1]
'ovitagen rolav moc otnemaitaF'
>>> 
>>> 
>>> #Bom. para utilizar para identificar palindromo
>>> 
>>> nome = "ana"
>>> 
>>> nome == nome[::-1]
True
>>> 
>>> 
>>> nome = "Marcos"
>>> nome
'Marcos'
>>> nome = 'B' + nome[1:]
>>> nome
'Barcos'
>>> nome.startswith('B')
True
>>> nome.startswith('b')
False
>>> 
>>> nome.replace('r','3')
'Ba3cos'
>>> nome
'Barcos'
>>> nome  = nome.replace('r','3')
>>> nome
'Ba3cos'
>>> 
>>> 
>>> texto = "Testando split no python"
>>> 
>>> s = texto.splith()
Traceback (most recent call last):
  File "<pyshell#38>", line 1, in <module>
    s = texto.splith()
AttributeError: 'str' object has no attribute 'splith'
>>> s = texto.split()
>>> s
['Testando', 'split', 'no', 'python']
>>> texto = "Testando ;novos;delimitadores"
>>> s = texto.split(';')
>>> s
['Testando ', 'novos', 'delimitadores']
>>> data = ['18','05','1979']
>>> '/'.join(data)
'18/05/1979'
>>> 
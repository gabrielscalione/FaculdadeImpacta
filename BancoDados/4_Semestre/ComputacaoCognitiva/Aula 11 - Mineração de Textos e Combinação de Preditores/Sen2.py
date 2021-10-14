# -*- coding: utf-8 -*-
# código adaptado a partir de:
# https://medium.com/@viniljf/criando-um-classificador-para-processamento-de-linguagem-natural-8dc27f3642a1


from textblob.classifiers import NaiveBayesClassifier
from textblob import TextBlob

train_set = [
    ('Eu adoro comer hamburguer', 'positivo'),
    ('Este lugar é horrível', 'negativo'),
    ('Você é uma pessoa adorável', 'positivo'),
    ('Você é uma pessoa horrível', 'negativo'),
    ('A festa está ótima', 'positivo'),
    ('A festa está péssima', 'negativo'),
    ('Este lugar é maravilhoso', 'positivo'),
    ('Estou cansado disso.', 'negativo'),
    ('Eu te odeio', 'negativo'),
    ('Eu te adoro', 'positivo'),
    ('Eu te amo', 'positivo'),
    ('Você é incrível','positivo'),
    ('Eu estou com muita raiva','negativo'),
    ('Eu odeio essa linguagem','negativo'),
    ('Essa linguagem é fantátisca','positivo'),
    ('Essa linguagem é muito boa','positivo'),
    ('Que comida gostosa','positivo'),
    ('Que comida horrível','negativo'),
    ('Estou me sentindo ótimo','positivo'),
    ('Hoje eu estou péssimo','negativo')
]
test_set = [
    ('Ótima linguagem', 'positivo'),
    ('Péssima essa linguagem', 'negativo'),
    ('Você é horrível', 'negativo'),
    ('Comida gostosa!', 'positivo'),
    ('Que raiva!', 'negativo'),
    ('Ótima festa!', 'positivo'),
    ('Eu não odeio todo mundo','positivo')
]

cl = NaiveBayesClassifier(train_set)
accuracy = cl.accuracy(test_set)
print()
print()
print()
print('----------------------------------------')
print('Acurácia no Conjunto de Teste: {}'.format(accuracy))
print()


print('Algumas Predições de Exemplo')
print('----------------------------------------')
frase = 'Eu odeio tudo e todos'
blob = TextBlob(frase,classifier=cl)
print('A frase:"',frase,'" é de caráter: {}'.format(blob.classify()))
frase = 'Vacina é bom!'
blob = TextBlob(frase,classifier=cl)
print('A frase:"',frase,'" é de caráter: {}'.format(blob.classify()))






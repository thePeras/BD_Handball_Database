from random import random
from fetcher import Fetcher
from parser import Parser

epocas = [7278]
epoca_2020_id = 7086

# Algoritmo
# Ir buscar jogos de cada época
# Inserir jornada e ligar a época

for epoca in epocas:
    # create epoca
    jogos = Fetcher.epoca_jogos(epoca)
    for jogo in jogos:
        #insert jornada
        jornada = jogo['PJO_NUM_JORNADA']

        #insert recinto

        #insert teams
        insert_team(jogo['ID_OBJECTO_CASA'])
        insert_team(jogo['ID_OBJECTO_FORA'])

        #insert arbitros
        jogo_info = Fetcher.jogo(jogo['ID_PROVA_JOGO'])
        jogo_info = Parser.jogo(jogo_info)

        for i in range(3):
            timeout = generate_timeout()
            #insert timeout

        for i in range(3):
            timeout = generate_timeout()
            #insert timeout


def insert_team(equipa_id):
    equipa = Fetcher.equipa(equipa_id)
    equipa = Parser.equipa(equipa)

    # insert team
    equipa_members = Fetcher.equipa_members(equipa_id)
    equipa_members = Parser.equipa_members(equipa_members)
    
    # insert atletas

    # insert treinador

def generate_events():
    # gerar golos
    # gerar sanções
    return []

def generate_timeout():
    return str(random.randint(10, 60)) + ':' + str(random.randint(10, 60))

def generate_birthday():
    return '12-02-1998'

print(Parser.recinto_cidade(Fetcher.recinto_cidade(["4780", "400"])))
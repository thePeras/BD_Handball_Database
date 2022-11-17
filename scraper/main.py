from fetcher import Fetcher
from parser import Parser
from database import Database
from generator import Generator

epocas = {
    2021: 7278,
}

#2020: 7086

# ~~ Algoritmo ~~
# Inserir épocas
# Buscar jogos de cada época
# Para cada jogo inserir jornada e ligar a equipa
# Inserir as equipas do jogo
#  - Inserir os atletas das equipas
#  - Inserir os treinadores das equipas
# Inserir os árbitros do jogo
# Inserir os golos do jogo
# Inserir as pausaTecnicas do jogo
# Inserir os interrupcoes do jogo

database = Database();

for inicio, epoca_id in epocas.items():
    # Inserir época
    jogos = Fetcher.epoca_jogos(epoca_id)
    epoca_name = jogos[0]['PRO_ABREVIATURA']
    database.insert_epoca(epoca_name, inicio)

    for jogo in jogos:
        equipa_visitada = jogo['ID_OBJECTO_CASA']
        equipa_visitante = jogo['ID_OBJECTO_FORA']

        # Inserir Equipas
        for team_id in [equipa_visitada, equipa_visitante]:
            team = Fetcher.equipa(team_id)
            team = Parser.equipa(team)
            database.insert_team(team_id, team, inicio)
            database.insert_team_in_epoca(team_id, inicio)

        # Inserir Jornada
        jornada = jogo['PJO_NUM_JORNADA']
        jornada_id = database.insert_jornada(jornada, inicio)

        # Inserir Jogo
        jogo_info = Fetcher.jogo(jogo['ID_PROVA_JOGO'])
        arbitros = Parser.arbitos(jogo_info)

        # Inserir Árbitros
        arbitros_ids = []
        for arbitro in arbitros:
            birthay = Generator.birthday()
            arbitro_id = database.insert_arbitro(arbitro, birthay)
            arbitros_ids.append(arbitro_id)

        database.insert_jogo(
            jogo['ID_PROVA_JOGO'],
            jogo['JOG_DATA'],
            jogo['JOG_HORA'],
            jogo['PJO_NUM_JORNADA'],
            inicio,
            equipa_visitada,
            equipa_visitante, 
            arbitros_ids[0],
            arbitros_ids[1],
        )

        print('UM JOGO INSERIDO!!')

        # Inserir Golos

        # Inserir PausaTecnicas

        # Inserir Interrupcoes
        for team in [equipa_visitada, equipa_visitante]:
            for i in range(3):
                timeout = Generator.timeout()
                #insert timeout

del database
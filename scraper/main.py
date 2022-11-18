from fetcher import Fetcher
from parser import Parser
from database import Database
from generator import Generator
from alive_progress import alive_bar

import random

# ~~ Algoritm ~~
# Insert seasons
# Get all games of a season
# For each game, insert jorney and link it to season
# Insert the game teans
# Insert the team members: players and coaches
# Insert game referees
# Insert game events: goals, timeouts and interruptions

database = Database()

epocas = {
    2021: '7278/18149',
    2020: '7086/17682',
    2019: '6689/16776'
}

print(f'A carregar as {len(epocas)} últimas epocas')

for inicio, epoca_url in epocas.items():
    # Insert season
    jogos = Fetcher.epoca_jogos(epoca_url)
    epoca_name = jogos[0]['PRO_ABREVIATURA']
    database.insert_epoca(epoca_name, inicio)

    with alive_bar(len(jogos), title=f'Época {inicio}/{inicio+1}') as bar:
        for jogo in jogos:
            equipa_visitada = jogo['ID_OBJECTO_CASA']
            equipa_visitante = jogo['ID_OBJECTO_FORA']

            # Insert Teams
            for team_id in [equipa_visitada, equipa_visitante]:
                team = Fetcher.equipa(team_id)
                team = Parser.equipa(team)
                database.insert_team(team_id, team, inicio)
                database.insert_team_in_epoca(team_id, inicio)

            equipa_visitada_members = Fetcher.equipa_members(equipa_visitada)
            equipa_visitante_members = Fetcher.equipa_members(equipa_visitante)
            database.insert_team_members(equipa_visitada_members, equipa_visitada, inicio)
            database.insert_team_members(equipa_visitante_members, equipa_visitante, inicio)

            # Insert Jorney
            jornada = jogo['PJO_NUM_JORNADA']
            jornada_id = database.insert_jornada(jornada, inicio)

            # Insert referees
            jogo_info = Fetcher.jogo(jogo['ID_PROVA_JOGO'])
            arbitros = Parser.arbitos(jogo_info)
            arbitros_ids = []
            for arbitro in arbitros:
                birthay = Generator.birthday()
                arbitro_id = database.insert_arbitro(arbitro.strip(), birthay)
                arbitros_ids.append(arbitro_id)

            # Insert Game
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

            golos_casa = int(jogo['JOG_GOLOS_CASA'])
            golos_fora = int(jogo['JOG_GOLOS_FORA'])

            if(golos_casa > golos_fora):
                database.add_points(equipa_visitada, inicio, 3)
                database.add_points(equipa_visitante, inicio, 1)
            elif(golos_casa < golos_fora):
                database.add_points(equipa_visitada, inicio, 1)
                database.add_points(equipa_visitante, inicio, 3)
            else:
                database.add_points(equipa_visitada, inicio, 2)
                database.add_points(equipa_visitante, inicio, 2)

            equipas = [equipa_visitada, equipa_visitante]
            equipa_visitada_atletas = list(filter(lambda member: member['ATLETA'] != None, equipa_visitada_members))
            equipa_visitante_atletas = list(filter(lambda member: member['ATLETA'] != None, equipa_visitante_members))
            aletas = [equipa_visitada_atletas, equipa_visitante_atletas]
            
            eventos_times = []

            # Insert Goals
            golos = [golos_casa, golos_fora]

            for n_golos, equipa_id, atletas in zip(golos, equipas, aletas):
                for _ in range(n_golos): 
                    atleta = random.choice(atletas)
                    time = Generator.time(eventos_times)
                    database.insert_golo(time[0], time[1], atleta['CIP_NUMERO'], equipa_id, jogo['ID_PROVA_JOGO'])
                    eventos_times.append(time)

            # Insert Interruptions
            types = ["Infração", "Advertência", "Exclusão", "Desqualificação", "Expulsão"]
            numero_interrupcoes = random.randint(0, 10) 
            aletas_total = equipa_visitada_atletas + equipa_visitante_atletas
            for i in range(numero_interrupcoes):
                tipo_interrupcao = random.choice(types)
                time = Generator.time(eventos_times)
                atleta = random.choice(aletas_total)
                database.insert_interrupcao(time[0], time[1], tipo_interrupcao, atleta['CIP_NUMERO'], jogo['ID_PROVA_JOGO'])
                eventos_times.append(time)

            # Insert Timeouts
            for team in [equipa_visitada, equipa_visitante]:
                for i in range(3):
                    time = Generator.time(eventos_times)
                    database.insert_pausaTecnica(time[0], time[1], team, jogo['ID_PROVA_JOGO'])
                    eventos_times.append(time)
            
            bar()

del database
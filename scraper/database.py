import sqlite3
from fetcher import Fetcher

#path of this file
DATABSE_FILE = '../database.db'
CRIAR_FILE = '../code/criar.sql'

fd = open(CRIAR_FILE, 'r')
sqlFile = fd.read()
fd.close()
sqlCommands = sqlFile.split(';')

class Database:
    def __init__(self):
        self.connection = sqlite3.connect(DATABSE_FILE)
        self.cursor = self.connection.cursor()
        # Run create tables script
        for command in sqlCommands:
            self.cursor.execute(command)
    
    def run_queries(self, queries):
        queries = queries.split(';')
        for query in queries:
            query+= ';'
            print(query)
            self.cursor.execute(query)

    def insert_epoca(self, nome, inicio):
        fim = inicio + 1
        query = f"INSERT INTO Epoca(nome, inicio, fim) VALUES ('{nome}', '{inicio}', '{fim}');"
        self.cursor.execute(query)

    def insert_team(self, equipa_id, equipa, epoca_inicio):
        queries = f'''
            INSERT OR IGNORE INTO Cidade(nome) VALUES ('{equipa['Cidade']}');
            INSERT OR IGNORE INTO Recinto(nome, morada, cidade) VALUES ('{equipa['Recinto']}', '{equipa['Morada']}', '{equipa['Cidade']}');
            INSERT OR IGNORE INTO Equipa(id, nome, logo, email, telefone, website, recinto) VALUES ('{equipa_id}', '{equipa['Nome']}', '{equipa['Logo']}', '{equipa['E-mail']}', '{equipa['Telefone']}', '{equipa['Website']}', '{equipa['Recinto']}');
        '''
        self.run_queries(queries)

        equipa_members = Fetcher.equipa_members(equipa_id)

        queries = ""
        for member in equipa_members:
            nascimento = member['CIP_DATA_NASCIMENTO']
            nome = member['CIP_NOME']
            member_id = member['CIP_NUMERO']

            collumn = 'Treinador' if member['ATLETA'] is None else 'Atleta'
            query = f"INSERT OR IGNORE INTO {collumn}(id, nome, dataNascimento) VALUES ('{member_id}', '{nome}', '{nascimento}');"
            queries += query
            query = f"INSERT OR IGNORE INTO Inscricao{collumn} VALUES ('{member_id}', '{equipa_id}', '{epoca_inicio}');"
            queries += query

        self.run_queries(queries)

    def insert_jornada(self, jornada, inicio):
        query = f"INSERT OR IGNORE INTO Jornada(numero, epoca) VALUES ('{jornada}', '{inicio}');"
        self.run_queries(query)

    def insert_team_in_epoca(self, equipa_id, epoca_inicio):
        query = f'INSERT OR IGNORE INTO Classificacao(equipa, epoca) VALUES ({equipa_id}, {epoca_inicio});'
        self.run_queries(query)

    def insert_arbitro(self, name, birthday):
        query = f"INSERT INTO Arbitro(nome, dataNascimento) VALUES ('{name}', '{birthday}');"
        self.run_queries(query)
        return self.cursor.lastrowid

    def insert_jogo(self, id, data, hora, jornada, epoca, visitada, visitante, a1, a2):
        query = f"INSERT INTO Jogo VALUES('{id}','{data}','{hora}','{jornada}','{epoca}','{visitada}',{visitante}, {a1}, {a2})"
        self.run_queries(query)

    def __del__(self):
        self.connection.commit()
        self.connection.close()
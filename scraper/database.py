import sqlite3
from fetcher import Fetcher

DATABSE_FILE = '../database.db'

class Database:
    def __init__(self):
        self.connection = sqlite3.connect(DATABSE_FILE)
        self.cursor = self.connection.cursor()
    
    def insert_epoca(self, nome, inicio):
        fim = inicio + 1
        query = f"INSERT INTO Epoca (nome, inicio, fim) VALUES ('{nome}', {inicio}, {fim});"
        self.execute(query)

    def insert_team(self, equipa_id, equipa, epoca_inicio):
        query = f'''
            INSERT INTO Cidade(nome) VALUES ({equipa['Cidade']});
            INSERT INTO Recinto(nome, morada, cidade) VALUES ({equipa['Recinto']}, {equipa['Morada']}, {equipa['Cidade']});
            INSERT INTO Equipa(id, nome, moradaSede, logo, email, telefone, website, recinto) VALUES ({equipa_id}, {equipa['Nome']}, {equipa['Morada']}, {equipa['Logo']}, {equipa['E-mail']}, {equipa['Telefone']}, {equipa['Website']}, {equipa['Recinto']});
        '''
        self.cursor.execute(query)

        equipa_members = Fetcher.equipa_members(equipa_id)

        queries = ""
        for member in equipa_members:
            nascimento = member['CIP_DATA_NASCIMENTO']
            nome = member['CIP_NOME']
            member_id = member['CIP_NUMERO']

            collumn = 'Treinador' if member['ATLETA'] is None else 'Atleta'
            query = f'INSERT INTO {collumn}(id, nome, nascimento) VALUES ({member_id}, {nome}, {nascimento}); '
            queries += query
            query = f'INSERT INTO Inscricao{collumn} VALUES ({member_id}, {equipa_id}, {epoca_inicio}); '
            queries += query

        self.cursor.execute(queries)

    def insert_arbitro(self, name, birthday):
        query = f"INSERT INTO Arbitro(nome, nascimento) VALUES ('{name}', '{birthday}');"
        self.cursor.execute(query)

    def insert_jogo(self):
        pass

    def __del__(self):
        self.connection.commit()
        self.connection.close()
from fetcher import Fetcher

class Database:

    # add connection here

    def insert_epoca(nome, inicio):
        fim = inicio + 1
        pass

    def insert_team(equipa_id, equipa, epoca_inicio):
        #insert team recinto

        equipa_members = Fetcher.equipa_members(equipa_id)

        for member in equipa_members:
            nascimento = member['CIP_DATA_NASCIMENTO']
            nome = member['CIP_NOME']
            member_id = member['CIP_NUMERO']

            if member['ATLETA']:
                #insert atleta
                pass
            else:
                #insert treinador
                pass
        
        #insert InscriçõesAletas
        #insert InscriçõesTreinadores

    def insert_arbitro(name, birthday):
        pass

    def insert_jogo():
        pass
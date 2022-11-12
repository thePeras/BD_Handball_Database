import requests
from bs4 import BeautifulSoup

class Fetcher:

    @staticmethod
    def epoca_jogos(id_epoca):
        url = f'https://ws.fpa.pt/index.php/getResultadosCalendario/{id_epoca}/18149'
        return requests.get(url)

    @staticmethod
    def jogo(id_jogo):
        url = f"https://portal.fpa.pt/jogo/{id_jogo}/"
        r = requests.get(url)
        soup = BeautifulSoup(r.text, "html.parser")
        return soup

    @staticmethod
    def equipa(id_equipa):
        url = f"https://portal.fpa.pt/clube/id/{id_equipa}/"
        r = requests.get(url)
        soup = BeautifulSoup(r.text, "html.parser")
        return soup

    @staticmethod
    def equipa_members(id_equipa):
        url = f'https://ws.fpa.pt/index.php/getCipClubeEpocaEscalao/{id_equipa}/370/4/'
        return requests.get(url)

    @staticmethod
    def recinto_cidade(codigo_postal):
        url = f'https://www.ctt.pt/feapl_2/app/open/postalCodeSearch/postalCodeSearch.jspx'
        body = {
            'cp4': codigo_postal[0],
            'cp3': codigo_postal[1],
            'method:searchPC2': "Procurar"
        }
        r = requests.post(url, data=body)
        soup = BeautifulSoup(r.text, "html.parser")
        return soup

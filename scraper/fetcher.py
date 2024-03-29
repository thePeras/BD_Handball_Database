import requests
from bs4 import BeautifulSoup

class Fetcher:

    @staticmethod
    def epoca_jogos(epoca_url):
        url = f'https://ws.fpa.pt/index.php/getResultadosCalendario/{epoca_url}'
        return requests.get(url).json()

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
        return requests.get(url).json()
class Parser:
    
    @staticmethod
    def equipa(equipa):
        details = equipa.find("div", {"class": "club-detail__content"})
        info = {
            "nome": details.h3.text,
            "logo": equipa.select_one(".club-detail__image").img["src"],
        }

        for tr in details.table.find_all("tr"):
            tds = tr.find_all("td")
            key = tds[0].text
            if key == "Morada":
                values = tds[1].get_text(strip=True, separator='\n').splitlines()
                codigo_postal = values[1][0:8]
                info['Morada'] = values[0] + " " + codigo_postal
                info['Cidade'] = values[1][9:]
            else:
                value = tds[1].text.replace("\n", " ").strip().replace("                             ", " ")
                info[key] = value

        return info

    @staticmethod
    def arbitos(jogo):
        return jogo.find("div", {"class": "game-detail__info"}).find_all("table")[1].find_all("tr")[0].find_all("td")[1].text.split(',')


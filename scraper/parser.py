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
            value = tds[1].text.replace("\n", " ").strip().replace("                             ", " ")
            info[key] = value

        return info
-- Funciona porque o atleta (115163) pertence a uma das equipas do jogo (228131)
INSERT INTO Golo VALUES(null,41,48,115163,76,228131);

-- Não funciona porque o atleta (115163) não pertence a uma das equipas que jogam o jogo (228132),
-- ou seja, o atleta não está a jogar esse jogo 
INSERT INTO Golo VALUES(null,41,48,115163,76,228132);

-- Funciona porque o atleta (200633) pertence a uma das equipas do jogo (222123)
INSERT INTO Interrupcao VALUES(null,50,51,'Infração',200633,222123);

-- Não funciona porque o atleta (200632) não pertence a uma das equipas que jogam o jogo (228132),
-- ou seja, o atleta não está a jogar esse jogo 
INSERT INTO Interrupcao VALUES(null,50,51,'Infração',200632,222123);
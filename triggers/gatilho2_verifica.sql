
-- Criar um jogador novo
INSERT INTO Atleta VALUES(8888,'Joaquim','1980-12-20');

-- Inserir numa equipa
INSERT INTO InscricaoAtleta VALUES(8888,539,2021);

-- Inserir noutra equipa na mesma época dá erro
INSERT INTO InscricaoAtleta VALUES(8888,3238,2021);



-- Funciona porque a equipa (76) está a jogar o jogo (228131)
INSERT INTO Golo VALUES(null,41,48,115163,76,228131);

-- Funciona porque a equipa (862) está a jogar o jogo (222054)
INSERT INTO PausaTecnica VALUES(null,45,33,862,222054);

-- Não funciona porque a equipa (75) não está a jogar o jogo (228131)
INSERT INTO Golo VALUES(null,41,48,115163,75,228131);

-- Não funciona porque a equipa (863) não está a jogar o jogo (222054)
INSERT INTO PausaTecnica VALUES(null,45,33,863,222054);

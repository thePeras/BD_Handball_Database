--- Verificar se o jogador já está inscrito numa equipa dessa época

CREATE TRIGGER VerificarInscricaoJogador
BEFORE INSERT ON InscricaoAtleta
WHEN EXISTS(
    SELECT * FROM InscricaoAtleta
    WHERE atleta = NEW.atleta
    AND epoca = NEW.epoca
)
BEGIN
    SELECT RAISE(ABORT, 'O jogador já está inscrito numa equipa');
END;

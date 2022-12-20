-- Verificar se o atleta que marcou o golo pertence a uma das equipas que está a jogar o jogo

DROP TRIGGER IF EXISTS VerificarGoloAtleta;
CREATE TRIGGER VerificarGoloAtleta
BEFORE INSERT ON Golo
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (
        SELECT count(*) FROM InscricaoAtleta
        WHERE atleta = NEW.atleta
        AND epoca = (
            SELECT Jogo.epoca 
            FROM Jogo
            WHERE Jogo.id = NEW.jogo
        ) 
        AND equipa in (visitada, visitante)
    ) = 1
)
BEGIN
    SELECT RAISE(ABORT, 'O atleta não está a jogar esse jogo');
END;

-- Verificar se o atleta da interrupção está a jogar o jogo em que ocorreu a interrupção

DROP TRIGGER IF EXISTS VerificarInterrupcaoAtleta;
CREATE TRIGGER VerificarInterrupcaoAtleta
BEFORE INSERT ON Interrupcao
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (
        SELECT count(*) FROM InscricaoAtleta
        WHERE atleta = NEW.atleta
        AND epoca = (
            SELECT Jogo.epoca 
            FROM Jogo
            WHERE Jogo.id = NEW.jogo
        ) 
        AND equipa in (visitada, visitante)
    ) = 1
)
BEGIN
    SELECT RAISE(ABORT, 'O atleta não está a jogar esse jogo');
END;

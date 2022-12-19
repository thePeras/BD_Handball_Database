-- Verificar se o jogador está a jogar o jogo em que marcou o golo

DROP TRIGGER IF EXISTS VerificarGoloJogador;
CREATE TRIGGER VerificarGoloJogador
BEFORE INSERT ON Golo
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (
        SELECT equipa FROM InscricaoAtleta
        WHERE atleta = NEW.jogador
        AND epoca = (
            SELECT Jornada.epoca 
            FROM Jogo
            JOIN Jornada ON Jornada.id = Jogo.jornada
            WHERE Jogo.id = NEW.jogo
        ) in (equipa1, equipa2)
    ) = 0
)
BEGIN
    SELECT RAISE(ABORT, 'O jogador não está a jogar esse jogo');
END;

--- TODO: Verificar!

-- Verificar se o jogador da interrupção está a jogar o jogo em que ocorreu a interrupção

DROP TRIGGER IF EXISTS VerificarInterrupcaoJogador;
CREATE TRIGGER VerificarInterrupcaoJogador
BEFORE INSERT ON Interrupcao
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (
        SELECT equipa FROM InscricaoAtleta
        WHERE atleta = NEW.atleta
        AND epoca = (
            SELECT Jornada.epoca 
            FROM Jogo
            JOIN Jornada ON Jornada.id = Jogo.jornada
            WHERE Jogo.id = NEW.jogo
        ) in (equipa1, equipa2)
    ) = 0
)
BEGIN
    SELECT RAISE(ABORT, 'O jogador não está a jogar esse jogo');
END;

--- TODO: Verificar!
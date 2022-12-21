--- Verificar se a equipa está a jogar o jogo ao inserir um golo

CREATE TRIGGER VerificarGolo
BEFORE INSERT ON Golo
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (visitada = NEW.equipa OR visitante = NEW.equipa)
)
BEGIN
    SELECT RAISE(ABORT, 'A equipa não está a jogar este jogo');
END;

--- Verificar se a equipa está a jogar o jogo ao inserir uma pausa técnica

CREATE TRIGGER VerificarPausaTecnicaEquipa
BEFORE INSERT ON PausaTecnica
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (visitada = NEW.equipa OR visitante = NEW.equipa)
)
BEGIN
    SELECT RAISE(ABORT, 'A equipa não está a jogar este jogo');
END;

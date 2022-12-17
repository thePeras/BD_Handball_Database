DROP TRIGGER IF EXISTS VerificarGolo;
CREATE TRIGGER VerificarGolo
BEFORE INSERT ON Golo
WHEN NOT EXISTS(
    SELECT * FROM Jogo
    WHERE id = NEW.jogo
    AND (equipa1 = NEW.equipa OR equipa2 = NEW.equipa)
)
BEGIN
    SELECT RAISE(ABORT, 'A equipa não está a jogar esse jogo');
END;
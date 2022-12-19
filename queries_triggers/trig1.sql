--- Verificar se o número da jornada é válido

DROP TRIGGER IF EXISTS VerificarNrJornadas;
CREATE TRIGGER VerificarNrJornadas
BEFORE INSERT ON Jornada
WHEN (
    NEW.numero > (
        SELECT COUNT(*) AS NrEquipas 
        FROM Equipa e
        JOIN Classificao c ON c.equipa = e.id
        WHERE c.epoca = NEW.epoca 
    ) * 2 - 2
)
BEGIN
    SELECT RAISE(ABORT, 'O número da jornada não bate certo consoante o número de equipas dessa época');
END;

--- TODO: Verificar!
--- TODO: Mudar ordem do ficheiro povoar.sql para que este trigger funcione
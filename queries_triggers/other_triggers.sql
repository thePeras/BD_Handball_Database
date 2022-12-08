--- Verificar o número da Jornada a ser inserida consoante o número de equipas existentes nessa época
--- TODO: Verificar!
--- ASK: Não funciona se executar o ficheiro povoar.sql

DROP TRIGGER IF EXISTS VerificarNrJornadas;
CREATE TRIGGER VerificarNrJornadas
BEFORE INSERT ON Jornada
WHEN (
    ( SELECT COUNT(*) AS NrEquipas FROM Equipa e
    JOIN Classificao c ON c.equipa = e.id
    WHERE c.epoca = NEW.epoca )

    NEW.numero > 2 * NrEquipas - 2;
AS
BEGIN
    RAISE(ABORT, 'O número da jornada não bate certo consoante o número de equipas dessa época')
END;



---- Não dá para criar o trigger para ver quem ganhou o jogo porque não existe um bom sítio para acionar esse trigger
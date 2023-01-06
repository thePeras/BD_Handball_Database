--- Inserir uma nova época com 3 equipas
INSERT INTO Epoca VALUES('Campeonato Placard Andebol 1',2022,2023);
INSERT INTO EquipaEpoca VALUES(862,2022);
INSERT INTO EquipaEpoca VALUES(934,2022);
INSERT INTO EquipaEpoca VALUES(987,2022);
INSERT INTO EquipaEpoca VALUES(539,2022);

--- Como a época tem 4 equipas logo tem no máximo 6 jornadas

INSERT INTO Jornada VALUES(1,2022);
INSERT INTO Jornada VALUES(2,2022);
INSERT INTO Jornada VALUES(3,2022);
INSERT INTO Jornada VALUES(4,2022);
INSERT INTO Jornada VALUES(5,2022);
INSERT INTO Jornada VALUES(6,2022);

--- O próximo insert dá erro
INSERT INTO Jornada VALUES(7,2022);

SELECT * 
FROM Jornada
WHERE epoca = 2022;
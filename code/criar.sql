DROP TABLE IF EXISTS Epoca;
CREATE TABLE Epoca(
    nome VARCHAR(50) NOT NULL,
    inicio INTEGER CONSTRAINT inicioValido CHECK (inicio >= 2007 AND inicio <= 3000) NOT NULL,
    fim INTEGER CONSTRAINT fimValido CHECK (fim >= 2008 AND fim <= 3000) NOT NULL,
    CONSTRAINT Epoca_PK PRIMARY KEY (inicio)
);

DROP TABLE IF EXISTS Jornada;
CREATE TABLE Jornada(
    id INTEGER AUTO_INCREMENT,
    numero INTEGER,s
    epoca INTEGER,
    CONSTRAINT Jornada_PK PRIMARY KEY (id),
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS Jogo;
CREATE TABLE Jogo(
    id INTEGER AUTO_INCREMENT,
    inicio VARCHAR(20) NOT NULL,
    jornada INTEGER NOT NULL,
    visitada INTEGER NOT NULL,
    visitante INTEGER NOT NULL,
    arbitro1 INTEGER NOT NULL,
    arbitro2 INTEGER NOT NULL,
    recinto INTEGER NOT NULL,
    CONSTRAINT Jogo_PK PRIMARY KEY (id),
    CONSTRAINT Jornada_FK FOREIGN KEY (jornada) REFERENCES Jornada(id),
    CONSTRAINT Equipa_FK1 FOREIGN KEY (visitada) REFERENCES Equipa(id),
    CONSTRAINT Equipa_FK2 FOREIGN KEY (visitante) REFERENCES Equipa(id),
    CONSTRAINT Arbitro_FK1 FOREIGN KEY (arbitro1) REFERENCES Arbitro(id),
    CONSTRAINT Arbitro_FK2 FOREIGN KEY (arbitro2) REFERENCES Arbitro(id),
    CONSTRAINT Recinto_FK FOREIGN KEY (recinto) REFERENCES Recinto(id),
    CHECK (visitada != visitante)
    CHECK (arbitro1 != arbitro2)
);

DROP TABLE IF EXISTS Recinto;
CREATE TABLE Recinto(
    id INTEGER AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    morada VARCHAR(50) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    CONSTRAINT Recinto_PK PRIMARY KEY (id),
    CONSTRAINT Cidade_FK FOREIGN KEY (cidade) REFERENCES Cidade(nome)
);

DROP TABLE IF EXISTS Cidade;
CREATE TABLE Cidade(
    nome VARCHAR(20),
    CONSTRAINT Cidade_PK PRIMARY KEY (nome)
);

DROP TABLE IF EXISTS Equipa;
CREATE TABLE Equipa(
    id INTEGER AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    logo VARCHAR(50) NOT NULL,
    email VARCHAR(30),
    telefone VARCHAR(20),
    website VARCHAR(30),
    recinto INTEGER,
    CONSTRAINT Equipa_PK PRIMARY KEY (id),
    CONSTRAINT Recinto_FK FOREIGN KEY (recinto) REFERENCES Recinto(id)
);

DROP TABLE IF EXISTS Atleta;
CREATE TABLE Atleta(
    id INTEGER AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    dataNascimento VARCHAR(10) NOT NULL,
    CONSTRAINT Atleta_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Treinador;
CREATE TABLE Treinador(
    id INTEGER AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    dataNascimento VARCHAR(10) NOT NULL,
    CONSTRAINT Treinador_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Arbitro;
CREATE TABLE Arbitro(
    id INTEGER AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    dataNascimento VARCHAR(10) NOT NULL,
    CONSTRAINT Arbitro_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS PausaTecnica;
CREATE TABLE PausaTecnica(
    id INTEGER AUTO_INCREMENT,
    minuto INTEGER CONSTRAINT minutoValido CHECK (minuto >= 0 AND minuto <= 60) NOT NULL,
    segundo INTEGER CONSTRAINT segundoValido CHECK (segundo >= 0 AND segundo <= 60) NOT NULL,
    equipa INTEGER NOT NULL,
    jogo INTEGER NOT NULL,
    CONSTRAINT PausaTecnica_PK PRIMARY KEY (id),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(id),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS Golo;
CREATE TABLE Golo(
    id INTEGER AUTO_INCREMENT,
    minuto INTEGER CONSTRAINT minutoValido CHECK (minuto >= 0 AND minuto <= 60) NOT NULL,
    segundo INTEGER CONSTRAINT segundoValido CHECK (segundo >= 0 AND segundo <= 60) NOT NULL,
    atleta INTEGER NOT NULL,
    equipa INTEGER NOT NULL,
    jogo INTEGER NOT NULL,
    CONSTRAINT Golo_PK PRIMARY KEY (id),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(id),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS Interrupcao;
CREATE TABLE Interrupcao(
    id INTEGER AUTO_INCREMENT,
    minuto INTEGER CONSTRAINT minutoValido CHECK (minuto >= 0 AND minuto <= 60) NOT NULL,
    segundo INTEGER CONSTRAINT segundoValido CHECK (segundo >= 0 AND segundo <= 60) NOT NULL,
    tipo VARCHAR(50) NOT NULL CONSTRAINT tipoValido CHECK (tipo = "Infração" or tipo = "Advertência" or tipo = "Exclusão" or tipo = "Desqualificação" or tipo = "Expulsão"),
    atleta INTEGER NOT NULL,
    jogo INTEGER NOT NULL,
    CONSTRAINT Interrupcao_PK PRIMARY KEY (id),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS InscricaoAtleta;
CREATE TABLE InscricaoAtleta(
    atleta INTEGER NOT NULL,
    equipa INTEGER NOT NULL,
    epoca INTEGER NOT NULL,
    CONSTRAINT InscricaoAtleta_PK PRIMARY KEY (equipa, atleta, epoca),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(id),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id)
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS InscricaoTreinador;
CREATE TABLE InscricaoTreinador(
    treinador INTEGER NOT NULL,
    equipa INTEGER NOT NULL,
    epoca INTEGER NOT NULL,
    CONSTRAINT InscricaoTreinador_PK PRIMARY KEY (equipa, treinador, epoca),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(id),
    CONSTRAINT Treinador_FK FOREIGN KEY (treinador) REFERENCES Treinador(id)
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS Classificacao;
CREATE TABLE Classificacao(
    equipa INTEGER NOT NULL,
    epoca INTEGER NOT NULL,
    pontos INTEGER DEFAULT 0,
    CONSTRAINT Classificacao_PK PRIMARY KEY (equipa, epoca),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(id)
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

/* Trigger para verificar o número da jornada */
DROP TRIGGER IF EXISTS checkJornadaTrigger;
CREATE TRIGGER checkJornadaTrigger BEFORE INSERT ON Jornada
FOR EACH ROW
BEGIN
    DECLARE numEquipas INTEGER;
    SELECT COUNT(*) INTO numEquipas FROM Classificacao WHERE epoca = NEW.epoca;
    IF NEW.numero > numEquipas - 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jornada inválida';
    END IF;
END;



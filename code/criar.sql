/* Create tables for the following relational model:
 * 
 * Epoca(nome, inicio, fim)
 * Jornada(numero, epoca -> Epoca)
 * Jogo(id,inicio,jornada -> Jornada,visitada -> Equipa, visitante -> Equipa, arbitro1 -> Arbitro, arbitro2 -> Arbitro,recinto -> Recinto)
 * Recinto(nome,morada,cidade -> Cidade)
 * Cidade(nome)
 * Equipa(nome,moradaSede,email,telefone,website,recinto -> Recinto)
 * Atleta(id,nome,dataNascimento)
 * Treinador(id,nome,dataNascimento)
 * Arbitro(id,nome,dataNascimento)
 * Pausa(minuto,segundo,equipa -> Equipa, jogo->Jogo)
 * Golo(minuto,segundo,atleta -> Atleta,equipa -> Equipa, jogo->Jogo)
 * Sancao(minuto,segundo,tipo, atleta -> Atleta, jogo->Jogo)

 * 
 * The following constraints must be enforced:
 * 
 * The following queries must be answered:
 * 
*/


DROP TABLE IF EXISTS Epoca;
CREATE TABLE Epoca(
    nome VARCHAR(50),
    inicio INTEGER CONSTRAINT inicioValido CHECK (inicio >= 2007 AND inicio <= 3000),
    fim INTEGER CONSTRAINT fimValido CHECK (inicio >= 2007 AND inicio <= 3000),
    CONSTRAINT Epoca_PK PRIMARY KEY (inicio)
);

DROP TABLE IF EXISTS Jornada;
CREATE TABLE Jornada(
    id INTEGER AUTO_INCREMENT,
    numero INTEGER, /* TODO: add a function check */
    epoca INTEGER,
    CONSTRAINT Jornada_PK PRIMARY KEY (id),
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS Jogo;
CREATE TABLE Jogo(
    id INTEGER AUTO_INCREMENT,
    inicio VARCHAR(20) NOT NULL,
    jornada INTEGER NOT NULL,
    visitada TEXT NOT NULL,
    visitante TEXT NOT NULL,
    arbitro1 INTEGER NOT NULL,
    arbitro2 INTEGER NOT NULL,
    recinto INTEGER NOT NULL,
    CONSTRAINT Jogo_PK PRIMARY KEY (id),
    CONSTRAINT Jornada_FK FOREIGN KEY (jornada) REFERENCES Jornada(id),
    CONSTRAINT Equipa_FK1 FOREIGN KEY (visitada) REFERENCES Equipa(nome),
    CONSTRAINT Equipa_FK2 FOREIGN KEY (visitante) REFERENCES Equipa(nome),
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
    nome VARCHAR(50) NOT NULL,
    moradaSede VARCHAR(50),
    logo VARCHAR(50) NOT NULL,
    email VARCHAR(30),
    telefone VARCHAR(20),
    website VARCHAR(30),
    recinto INTEGER,
    CONSTRAINT Equipa_PK PRIMARY KEY (nome),
    CONSTRAINT Recinto_FK FOREIGN KEY (recinto) REFERENCES Recinto(id)
);

DROP TABLE IF EXISTS Atleta;
CREATE TABLE Atleta(
    id INTEGER,
    nome VARCHAR(50) NOT NULL,
    dataNascimento VARCHAR(10) NOT NULL,
    CONSTRAINT Atleta_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Treinador;
CREATE TABLE Treinador(
    id INTEGER,
    nome VARCHAR(50) NOT NULL,
    dataNascimento VARCHAR(10) NOT NULL,
    CONSTRAINT Treinador_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Arbitro;
CREATE TABLE Arbitro(
    id INTEGER,
    nome VARCHAR(50) NOT NULL,
    dataNascimento VARCHAR(10) NOT NULL,
    CONSTRAINT Arbitro_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS PausaTecnica;
CREATE TABLE PausaTecnica(
    id INTEGER AUTO_INCREMENT,
    minuto INTEGER CONSTRAINT minutoValido CHECK (minuto >= 0 AND minuto <= 60) NOT NULL,
    segundo INTEGER CONSTRAINT segundoValido CHECK (segundo >= 0 AND segundo <= 60) NOT NULL,
    equipa VARCHAR(50) NOT NULL,
    jogo INTEGER NOT NULL,
    CONSTRAINT PausaTecnica_PK PRIMARY KEY (id),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS Golo;
CREATE TABLE Golo(
    id INTEGER AUTO_INCREMENT,
    minuto INTEGER CONSTRAINT minutoValido CHECK (minuto >= 0 AND minuto <= 60) NOT NULL,
    segundo INTEGER CONSTRAINT segundoValido CHECK (segundo >= 0 AND segundo <= 60) NOT NULL,
    atleta INTEGER NOT NULL,
    equipa VARCHAR(50) NOT NULL,
    jogo INTEGER NOT NULL,
    CONSTRAINT Golo_PK PRIMARY KEY (id),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
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
    equipa VARCHAR(50) NOT NULL,
    epoca INTEGER, /* TODO: NOT NULL CONSTRAINT inicioValido CHECK (inicio >= 2007 AND inicio <= 3000), */
    CONSTRAINT EquipaAtleta_PK PRIMARY KEY (equipa, atleta),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id)
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS InscricaoTreinador;
CREATE TABLE InscricaoAtleta(
    treinador INTEGER NOT NULL,
    equipa VARCHAR(50) NOT NULL,
    epoca INTEGER NOT NULL, /* TODO: CONSTRAINT inicioValido CHECK (inicio >= 2007 AND inicio <= 3000), */
    CONSTRAINT EquipaAtleta_PK PRIMARY KEY (equipa, atleta),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Treinador_FK FOREIGN KEY (treinador) REFERENCES Treinador(id)
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS JogoGolo;
CREATE TABLE JogoGolo(
    jogo INTEGER NOT NULL,
    golo INTEGER NOT NULL,
    CONSTRAINT JogoGolo_PK PRIMARY KEY (jogo, golo),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id),
    CONSTRAINT Golo_FK FOREIGN KEY (golo) REFERENCES Golo(id)
);

DROP TABLE IF EXISTS JogoPausaTecnica;
CREATE TABLE JogoPausaTecnica(
    jogo INTEGER NOT NULL,
    pausaTecnica INTEGER NOT NULL,
    CONSTRAINT JogoPausaTecnica_PK PRIMARY KEY (jogo, pausaTecnica),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id),
    CONSTRAINT PausaTecnica_FK FOREIGN KEY (pausaTecnica) REFERENCES PausaTecnica(id)
);

DROP TABLE IF EXISTS JogoInterrupcao;
CREATE TABLE JogoInterrupcao(
    jogo INTEGER NOT NULL,
    interrupcao INTEGER NOT NULL,
    CONSTRAINT JogoInterrupcao_PK PRIMARY KEY (jogo, interrupcao),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id),
    CONSTRAINT Interrupcao_FK FOREIGN KEY (interrupcao) REFERENCES Interrupcao(id)
);

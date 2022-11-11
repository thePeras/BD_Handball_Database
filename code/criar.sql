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
    nome TEXT,
    inicio INTEGER, /*2021*/ <!-- 4 digitos -->
    fim INTEGER,
    CONSTRAINT Epoca_PK PRIMARY KEY (inicio)
);

DROP TABLE IF EXISTS Jornada;
CREATE TABLE Jornada(
    numero INTEGER,
    epoca INTEGER,
    CONSTRAINT Jornada_PK PRIMARY KEY (numero, epoca),
    CONSTRAINT Epoca_FK FOREIGN KEY (epoca) REFERENCES Epoca(inicio)
);

DROP TABLE IF EXISTS Jogo; /* As equipas visitante e visitada não pode ser a mesma*/ 
CREATE TABLE Jogo(
    id INTEGER,
    inicio DATETIME,
    jornada INTEGER,
    epoca INTEGER,
    visitada TEXT NOT NULL,
    visitante TEXT NOT NULL,
    arbitro1 INTEGER,
    arbitro2 INTEGER,
    recinto TEXT,
    CONSTRAINT Jogo_PK PRIMARY KEY (id),
    CONSTRAINT Jornada_FK FOREIGN KEY (jornada, epoca) REFERENCES Jornada(numero, epoca),
    CONSTRAINT Equipa_FK1 FOREIGN KEY (visitada) REFERENCES Equipa(nome),
    CONSTRAINT Equipa_FK2 FOREIGN KEY (visitante) REFERENCES Equipa(nome),
    CONSTRAINT Arbitro_FK1 FOREIGN KEY (arbitro1) REFERENCES Arbitro(id),
    CONSTRAINT Arbitro_FK2 FOREIGN KEY (arbitro2) REFERENCES Arbitro(id),
    CONSTRAINT Recinto_FK FOREIGN KEY (recinto) REFERENCES Recinto(nome)
);

DROP TABLE IF EXISTS Recinto;
CREATE TABLE Recinto(
    nome TEXT,
    morada TEXT,
    cidade TEXT,
    CONSTRAINT Recinto_PK PRIMARY KEY (morada),
    CONSTRAINT Cidade_FK FOREIGN KEY (cidade) REFERENCES Cidade(nome)
);

DROP TABLE IF EXISTS Cidade;
CREATE TABLE Cidade(
    nome TEXT,
    CONSTRAINT Cidade_PK PRIMARY KEY (nome)
);

DROP TABLE IF EXISTS Equipa;
CREATE TABLE Equipa(
    nome TEXT,
    moradaSede TEXT,
    logo TEXT,
    email TEXT,
    telefone TEXT,
    website TEXT,
    moradaRecinto TEXT,
    CONSTRAINT Equipa_PK PRIMARY KEY (nome),
    CONSTRAINT Recinto_FK FOREIGN KEY (moradaRecinto) REFERENCES Recinto(morada)
);

DROP TABLE IF EXISTS Atleta;
CREATE TABLE Atleta(
    id INTEGER,
    nome TEXT,
    dataNascimento DATE,
    CONSTRAINT Atleta_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Treinador;
CREATE TABLE Treinador(
    id INTEGER,
    nome TEXT,
    dataNascimento DATE,
    CONSTRAINT Treinador_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Arbitro;
CREATE TABLE Arbitro(
    id INTEGER,
    nome TEXT,
    dataNascimento DATE,
    CONSTRAINT Arbitro_PK PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Pausa;
CREATE TABLE Pausa(
    minuto INTEGER,
    segundo INTEGER,
    equipa TEXT,
    jogo INTEGER,
    CONSTRAINT Pausa_PK PRIMARY KEY (minuto, segundo, jogo),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS Golo;
CREATE TABLE Golo(
    minuto INTEGER,
    segundo INTEGER,
    atleta INTEGER,
    equipa TEXT,
    jogo INTEGER,
    CONSTRAINT Golo_PK PRIMARY KEY (minuto, segundo, jogo),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS Sancao;
CREATE TABLE Sancao(
    minuto INTEGER,
    segundo INTEGER,
    tipo TEXT,
    atleta INTEGER,
    jogo INTEGER,
    CONSTRAINT Sancao_PK PRIMARY KEY (minuto, segundo, jogo),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id)
);

DROP TABLE IF EXISTS EquipaAtleta;
CREATE TABLE EquipaAtleta(
    equipa TEXT,
    atleta INTEGER,
    CONSTRAINT EquipaAtleta_PK PRIMARY KEY (equipa, atleta),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Atleta_FK FOREIGN KEY (atleta) REFERENCES Atleta(id)
);

DROP TABLE IF EXISTS EquipaTreinador;
CREATE TABLE EquipaTreinador(
    equipa TEXT,
    treinador INTEGER,
    CONSTRAINT EquipaTreinador_PK PRIMARY KEY (equipa, treinador),
    CONSTRAINT Equipa_FK FOREIGN KEY (equipa) REFERENCES Equipa(nome),
    CONSTRAINT Treinador_FK FOREIGN KEY (treinador) REFERENCES Treinador(id)
);

DROP TABLE IF EXISTS JogoGolo;
CREATE TABLE JogoGolo(
    jogo INTEGER,
    minuto INTEGER,
    segundo INTEGER,
    CONSTRAINT JogoGolo_PK PRIMARY KEY (jogo, minuto, segundo),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id),
    CONSTRAINT Golo_FK FOREIGN KEY (minuto, segundo, jogo) REFERENCES Golo(minuto, segundo, jogo)
);

DROP TABLE IF EXISTS JogoPausa;
CREATE TABLE JogoPausa(
    jogo INTEGER,
    minuto INTEGER,
    segundo INTEGER,
    CONSTRAINT JogoPausa_PK PRIMARY KEY (jogo, minuto, segundo),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id),
    CONSTRAINT Pausa_FK FOREIGN KEY (minuto, segundo, jogo) REFERENCES Pausa(minuto, segundo, jogo)
);

DROP TABLE IF EXISTS JogoSancao;
CREATE TABLE JogoSancao(
    jogo INTEGER,
    minuto INTEGER,
    segundo INTEGER,
    CONSTRAINT JogoSancao_PK PRIMARY KEY (jogo, minuto, segundo),
    CONSTRAINT Jogo_FK FOREIGN KEY (jogo) REFERENCES Jogo(id),
    CONSTRAINT Sancao_FK FOREIGN KEY (minuto, segundo, jogo) REFERENCES Sancao(minuto, segundo, jogo)
);

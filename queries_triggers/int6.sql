/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- idade do 3º melhor marcador da época 2021

select a.id as ID_JOG, a.nome as NOME, a.dataNascimento as DATA_NASC,  FLOOR((julianday('now') - julianday(a.dataNascimento)) / 365.25) AS IDADE
from atleta a
join(
    select JOGADOR_ID, NUM_GOLOS
    from(
        SELECT a.id as JOGADOR_ID, count(*) AS NUM_GOLOS
        FROM Atleta a
        JOIN Golo g on g.atleta = a.id
        JOIN Jogo j on j.id = g.jogo
        WHERE j.epoca = 2021
        GROUP BY a.nome
        ORDER BY NUM_GOLOS desc
        LIMIT 3
    )
    order by NUM_GOLOS
    limit 1
)
on a.id = JOGADOR_ID;


.mode columns 
.headers on 
.nullvalue NULL

SELECT a.nome as JOGADOR, e.nome as EQUIPA, count(*) AS NUM_GOLOS
FROM Atleta a
JOIN Golo g on g.atleta = a.id
JOIN Jogo j on j.id = g.jogo
JOIN Equipa e on e.id = g.equipa
WHERE j.epoca = 2020
GROUP BY a.nome
ORDER BY NUM_GOLOS desc
LIMIT 5;

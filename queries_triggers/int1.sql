/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Melhores 3 marcadores da época (2020)

SELECT a.nome as JOGADOR, count(*) AS NUM_GOLOS
FROM Atleta a
JOIN Golo g on g.atleta = a.id
JOIN Jogo j on j.id = g.jogo
WHERE j.epoca = 2020
GROUP BY a.nome
ORDER BY NUM_GOLOS desc
LIMIT 5;

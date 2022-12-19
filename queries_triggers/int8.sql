/*
.mode columns 
.headers on 
.nullvalue NULL
*/

--- Top 5 marcadores de uma época (2020)

SELECT a.nome, count(*) AS golos
FROM Atleta a
JOIN Golo g on g.atleta = a.id
JOIN Jogo j on j.id = g.jogo
WHERE j.epoca = '2020'
GROUP BY a.nome
ORDER BY golos desc
LIMIT 5;

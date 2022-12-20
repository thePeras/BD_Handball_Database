/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- A idade dos árbitros com mais interrupções numa época (2019)

SELECT a.nome AS Nome, count(*) AS Interrupcoes, 
FLOOR((julianday('now') - julianday(a.dataNascimento)) / 365.25) AS Idade, a.dataNascimento 
FROM Arbitro a
JOIN Jogo j on j.id = i.jogo and (j.arbitro1 = a.id or j.arbitro2 = a.id)
JOIN Interrupcao i on i.jogo = j.id
WHERE j.epoca = '2019'
GROUP BY a.id
ORDER BY Interrupcoes DESC
LIMIT 1;
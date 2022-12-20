/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- A idade dos árbitros com mais interrupções numa época (2019)

SELECT a.nome AS NOME, FLOOR((julianday('now') - julianday(a.dataNascimento)) / 365.25) AS IDADE, a.dataNascimento DATA_NASC, count(*) AS INTERRUPCOES
FROM Arbitro a
JOIN Jogo j on j.id = i.jogo and (j.arbitro1 = a.id or j.arbitro2 = a.id)
JOIN Interrupcao i on i.jogo = j.id
WHERE j.epoca = '2019'
GROUP BY a.id
ORDER BY Interrupcoes DESC
LIMIT 1;
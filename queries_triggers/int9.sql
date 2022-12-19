/*
.mode columns 
.headers on 
.nullvalue NULL
*/

--- O jogo com mais interrupções (Exclusão) de uma época (2019)

SELECT count(*) AS nInterrupções, j.data, e_visitada.nome AS visitada, e_visitante.nome AS visitante
FROM Jogo j
JOIN Interrupcao i on i.jogo = j.id
JOIN Equipa e_visitada on e_visitada.id = j.visitada
JOIN Equipa e_visitante on e_visitante.id = j.visitante
WHERE i.tipo = 'Exclusão'
AND j.epoca = '2019'
GROUP BY j.id
ORDER BY nInterrupções DESC
LIMIT 1;
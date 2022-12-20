/*
.mode columns 
.headers on 
.nullvalue NULL
*/

--- O jogo com mais interrupções (Exclusão) de uma época (2019)

SELECT j.data DATA, e_visitada.nome AS VISITADA, e_visitante.nome AS VISITANTE, count(*) AS NUM_EXC
FROM Jogo j
JOIN Interrupcao i on i.jogo = j.id
JOIN Equipa e_visitada on e_visitada.id = j.visitada
JOIN Equipa e_visitante on e_visitante.id = j.visitante
WHERE i.tipo = 'Exclusão'
AND j.epoca = '2019'
GROUP BY j.id
ORDER BY NUM_EXC DESC
LIMIT 1;
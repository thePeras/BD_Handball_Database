/*
.mode columns 
.headers on 
.nullvalue NULL
*/

--- Jogos que aconteceram numa determinada cidade

SELECT j.id, data, hora_de_inicio, e_visitada.nome as visitada, e_visitante.nome as visitante
FROM Cidade c
JOIN Recinto r on r.cidade = c.nome
JOIN Equipa e_visitada on e_visitada.recinto = r.nome
JOIN Jogo j on j.visitada = e_visitada.id
JOIN Equipa e_visitante on e_visitante.id = j.visitante
WHERE c.nome = 'Porto'
ORDER BY data DESC, hora_de_inicio;


.mode columns 
.headers on 
.nullvalue NULL


select DISTINCT jogo.data as DATA,Cidade.nome as CIDADE,e_visitada.nome VISITADA, e_visitante.nome VISITANTE
from jogo,Recinto,Cidade
JOIN Equipa e_visitada on Jogo.visitada = e_visitada.id
JOIN Equipa e_visitante ON Jogo.visitante = e_visitante.id
JOIN Recinto r_visitada ON e_visitada.Recinto = r_visitada.nome
JOIN Recinto r_visitante ON e_visitante.Recinto = r_visitante.nome
where (r_visitada.cidade = Cidade.nome and r_visitante.cidade = Cidade.nome and r_visitada.cidade = r_visitante.cidade) order by jogo.data;
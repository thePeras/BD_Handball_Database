/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Top 3 melhores pontuações da história do campeonato

select c.epoca as EPOCA, e.nome as EQUIPA, c.pontos as PONNTUACAO
from Classificacao c
join Equipa e on e.id = c.equipa
order by 3 desc
limit 3;

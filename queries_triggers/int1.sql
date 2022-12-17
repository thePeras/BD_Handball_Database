/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Melhores 3 marcadores da época 2021

select a.nome as JOGADOR, e.nome as EQUIPA, count(*) as NUM_GOLOS
from InscricaoAtleta i
join Atleta a on a.id = i.atleta
join Equipa e on e.id = i.equipa
join Golo g on i.atleta = g.atleta
where i.epoca = 2021
group by g.atleta
order by 3 desc
limit 3;

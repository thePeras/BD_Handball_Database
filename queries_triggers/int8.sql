/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Resultado de um jogo
select j.id as jogo, count(*) as golos, e.nome as equipa
from Jogo j
join Golo g on g.jogo = j.id
join equipa e on e.id = g.equipa
where j.id = 227988
group by g.equipa
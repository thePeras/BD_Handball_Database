/*
.mode columns 
.headers on 
.nullvalue NULL
*/

--- Ordem cronológica de eventos de um jogo

select g.minuto, g.segundo, 'Golo' as evento, a.nome as 'Jogador', e.nome as 'Equipa'
from Jogo j
join Golo g on g.jogo = j.id
join Atleta a on a.id = g.atleta
join Equipa e on e.id = g.equipa
where j.id = 227988
union
select p.minuto, p.segundo, 'Pausa Técnica' as evento, '' as 'Jogador', e.nome as 'Equipa'
from Jogo j
join PausaTecnica p on p.jogo = j.id
join Equipa e on e.id = p.equipa
where j.id = 227988
union
select i.minuto, i.segundo, i.tipo as evento, a.nome as 'Jogador', '' as 'Equipa'
from Jogo j
join Interrupcao i on i.jogo = j.id
join Atleta a on a.id = i.atleta
where j.id = 227988
order by minuto, segundo;
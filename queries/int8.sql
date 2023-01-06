
.mode columns 
.headers on 
.nullvalue NULL

select t1.data DATA, t1.visitada VISITADA, t1.golos_visitada G_VISITADA, t2.visitante VISITANTE, t2.golos_visitante G_VISITANTE
from (
    select j.id as jogo, j.data as data, e.nome as visitada, count(*) as golos_visitada
    from Jogo j
    join Golo g on g.jogo = j.id
    join equipa e on e.id = g.equipa
    where j.id = 207454 and e.id = j.visitada
) as t1
join (
    select j.id as jogo, j.data as data, e.nome as visitante, count(*) as golos_visitante
    from Jogo j
    join Golo g on g.jogo = j.id
    join equipa e on e.id = g.equipa
    where j.id = 207454 and e.id = j.visitante
) as t2 on t1.jogo = t2.jogo;
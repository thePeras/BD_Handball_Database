/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- resultado do jogo com id: 207454

/*
Tabela final:
Data | Visitada | Golos Visitada | Visitante | Golos Visitante

Tabela 1:
IDjogo | Data | Visitada | Golos Visitada

Tabela 2:
IDjogo | Data | Visitante | Golos Visitante

*/

select t1.data, t1.visitada, t1.golos_visitada, t2.visitante, t2.golos_visitante
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
/* Todas as equipas da cidade de Lisboa */

select e.nome as EQUIPA
from Equipa e 
join Recinto r on e.recinto = r.nome
join Cidade c on c.nome = r.cidade
where c.nome = 'Lisboa';

/* Cidades com mais de uma equipa */

select Cidade, NumeroEquipas
from(
	-- num equipas por cidade
    select c.nome as Cidade, count(*) as NumeroEquipas
    from Cidade c
    join Recinto r on r.cidade = c.nome
    join Equipa e on e.recinto = r.nome
    group by 1
)
where NumeroEquipas > 1;

/* Resultado de um jogo */

select j.id, count(*) as golos, e.nome
from Jogo j
join Golo g on g.jogo = j.id
join equipa e on e.id = g.equipa
where j.id = 227988
group by g.equipa


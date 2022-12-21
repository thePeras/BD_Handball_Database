/* Relational Model (portuguese)

Epoca(nome, inicio, fim)
Jornada(numero, epoca → Epoca)
Jogo(id, data, hora_de_inicio, (jornada, epoca) → Jornada, visitada → Equipa, visitante → Equipa, arbitro1 → Arbitro, arbitro2 → Arbitro)
Recinto(nome, morada, cidade → Cidade)
Cidade(nome)
Equipa(id, nome, logo, email, telefone, website, recinto → Recinto)
Classificacao(equipa → Equipa, epoca → Epoca, pontos)
Atleta(id, nome, dataNascimento)
Treinador(id, nome, dataNascimento)
InscricaoAtleta(atleta → Atleta, equipa → Equipa, epoca → Epoca)
InscricaoTreinador(treinador → Treinador, equipa → Equipa, epoca → Epoca)
Arbitro(id, nome, dataNascimento)
Golo(id, minuto, segundo, atleta → Atleta, equipa → Equipa, jogo → Jogo)
PausaTecnica(id, minuto, segundo, equipa → Equipa, jogo → Jogo)
Interrupcao(id, minuto, segundo, tipo, atleta → Atleta, jogo → Jogo)

*/

drop view if exists resultados;
create view resultados as
select t1.data DATA, t1.visitada VISITADA, t1.golos_visitada G_VISITADA, t2.visitante VISITANTE, t2.golos_visitante G_VISITANTE
from (
    select j.id as jogo, j.data as data, e.nome as visitada, count(*) as golos_visitada
    from Epoca ep
    join Jogo j on j.epoca = ep.inicio
    join Golo g on g.jogo = j.id
    join equipa e on e.id = g.equipa
    where e.id = j.visitada and ep.inicio = 2021
    group by j.id, e.id
) as t1
join (
    select j.id as jogo, j.data as data, e.nome as visitante, count(*) as golos_visitante
    from Epoca ep
    join Jogo j on j.epoca = ep.inicio
    join Golo g on g.jogo = j.id
    join equipa e on e.id = g.equipa
    where e.id = j.visitante and ep.inicio = 2021
    group by j.id, e.id
) as t2 on t1.jogo = t2.jogo;

-- using the view resultados, i want a view that shows the number of wins for each team 

drop view if exists vitoriasCasaFora;
create view vitoriasCasaFora as
select t1.visitada as equipa, count(*) as vitorias
from resultados t1
where t1.g_visitada > t1.g_visitante
group by t1.visitada
union
select t2.visitante as equipa, count(*) as vitorias
from resultados t2
where t2.g_visitada < t2.g_visitante
group by t2.visitante;

-- using vitoriasCasaFora, i want to sum both numbers for each team

drop view if exists vitorias;
create view vitorias as
select equipa, sum(vitorias) as vitorias
from vitoriasCasaFora
group by equipa;

-- now i want a table with the number of draws for each team

drop view if exists empatesCasaFora;
create view empatesCasaFora as
select t1.visitada as equipa, count(*) as empates
from resultados t1
where t1.g_visitada = t1.g_visitante
group by t1.visitada
union
select t2.visitante as equipa, count(*) as empates
from resultados t2
where t2.g_visitada = t2.g_visitante
group by t2.visitante;


-- using empatesCasaFora, i want to sum both numbers for each team

drop view if exists empates;
create view empates as
select equipa, sum(empates) as empates
from empatesCasaFora
group by equipa;


-- now i want a table with the number of losses for each team

drop view if exists derrotasCasaFora;
create view derrotasCasaFora as
select t1.visitada as equipa, count(*) as derrotas
from resultados t1
where t1.g_visitada < t1.g_visitante
group by t1.visitada
union
select t2.visitante as equipa, count(*) as derrotas
from resultados t2
where t2.g_visitada > t2.g_visitante
group by t2.visitante;

-- using derrotasCasaFora, i want to sum both numbers for each team

drop view if exists derrotas;
create view derrotas as
select equipa, sum(derrotas) as derrotas
from derrotasCasaFora
group by equipa;

-- for each game, a win is worth 3 points, a draw is worth 2 point and a loss is worth 1 points
-- i want a table with the number of points for each team, using views vitorias, empates and derrotas
-- if some team is not in one of these views, it means that it has 0 points just for that category

drop view if exists pontos;
create view pontos as
select v.equipa, (v.vitorias * 3) + (e.empates * 2) + (d.derrotas * 1) as pontos
from vitorias v
join empates e on e.equipa = v.equipa
join derrotas d on d.equipa = v.equipa
union
select e.equipa, (v.vitorias * 3) + (e.empates * 2) + (d.derrotas * 1) as pontos
from vitorias v
right join empates e on e.equipa = v.equipa
join derrotas d on d.equipa = v.equipa
union
select d.equipa, (v.vitorias * 3) + (e.empates * 2) + (d.derrotas * 1) as pontos
from vitorias v
join empates e on e.equipa = v.equipa
right join derrotas d on d.equipa = v.equipa
union
select v.equipa, (v.vitorias * 3) + (e.empates * 2) + (d.derrotas * 1) as pontos
from vitorias v
right join empates e on e.equipa = v.equipa
right join derrotas d on d.equipa = v.equipa;


SELECT * FROM pontos;


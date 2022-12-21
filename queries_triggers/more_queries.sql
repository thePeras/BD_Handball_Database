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



drop view if exists empates;
create view empates as
select t1.visitada as equipa, count(*) as empates
from resultados t1
where t1.g_visitada = t1.g_visitante
group by t1.visitada
union
select t2.visitante as equipa, count(*) as empates
from resultados t2
where t2.g_visitada = t2.g_visitante
group by t2.visitante;

drop view if exists empates2;
create view empates2 as
select e.nome as equipa, e.empates as empates
from equipa e
left join empates e on e.equipa = e.nome
where e.nome in (select visitada from resultados)
union
select e.nome as equipa, e.empates as empates
from equipa e
left join empates e on e.equipa = e.nome
where e.nome in (select visitante from resultados);

drop view if exists empatesTotal;
create view empatesTotal as
select e.equipa as equipa, COALESCE(sum(e.empates), 0) as empates
from empates2 e
group by e.equipa;


drop view if exists vitorias;
create view vitorias as
select t1.visitada as equipa, count(*) as vitorias
from resultados t1
where t1.g_visitada > t1.g_visitante
group by t1.visitada
union
select t2.visitante as equipa, count(*) as vitorias
from resultados t2
where t2.g_visitada < t2.g_visitante
group by t2.visitante;

drop view if exists vitorias2;
create view vitorias2 as
select e.nome as equipa, e.vitorias as vitorias
from equipa e
left join vitorias e on e.equipa = e.nome
where e.nome in (select visitada from resultados)
union
select e.nome as equipa, e.vitorias as vitorias
from equipa e
left join vitorias e on e.equipa = e.nome
where e.nome in (select visitante from resultados);

drop view if exists vitoriasTotal;
create view vitoriasTotal as
select e.equipa as equipa, COALESCE(sum(e.vitorias), 0) as vitorias
from vitorias2 e
group by e.equipa;


drop view if exists derrotas;
create view derrotas as
select t1.visitada as equipa, count(*) as derrotas
from resultados t1
where t1.g_visitada < t1.g_visitante
group by t1.visitada
union
select t2.visitante as equipa, count(*) as derrotas
from resultados t2
where t2.g_visitada > t2.g_visitante
group by t2.visitante;

drop view if exists derrotas2;
create view derrotas2 as
select e.nome as equipa, e.derrotas as derrotas
from equipa e
left join derrotas e on e.equipa = e.nome
where e.nome in (select visitada from resultados)
union
select e.nome as equipa, e.derrotas as derrotas
from equipa e
left join derrotas e on e.equipa = e.nome
where e.nome in (select visitante from resultados);

drop view if exists derrotasTotal;
create view derrotasTotal as
select e.equipa as equipa, COALESCE(sum(e.derrotas), 0) as derrotas
from derrotas2 e
group by e.equipa;

drop view if exists Classificacao;
create view Classificacao as
select v.equipa as equipa, v.vitorias as vitorias, e.empates as empates, d.derrotas as derrotas, (v.vitorias * 3) + (e.empates * 2) + (d.derrotas * 1) as pontos
from vitoriasTotal v
join empatesTotal e on e.equipa = v.equipa
join derrotasTotal d on d.equipa = v.equipa
order by pontos desc;



SELECT * FROM classificacao;
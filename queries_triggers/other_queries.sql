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



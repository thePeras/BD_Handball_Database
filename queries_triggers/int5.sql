/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Média de golos por época
select Atleta.nome,Count(*)/Epocas as Média_Golos,Epocas
from
    (SELECT Atleta ,count(*) as Epocas
    from Atleta,InscricaoAtleta
    where (InscricaoAtleta.atleta = Atleta.id) group by InscricaoAtleta.atleta
) 
AS ne,Golo,Atleta 
where(ne.atleta = Golo.atleta and Golo.atleta = Atleta.id ) 
GROUP by golo.Atleta 
order by Epocas desc, Média_Golos desc;
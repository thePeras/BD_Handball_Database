
.mode columns 
.headers on 
.nullvalue NULL

select Atleta.nome JOGADOR ,Count(*)/Epocas as GOLOS, Epocas NUM_EPOCAS
from
    (SELECT Atleta ,count(*) as Epocas
    from Atleta,InscricaoAtleta
    where (InscricaoAtleta.atleta = Atleta.id) group by InscricaoAtleta.atleta
) 
AS ne,Golo,Atleta 
where(ne.atleta = Golo.atleta and Golo.atleta = Atleta.id ) 
GROUP by golo.Atleta 
order by Epocas desc, 2 desc
limit 5;
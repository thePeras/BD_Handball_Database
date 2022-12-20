/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Estatísticas de uma equipa numa época (número de golos, número de cada tipo de interrupção)

DROP VIEW IF EXISTS interrupções;
CREATE VIEW interrupções AS
SELECT Epoca.inicio as epoca, Equipa.nome equipa, Interrupcao.tipo
FROM Interrupcao
JOIN InscricaoAtleta ON Interrupcao.atleta = InscricaoAtleta.atleta
JOIN Epoca ON Epoca.inicio = InscricaoAtleta.epoca
JOIN Equipa ON Equipa.id = InscricaoAtleta.equipa;


SELECT 
    DISTINCT epocaInício INCIO_EPOCA, 
    epocaFim FIM_EPOCA, 
    nomeEquipa EQUIPA, 
    Golos GOLOS, 
    Infrações INFRACOES, 
    Expulsões EXPULSOES, 
    Advertências ADVERTENCIAS, 
    Exclusões EXCLUSOES, 
    Desqualificações DESQUALIFICACOES
FROM 

(SELECT Epoca.inicio as epocaInício, Epoca.fim as epocaFim, Equipa.nome as nomeEquipa, Count(*) as Golos 
from Equipa, Epoca, InscricaoAtleta, Golo
where Golo.atleta = InscricaoAtleta.atleta and Equipa.id = InscricaoAtleta.equipa and Epoca.inicio = InscricaoAtleta.epoca
group by Epoca,Equipa.id
) as gol,  
  
(SELECT equipa, Count(*) as Expulsões from interrupções
where tipo = 'Expulsão'
group by epoca, equipa
) as ex, 

(SELECT equipa, Count(*) as Infrações from interrupções
where tipo = 'Infração'
group by epoca, equipa
) as inf, 

(SELECT equipa, Count(*) as Advertências from interrupções
where tipo = 'Advertência'
group by epoca, equipa
) as adv, 

(SELECT equipa, Count(*) as Exclusões from interrupções
where tipo = 'Exclusão'
group by epoca, equipa
) as exc, 

(SELECT equipa, Count(*) as Desqualificações from interrupções
where tipo = 'Desqualificação'
group by epoca, equipa
) as desq

where ex.equipa = nomeEquipa
and inf.equipa = nomeEquipa 
and adv.equipa = nomeEquipa 
and exc.equipa = nomeEquipa
and desq.equipa = nomeEquipa
order by 1,3;

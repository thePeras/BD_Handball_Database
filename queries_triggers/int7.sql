.mode columns 
.headers on 
.nullvalue NULL

-- Tabela de classificações da época 2021

select e.nome, c.pontos
from Equipa e
join Classificacao c on e.id = c.pontos
where c.epoca = 2021

/*
.mode columns 
.headers on 
.nullvalue NULL
*/

-- Média de golos por jogo em cada época 

select Epoca EPOCA, round(avg(Golos),1) as GOLOS
from 
    (select Epoca,count(*) as Golos 
    from Jogo,Golo 
    where Jogo.id = Golo.jogo 
    group by Jogo.id) 
group by Epoca 
order by 1;


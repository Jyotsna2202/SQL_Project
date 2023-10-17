
--Query 01 : Retreiving film, title from the film table on the condition where rating is 'PG' and ordering in the ascending order.

select film_id,title
from film 	
where rating ='PG'	
order by film_id asc;	

--Query 02 : Retreiving list of films from film table on the condition where description contains the text 'chef'.

select * from  film where 
description ilike '%chef%'

--Query 03 : Retreiving list of films from film table whose length is between 50 and 100 and ordering in the descending order.

select title, length from film as f
where length between 50 and 100
order by length desc;

--Query 04 : Retreiving number of films from film table group by rating

select rating, count(film_id)as filmcountperrating
from film
group by rating
order by filmcountperrating asc;

--Query 05 : Retreiving total number of films by each actor 

select a.actor_id, concat(a.first_name,' ',a.last_name) as Actors_name, count (*) as Numberof_films from
film as f 
join film_actor as fa on f.film_id =fa.film_id
join actor as a on fa.actor_id=a.actor_id
group by a.actor_id
order by a.actor_id asc;

--Query 06 : Retreiving Actor-genre count break up---

With Actor_FilmGenre_breakup as(
select a.actor_id, concat(a.first_name,' ',a.last_name) as Actors_name, concat(c.name, ' ', ':', ' ',count (f.film_id)) as FilmCount_PerGenre from
film as f 
join film_actor as fa on f.film_id =fa.film_id
join actor as a on fa.actor_id=a.actor_id
join film_category as fc on fc.film_id=f.film_id
join category as c on c.category_id=fc.category_id
group by a.actor_id,actors_name,c.name
order by a.actor_id asc
)
select actor_id,Actors_name,string_to_array(string_agg(FilmCount_PerGenre,'55555'),'55555')
from  Actor_FilmGenre_breakup
group by actor_id,actors_name
order by actor_id asc;

--Query 07 : Retreiving list of 3 customers who have made the highest total purchases.

select c.customer_id,c.first_name,c.last_name, sum(amount) as totalpurchase
from customer c join payment p
on c.customer_id=p.customer_id
group by c.customer_id
order by totalpurchase desc
limit 3;

--Query 08 : Retreiving list of 3 customers who have made the lowest total purchases.

select c.customer_id,c.first_name,c.last_name, sum(amount) as totalpurchase
from customer c join payment p
on c.customer_id=p.customer_id
group by c.customer_id
order by totalpurchase asc
limit 3;

--Query 09 : RetreivingList of all the even records from a customer table.

select *, dense_rank() over(order by customer_id)as Drank from customer where customer_id%2=0;

--Query 10 : RetreivingList of all the odd records from a customer table.

select *, dense_rank() over(order by customer_id) as Drank from customer where customer_id%2=1;
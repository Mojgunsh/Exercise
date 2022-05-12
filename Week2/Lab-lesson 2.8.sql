Use sakila;
-- Write a query to display for each store its store ID, city, and country.

select s.store_id, c.city , co.country
from store as s
left join address as ad on  ad.address_id=s.address_id
left join city as c on c.city_id=ad.city_id
left join country as co on c.country_id =co.country_id
order by store_id;

-- Write a query to display how much business, in dollars, each store brought in.
-- store_id store  pyement payment_id, customer_id 

select s.store_id,sum(p.amount) as amount
from store as s
left join customer as c on s.store_id =c.store_id
left join payment as p on p.customer_id=c.customer_id
group by s.store_id
order by s.store_id asc;

-- Which film categories are longest?
-- efficient way
select count(fc.film_id ) as count_film ,c.name as cat_name 
from  category as c 
left join film_category as fc on fc.category_id=c.category_id
group by c.name
order by count_film desc limit 1;

-- another way of solving :

select count(f.title) as count_film ,c.name as cat_name 
from  category as c 
left join film_category as fc on fc.category_id=c.category_id
left join film as f on f.film_id = fc.film_id
group by c.name
order by count_film desc limit 1;

-- Display the most frequently rented movies in descending order.

select count(r.rental_id) as count ,f.title  
from rental as r
join  inventory as i on r.inventory_id=i.inventory_id
join film as f on f.film_id=i.film_id
group by f.title
order by count desc limit 1 ;

-- List the top five genres in gross revenue in descending order.

select c.name,sum(p.amount) as revenue
from category as c
left join film_category as fc on c.category_id=fc.category_id
left join inventory as i on i.film_id=fc.film_id
left join rental as r  on r.inventory_id=i.inventory_id
left join payment as p on p.rental_id=r.rental_id
group by c.name
order by revenue desc limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
Select f.title,
case
WHEN max(r.return_date)-max(r.rental_date)>0 then'Available'
ELSE 'No'
END AS 'Status'
from film as f
join inventory as i on i.film_id=f.film_id
join rental as r on r.inventory_id=i.inventory_id
where f.title= "Academy Dinosaur"
order by r. rental_date desc;

-- Get all pairs of actors that worked together.

select Concat (a1.first_name," ", a1.last_name),concat (a2.first_name," ",a2.last_name)
from (film_actor as fa1 right join actor as a1 on a1.actor_id=fa1.actor_id)
join
(film_actor as fa2 right join actor as a2 on a2.actor_id=fa2.actor_id)
where (fa1.film_id = fa2.film_id) 
and (fa1.actor_id != fa2.actor_id)
and (fa1.actor_id < fa2.actor_id);

-- Get all pairs of customers that have rented the same film more than 3 times.

select concat(c1.first_name," ",c1.last_name ),concat(c2.first_name ," ",c2.last_name)
	from (rental as r1
		right join 
			customer as c1 on c1.customer_id= r1.customer_id
		right join 
			inventory as i1 on  r1.inventory_id=i1.inventory_id
		right join 
			film as f1 on  f1.film_id=i1.film_id)
	join         
	(rental as r2
	right join 
		customer as c2 on c2.customer_id= r2.customer_id
	right join 
			inventory as i2 on  r2.inventory_id=i2.inventory_id
	right join 
			film as f2 on  f2.film_id=i2.film_id)
	where (f1.film_id=f2.film_id )and (c1.customer_id != c2.customer_id) 
			and (c1.customer_id < c2.customer_id)
    group by c1.first_name , c2.first_name,c1.last_name,c2.last_name
    having count(f1.film_id)>3 and count(f2.film_id)>3; 
	
-- For each film, list actor that has acted in more films.
select f.title,a.first_name
from film as f
join film_actor as fm on fm.film_id=f.film_id
join actor as a on a.actor_id=fm.actor_id
group by f.title,a.first_name
having count(fm.actor_id)>1;




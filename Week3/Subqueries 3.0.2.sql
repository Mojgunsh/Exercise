use sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
select count(inventory_id) as inventory  from inventory where
 film_id in ( select film_id from film
             where title= 'Hunchback Impossible');
             
#List all films whose length is longer than the average of all the films.
select title from film 
where length>(select avg(length) from film);

-- Use subqueries to display all actors who appear in the film Alone Trip.
select first_name,last_name from actor
	where actor_id in
		(select actor_id from film_actor 
		 where film_id in 
			(select film_id from film where title='Alone Trip'));
            
-- Sales have been lagging among young families, 
-- and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
select title from film 
where film_id in
	(select film_id from film_category
		where category_id in 
			(select category_id from category where name ='Family'));
            
-- Get name and email from customers from Canada using subqueries.
-- Do the same with joins. Note that to create a join,
-- you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.
select email from customer
    where address_id in 
		(select address_id from address 
    where city_id in 
		(select city_id from city 
    where country_id in
			(select country_id from country where country='Canada')));

-- with join
select email from customer as cu
left join address as a on cu.address_id=a.address_id
left join city as c on a.city_id=c.city_id
left join country as co on c.country_id=co.country_id
where co.country='Canada';

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor
-- that has acted in the most number of films. First you will have to find the most prolific actor
-- and then use that actor_id to find the different films that he/she starred.
select title from film 
where film_id in
(select film_id from film_actor
where actor_id in 
(select actor_id from film_actor
group by actor_id
having count(actor_id) in 
			(select max(count) from
			(select count(actor_id) as count,actor_id from film_actor
			 group by actor_id) as sub1)));
             ;
-- Films rented by most profitable customer. You can use the customer table and payment table to find
--  the most profitable customer ie the customer that has made the largest sum of payments
 select f.title
 from rental r
 left join inventory as i on r.inventory_id=i.inventory_id
 left join film as f on i.film_id=f.film_id
		where r.customer_id in
        (select customer_id from
			(select customer_id,sum(amount) as sum
				from payment
				group by customer_id
				order by sum desc limit 1) sub1);

-- Customers who spent more than the average payments

select first_name,last_name from customer where customer_id in
	(select customer_id 
	from payment
	group by customer_id
	having sum(amount)> (select avg(amount) as avgerage from payment));
    
-- calculating avg based on total customer payment    
select c.first_name,c.last_name
from payment as p 
left join customer as c on p.customer_id=c.customer_id
group by p.customer_id
having sum(amount)>(select avg(total) from     
		(select customer_id,sum(amount) as total 
		from payment
		group by customer_id) as sub1);




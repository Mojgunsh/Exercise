
use sakila;
-- How many films are there for each of the categories
-- in the category table. Use appropriate join to write this query.

select count(fc.film_id ) as count_film ,c.name as cat_name 
from  category as c 
left join film_category as fc on fc.category_id=c.category_id
group by c.name
order by cat_name asc;

-- Display the total amount rung up by each staff member in August of 2005.

select p.staff_id, s.first_name, s.last_name, sum(p.amount) as amount
from payment as p
right join staff as s
on s.staff_id=p.staff_id
where (DATE_FORMAT(payment_date,'%Y')=2005) and
(DATE_FORMAT(payment_date,'%m')=8)
group by p.staff_id, s.first_name, s.last_name;

-- Which actor has appeared in the most films?

select fa.actor_id,a.first_name,a.last_name,count(fa.film_id) as count
from film_actor as fa
right join actor as a
on fa.actor_id=a.actor_id
group by fa.actor_id,a.first_name,a.last_name
order by count desc limit 1;

-- Most active customer 
-- (the customer that has rented the most number of films)

select c.customer_id,c.first_name,c.last_name,count(r.rental_id) as count
from customer as c
left join rental as r
on c.customer_id=r.customer_id
group by c.customer_id,c.first_name,c.last_name
order by count desc limit 1;

-- Display the first and last names
-- , as well as the address, of each staff member.

select  s.staff_id,s.first_name,s.last_name,a.address
from staff as s 
left join address as a
on a.address_id= s.address_id;

-- List each film and the number of actors who are listed for that film.

select f.title,count(fa.actor_id) as count
from film_actor as fa
left join film as f  on f.film_id = fa.film_id
group by f.title;

-- Using the tables payment and customer and the JOIN command, list the total 
# paid by each customer. List the customers alphabetically by last name.

select c.customer_id,c.first_name,c.last_name,sum(p.amount) as payment
from customer as c
left join payment as p
on c.customer_id= p.customer_id
group by c.customer_id,c.first_name,c.last_name
order by c.first_name asc;

-- List number of films per category.

select count(fc.film_id ) as count_film ,c.name as cat_name 
from  category as c 
right join film_category as fc on fc.category_id=c.category_id
group by c.name
order by cat_name asc;

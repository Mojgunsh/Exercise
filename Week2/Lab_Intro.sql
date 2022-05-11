use sakila;
-- Get all the data from tables actor, film and customer.
select * from actor,film,customer;
-- Get film titles.
select distinct(title) from film;
-- Get unique list of film languages under the alias language
select distinct(name)from language;
-- language per each film
select f.title ,l.name from film as f ,language as l
where l.language_id=f.language_id
order by f.title asc;
-- Find out how many stores does the company have?
select count(store_id) from store;
-- Find out how many employees staff does the company have?
select count(staff_id) from staff;
-- Return a list of employee first names only?
select first_name from staff;







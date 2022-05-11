USE sakila;
--  In the table actor, which are the actors whose last names are not repeated
select last_name,count(last_name) as count from actor
group by last_name
having count=1;
-- Which last names appear more than once
select last_name,count(last_name) as count from actor
group by last_name
having count>1;
-- Using the rental table, find out how many rentals were processed by each employee.
select staff_id,count(rental_id) as count
from rental
group by staff_id;
-- Using the film table, find out how many films were released each year.
select release_year ,count(film_id) as Count
from film
group by release_year;
-- Using the film table, find out for each rating how many films were there
select rating ,count(film_id) as Count
from film
group by rating;
-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select rating ,round(avg(length),2) as Average_len
from film
group by rating;
-- Which kind of movies (rating) have a mean duration of more than two hours?
select rating ,round(avg(length),2) as Average_len
from film
group by rating;
-- Which kind of movies (rating) have a mean duration of more than two hours?
select rating ,round(avg(length),2) as Average_len
from film
group by rating
having Average_len>120;
-- Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title,length,rank() over (ORDER BY length desc) rank_
from film
WHERE (title IS NOT NULL) AND (title != '  ')
order by length desc;
-- group by title,length



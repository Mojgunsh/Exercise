USE sakila;
-- Select all the actors with the first name ‘Scarlett’.
select * from actor
where first_name='Scarlett';
-- How many films (movies) are available for rent and how many films have been rented?
SELECT count(distinct(film_id)) 
from film
where rental_duration=0 ;
SELECT count(distinct(film_id)) 
from film
where rental_duration !=0;
-- What are the shortest and longest movie duration? Name the values max_duration and min_duration
select * from film;
select max(length) as max_duration,min(length) as min_duration
from film;
-- What's the average movie duration expressed in format (hours, minutes)?
SELECT SEC_TO_TIME(avg(length*60)) as Avg_length
from film;
-- How many distinct (different) actors' last names are there?
select count(distinct(last_name)) as count from actor;
-- Since how many days has the company been operating (check DATEDIFF() function)?
select DATEDIFF(sysdate(), min(rental_date))
from rental;
-- Show rental info with ad;ditional columns month and weekday. Get 20 results.
select *, DATE_FORMAT(rental_date,'%M') as month ,
DATE_FORMAT(rental_date,'%W') as day
from rental;
-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE
WHEN DATE_FORMAT(rental_date,'%W') ='Tuesday'  then 'Workday'
WHEN DATE_FORMAT(rental_date,'%W') = "wednesday" then 'Workday'
WHEN DATE_FORMAT(rental_date,'%W') = "Thursday" then 'Workday'
WHEN DATE_FORMAT(rental_date,'%W') = "Monday" then 'Workday'
WHEN DATE_FORMAT(rental_date,'%W') = "Friday" then 'Workday'
WHEN DATE_FORMAT(rental_date,'%W') = "Saturday" then 'weekend'
WHEN DATE_FORMAT(rental_date,'%W') = "Sunday" then 'weekend'
ELSE 'No status'
END AS 'W_day',DATE_FORMAT(rental_date,'%M') as month ,
DATE_FORMAT(rental_date,'%W') as day
FROM rental;
-- Get release years.
select release_year from film;
-- Get all films with ARMAGEDDON in the title.;
SELECT * FROM film where
(title like ('%ARMAGEDDON%'));
-- Get all films which title ends with APOLLO.
select title from film
where right(title,6)='APOLLO';
-- Get 10 the longest films
select title,length from film
order by length Desc limit 10;
-- How many films include Behind the Scenes content?
SELECT count(*) FROM film where
(special_features like ('%Behind the Scenes%'));



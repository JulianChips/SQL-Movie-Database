use sakila;


-- Display the first and last names of all actors from the table actor
select first_name, last_name from actor;


-- Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
select concat(first_name," ", last_name) as 'Actor Name'
from actor;


-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
select actor_id, first_name, last_name
from actor
where first_name = "Joe";


-- Find all actors whose last name contain the letters GEN
select first_name, last_name
from actor
where last_name like "%GEN%";


-- Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order
select first_name, last_name
from actor
where last_name like "%LI%"
order by last_name, first_name asc;


-- Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
select country_id, country
from country
where country in ('Afghanistan','Bangladesh','China');


-- create a column in the table actor named description and use the data type BLOB
alter table actor
add description blob;


-- Delete the description column
alter table actor
drop description;


-- List the last names of actors, as well as how many actors have that last name
select last_name, count(last_name)
from actor
group by last_name;


-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name)
from actor
group by last_name
having count(last_name) > 1;


-- The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record
update actor
set first_name = "HARPO"
where first_name = "GROUCHO" AND last_name = "WILLIAMS";


-- In a single query, if the first name of 'the' actor is currently HARPO, change it to GROUCHO
-- I'm assuming 'the' refers to the actor who still has the last name WILLIAMS.
update actor
set first_name = "GROUCHO"
where first_name = "HARPO" AND last_name = "WILLIAMS";


-- You cannot locate the schema of the address table. Which query would you use to re-create it?
-- using the 'Send to SQL editor' option in the navigator.
/*
CREATE TABLE `address` (
  `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `location` geometry NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  SPATIAL KEY `idx_location` (`location`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8;
*/
-- using the show create table command
SHOW CREATE TABLE address;


-- Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
select first_name, last_name, address
from staff s
inner join address a
using (address_id);

-- Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment

select first_name, last_name, sum(amount)
from staff s
inner join payment p
using (staff_id)
where payment_date like "2005-08%"
group by staff_id;

select * from payment limit 10;
-- List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select title, count(actor_id)
from film f
inner join film_actor fa
using (film_id)
group by film_id; 


-- How many copies of the film Hunchback Impossible exist in the inventory system?
select title, count(i.film_id)
from film f
inner join inventory i
using (film_id)
where title = "Hunchback Impossible"
group by film_id;


-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
select first_name, last_name, sum(amount)
from customer c
inner join payment p
using (customer_id)
group by customer_id
order by last_name asc;



-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select title
from film
where (title like "Q%" or title like "K%") and
language_id in(
	select language_id
    from language
    where name = "English"
);



-- Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name
from actor
where actor_id in
(
	select actor_id
    from film_actor
    where film_id in
    (
		select film_id
        from film
        where title = "Alone Trip"
    )
);

select * from address limit 10;
-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.
select first_name, last_name, email
from customer 
inner join address
using (address_id)
inner join city
using (city_id)
inner join country
using (country_id)
where country = "Canada";


-- Identify all movies categorized as family films.
select title
from film
where film_id in
(
	select film_id
    from film_category
    where category_id in
    (
		select category_id
        from category
        where name = "Family"
    )
);


-- Display the most frequently rented movies in descending order.
select title, count(i.film_id)
from film f
inner join inventory i
using (film_id)
group by title
order by count(i.film_id) desc;



-- Write a query to display how much business, in dollars, each store brought in.
-- since only ones taff member seems to work at each store, this is equivalent to the total amount they have each rung up.
select store_id, sum(amount)
from staff s
inner join payment p
using (staff_id)
group by staff_id;


-- Write a query to display for each store its store ID, city, and country.
select store_id, city, country
from store s
inner join address a
using(address_id)
inner join city
using(city_id)
inner join country
using(country_id);


-- List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select name, sum(amount)
from category
inner join film_category
using(category_id)
inner join inventory
using(film_id)
inner join rental
using(inventory_id)
inner join payment
using(rental_id)
group by name
order by sum(amount) desc limit 5;


--  In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
-- Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
Create View Top_Five_Genres
AS select name, sum(amount)
from category
inner join film_category
using(category_id)
inner join inventory
using(film_id)
inner join rental
using(inventory_id)
inner join payment
using(rental_id)
group by name
order by sum(amount) desc limit 5;


-- How would you display the view that you created in 8a (above)?
Select * from top_five_genres;


-- You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_genres;
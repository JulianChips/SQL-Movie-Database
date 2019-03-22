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



-- Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment



-- List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.



-- How many copies of the film Hunchback Impossible exist in the inventory system?



-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.




-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.



-- Use subqueries to display all actors who appear in the film Alone Trip.



-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.



-- Identify all movies categorized as family films.



-- Display the most frequently rented movies in descending order.



-- Write a query to display how much business, in dollars, each store brought in.



-- Write a query to display for each store its store ID, city, and country.



-- List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)



--  In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
-- Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.



-- How would you display the view that you created in 8a (above)?



-- You find that you no longer need the view top_five_genres. Write a query to delete it.
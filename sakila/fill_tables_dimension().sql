use dw_sakila;

delimiter $$
CREATE procedure `fill_tables_dimension` ()
BEGIN
	
insert into dw_sakila.dim_customer
select c.customer_id, c.store_id, first_name, last_name, email, case when active = 1 then "Yes" else "No" end as active, create_date,  c.last_update , city.city, country.country, a.address,
a.postal_code  
from sakila.customer as c 
join sakila.address as a using (address_id)
join sakila.city using (city_id)
join sakila.country using (country_id);


insert into dw_sakila.dim_staff
select staff_id, first_name, last_name, a.address, email, active, username  
from  sakila.staff
join sakila.address as a using (address_id); 


insert into dw_sakila.dim_store
select  store_id, address,city, country, a.postal_code from sakila.store
join sakila.address as a using(address_id)
join sakila.city using(city_id)
join sakila.country using(country_id) ;


insert into dw_sakila.dim_film
select film_id, title, description, release_year, l.name as language, case when l_o.name = null then "NA" else l_o.name end  as original_language, rental_duration, rental_rate, length, replacement_cost, rating,
special_features 
from sakila.film as f
join sakila.language as l using(language_id)
left join sakila.language as l_o on(original_language_id=f.language_id);

END $$
delimiter ;


-- call test_p();
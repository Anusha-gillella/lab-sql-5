-- Query 1
alter table sakila.staff
drop column picture;
select * from sakila.staff;

-- Query 2
insert into sakila.staff
values(3,'TAMMY','SANDERS',79,'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy','null',current_timestamp);
select * from sakila.staff;

-- Query 3
select customer_id into @customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
select @customer_id;

select film_id into @film_id from sakila.film
where title = 'ACADEMY DINOSAUR';
select @film_id;

select inventory_id into @inventory_id from sakila.inventory
where film_id = @film_id and store_id =1 limit 1;
select @inventory_id;

select staff_id into @staff_id from sakila.staff
where first_name = 'Mike';
select @staff_id;

select max(rental_id)+1 into @rental_id from sakila.rental;
select @rental_id;

insert into sakila.rental
values (@rental_id,now(),@inventory_id,@customer_id,'2005-05-26 22:04:30',@staff_id,'2006-02-15 21:30:53');

select * from sakila.rental
where rental_id = @rental_id;

-- Query 4
select * from customer
where active = 0;

SHOW CREATE table customer;

CREATE TABLE if not exists `deleted_users` (
  `customer_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `delete_date` datetime NOT NULL,
  PRIMARY KEY (`customer_id`)
);

insert into deleted_users
select customer_id, email, now() as delete_date from customer;

SET sql_safe_updates=0;

delete from payment
where customer_id in (select customer_id from customer where active = 0);

delete from rental
where customer_id in (select customer_id from customer where active = 0);

delete from customer
where active = 0;

select * from deleted_users;






















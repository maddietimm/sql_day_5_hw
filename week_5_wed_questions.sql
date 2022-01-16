-- List all customers who live in Texas
-- ** Jennifer Davis, Kim Cruz, Richard Mccrary, 
-- Bryan Hardison and Ian Still **
select first_name,last_name,address.address_id
from customer
full join address
on customer.address_id = address.address_id
where district = 'Texas';

--Get all payments above 6.99 with the customer's full name
-- **Succeeded in finding the payment and the full name
select first_name,last_name,payment.customer_id,payment.amount
from customer
full join payment
on customer.customer_id = payment. customer_id
where amount > 6.99;

--Show all customers names who have made paymetns over $175
-- ** Showed 11 customers in table
select first_name,last_name,customer_id
from customer
where customer_id in (
	select customer_id
	from payment 
	group by customer_id 
	having sum(amount) > 175
	order by sum(amount) desc
);

-- List all customers that live in Nepal
-- ** No information returns
select customer.first_name,customer.last_name,address.city_id,city
from customer
full join address 
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id
where city = 'Nepal';

-- Which staff member had the most transactions
-- ** Mike Hillyer
select staff.first_name,staff.last_name,payment.staff_id,count(payment.payment_id)
from staff
full join payment 
on staff.staff_id = payment.staff_id 
group by payment.payment_id,payment.staff_id,staff.first_name,staff.last_name 
order by count desc

-- How many movies of each rating are there
-- NC-17 = 210, R = 195, PG-13 = 223, PG = 194, G = 178
select rating,count(rating) from film
group by rating 
order by rating desc;

-- Show all customer's who have made a single payment over 6.99
select payment.customer_id
from payment
full join customer
on payment.customer_id = customer.customer_id
group by payment.customer_id,amount 
having amount > 6.99 and count(amount>6.99) <= 1
order by customer_id

select first_name,last_name
from customer
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id 
having amount > 6.99 and count(amount) = 1
order by customer_id
)
group by first_name,last_name,payment.amount ;

-- How many free rentals did our store give away?
-- ** 24 free rentals
select rental.rental_id 
from rental
full join payment
on rental.rental_id = payment.rental_id
where amount = 0


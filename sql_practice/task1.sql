-- Problem 1: Retrieve all products in the Sports category
-- Write an SQL query to retrieve all products in a specific category.

SELECT *
FROM Products 
Where category_id=8;

-- Problem 2: Retrieve the total number of orders for each user
-- Write an SQL query to retrieve the total number of orders for each user.
-- The result should include the user ID, username, and the total number of orders.

 select u.user_id, u.username, COUNT(o.total_amount) as Total from Orders o
  join Users u on o.user_id = u.user_id
  group by u.user_id, u.username 

-- Problem 3: Retrieve the average rating for each product
-- Write an SQL query to retrieve the average rating for each product.
-- The result should include the product ID, product name, and the average rating.

select p.product_id, p.product_name, AVG(CAST(r.rating AS float)) as AverageRate from Products p
  join Reviews r on r.product_id = p.product_id
  group by p.product_id, p.product_name

-- Problem 4: Retrieve the top 5 users with the highest total amount spent on orders
-- Write an SQL query to retrieve the top 5 users with the highest total amount spent on orders.
-- The result should include the user ID, username, and the total amount spent.


select top 5 u.user_id, u.username, sum(o.total_amount) as Total from Orders o
  join Users u on o.user_id = u.user_id
  group by u.user_id, u.username 
  order by sum(o.total_amount) desc


-- Problem 1: Retrieve all products in the Sports category
-- Write an SQL query to retrieve all products in a specific category.

	Select * from Products
	where category_id = 1
	
	--or

	SELECT [product_id]      ,[product_name]      ,[description]      ,[price]      ,[category_id]  FROM [Products]
	where category_id = 1

	

-- Problem 2: Retrieve the total number of orders for each user
-- Write an SQL query to retrieve the total number of orders for each user.
-- The result should include the user ID, username, and the total number of orders.

  select u.user_id, u.username, sum(o.total_amount) as Total from Orders o
  join Users u on o.user_id = u.user_id
  group by u.user_id, u.username 
  
  --Note: why group by username: it is because of Error Column 'u.username' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
  --           so any columns on the select must either with aggregate function or put it on group by
  

-- Problem 3: Retrieve the average rating for each product
-- Write an SQL query to retrieve the average rating for each product.
-- The result should include the product ID, product name, and the average rating.
  select p.product_id, p.product_name, AVG(CAST(r.rating AS float)) as AverageRate from Products p
  join Reviews r on r.product_id = p.product_id
  group by p.product_id, p.product_name
  
  
  --Note: rate is int, but average may not int, so cast it to any type with digit number
  
-- Problem 4: Retrieve the top 5 users with the highest total amount spent on orders
-- Write an SQL query to retrieve the top 5 users with the highest total amount spent on orders.
-- The result should include the user ID, username, and the total amount spent.

  select top 5 u.user_id, u.username, sum(o.total_amount) as Total from Orders o
  join Users u on o.user_id = u.user_id
  group by u.user_id, u.username 
  order by sum(o.total_amount) desc
  
  --Note: top 5 will get 5 rows from query on sql server, it might different sytax on other database
  
  
  -- Problem 5: Retrieve the products with the highest average rating
-- Write an SQL query to retrieve the products with the highest average rating.
-- The result should include the product ID, product name, and the average rating.
-- Hint: You may need to use subqueries or common table expressions (CTEs) to solve this problem.
  
  select p.product_id, p.product_name, AVG(CAST(r.rating AS float)) as AverageRate from Products p
  join Reviews r on r.product_id = p.product_id
  group by p.product_id, p.product_name
  having AVG(CAST(r.rating AS float)) = 
      ( select top 1 AVG(CAST(r.rating AS float)) as AverageRate from Products p
        join Reviews r on r.product_id = p.product_id
        group by p.product_id, p.product_name
        order by AVG(CAST(r.rating AS float)) desc
      )
   
  --Note: same query use twice, second one purpose is to get what is highest rate, and from first query to get the records with 'having' clause 
  --           it might have simpler query to do it.
  
  
-- Problem 6: Retrieve the users who have made at least one order in each category
-- Write an SQL query to retrieve the users who have made at least one order in each category.
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries or joins to solve this problem.
  
  select u.user_id, u.username from Users u
  join Orders o on u.user_id = o.user_id
  join Order_Items oi on oi.order_id = o.order_id
  join Products p on p.product_id = oi.product_id
  group by u.user_id, u.username
  having count(distinct p.category_id) = (select count(1) from  Categories)
  
  --Notes: having count(distinct p.category_id) = (select count(1) from  Categories) will check the count is equal to all the catgary
  
  

-- Problem 7: Retrieve the products that have not received any reviews
-- Write an SQL query to retrieve the products that have not received any reviews.
-- The result should include the product ID and product name.
-- Hint: You may need to use subqueries or left joins to solve this problem.

  select product_id, product_name from Products
  where product_id not in (select product_id from Reviews)

-- Problem 8: Retrieve the users who have made consecutive orders on consecutive days
-- Write an SQL query to retrieve the users who have made consecutive orders on consecutive days.
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries or window functions to solve this problem.

  select distinct u.user_id, u.username from Orders o
  join Orders o2 on o.user_id = o2.user_id
  join Users u on u.user_id = o.user_id
  join (select count(1) as orderCount, user_id, order_date from Orders group by user_id, order_date) as userOrder on userOrder.user_id = o.user_id and userOrder.order_date = o.order_date
  where  DATEDIFF(DAY, o.order_date, o2.order_date) = 1  and userOrder.orderCount = 1
  
  --Note:join Orders itself and compare order_date, DATEDIFF(DAY, o.order_date, o2.order_date) use other sytax on other databases



-- Problem 9: Retrieve the top 3 categories with the highest total sales amount
-- Write an SQL query to retrieve the top 3 categories with the highest total sales amount.
-- The result should include the category ID, category name, and the total sales amount.
-- Hint: You may need to use subqueries, joins, and aggregate functions to solve this problem.

  select top 3 sum(o.total_amount) as TotalAmount, c.category_id,c.category_name 
  from  Orders o
  join Order_Items oi on oi.order_id = o.order_id
  join Products p on p.product_id = oi.product_id
  join Categories c on c.category_id = p.category_id
  group by c.category_id, c.category_name
  order by sum(o.total_amount) desc

-- Problem 10: Retrieve the users who have placed orders for all products in the Toys & Games
-- Write an SQL query to retrieve the users who have placed orders for all products in the Toys & Games
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries, joins, and aggregate functions to solve this problem.
-- category_id 3 is Toys & Games

  select distinct u.user_id, u.username
  from Users u
  join Orders o on o.user_id = u.user_id
  join Order_Items oi on oi.order_id = o.order_id
  join Products p on p.product_id = oi.product_id
  join Categories c on c.category_id = p.category_id
  where c.category_id = 3
  group by u.user_id, u.username
  having count(distinct p.product_id) = (select count(1) from  Products where category_id = 3)

-- Problem 11: Retrieve the products that have the highest price within each category
-- Write an SQL query to retrieve the products that have the highest price within each category.
-- The result should include the product ID, product name, category ID, and price.
-- Hint: You may need to use subqueries, joins, and window functions to solve this problem.
  select min(product_id) as product_id, min(product_name) as product_name, category_id, max(price) as MaxPrice
  from Products 
  group by category_id
  
  --Notes: add min to avoid error: Column 'Products.product_id' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

-- Problem 12: Retrieve the users who have placed orders on consecutive days for at least 3 days
-- Write an SQL query to retrieve the users who have placed orders on consecutive days for at least 3 days.
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries, joins, and window functions to solve this problem.

  select user_id, username, count(order_date) 
  from 
  (
      select distinct u.user_id, u.username, o.order_date from Orders o
      join Orders o2 on o.user_id = o2.user_id
      join Users u on u.user_id = o.user_id
      join (select count(1) as orderCount, user_id, order_date from Orders group by user_id, order_date) as userOrder on userOrder.user_id = o.user_id and userOrder.order_date = o.order_date
      where  DATEDIFF(DAY, o.order_date, o2.order_date) = 1  
  ) as ud
  group by user_id, username
  having count(order_date) >= 2 
  
  
  --Notes: copy query from problem 6 and add order_date, and remove userOrder.orderCount = 1 because orders on consecutive days, not consecutive orders on consecutive days
  --              it will not include the last row that is o2.order_date, so count(order_date) >= 2 is the condition for 3 days.


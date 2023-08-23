/*
		CASE STUDY QUESTIONS
1.What was the total quantity sold for all products? 
2. What is the total generated revenue for all products before discounts? 
3. What was the total discount amount for all products? 
4. How many unique transactions were there? 
5. What are the average unique products purchased in each transaction? 
6. What is the average discount value per transaction? 
7. What is the average revenue for member transactions and non-member transactions? 
8. What are the top 3 products by total revenue before discount? 
9. What are the total quantity, revenue and discount for each segment? 
10. What is the top selling product for each segment? 
11. What are the total quantity, revenue and discount for each category? 
12. What is the top selling product for each category?
*/


-- 1.What was the total quantity sold for all products? 

select product_details.product_name as Name,sum(sales.qty) as total_sales_num from sales 
inner join product_details on product_details.product_id = sales.prod_id
group by Name
order by total_sales_num desc;

-- 2. What is the total generated revenue for all products before discounts? 

select pd.product_name as Name, sum(sales.qty*sales.price) as Total_Revenue from sales
inner join product_details as pd on pd.product_id = sales.prod_id
group by Name 
order by Total_Revenue desc; 

-- 3. What was the total discount amount for all products? 

select pd.product_name as Name_of_Product, sum(sales.qty*sales.discount) as Total_Discount from sales
inner join product_details as pd on pd.product_id=sales.prod_id 
group by Name_of_Product
order by Total_Discount desc ;

-- 4. How many unique transactions were there? 

select count(distinct sales.txn_id) as Unique_Trans from sales ;

-- 5. What are the average unique products purchased in each transaction? 

WITH total_products AS (
	SELECT
		txn_id,
		COUNT(DISTINCT prod_id) AS product_count
	FROM sales
	GROUP BY txn_id
)
SELECT
	ROUND(AVG(product_count)) AS avg_unique_products
FROM total_products;


-- 6. What is the average discount value per transaction?   

with discount_per as (
	select txn_id,sum(price*qty*discount)/100 as total_discount 
	from sales 
    group by txn_id
)
select round(avg(total_discount)) as average_discount_val 
from discount_per;

-- 7. What is the average revenue for member transactions and non-member transactions?

with revenue_trans as (
	select txn_id,member,(sum(qty*price)-sum(qty*discount)) as total_revenue
    from sales
    group by member,txn_id 
)
select member,round(avg(total_revenue)) as average_revenue_acc_member 
from revenue_trans
group by member
order by average_revenue_acc_member;
 
 
 -- 8. What are the top 3 products by total revenue before discount? 
 
 select pd.product_name as Product_name,sum(s.qty*s.price) as Revenue 
 from sales as s
 inner join product_details as pd 
 on pd.product_id=s.prod_id
 group by Product_name
 order by Revenue desc
 limit 3;
 
 -- 9. What are the total quantity, revenue and discount for each segment? 
 
 with total_values as(
	select pd.segment_name as Segment,sum(s.qty) as total_quantity, sum(s.qty*s.price) as total_revenue,
    sum(s.qty*s.discount) as total_discount
    from sales s 
    inner join product_details pd 
    on s.prod_id=pd.product_id
    group by pd.segment_name
 )
 select Segment,total_quantity,total_revenue,total_discount 
 from total_values
 group by Segment;
 
-- 10. What is the top selling product for each segment? 

select pd.product_name as Name,pd.segment_name as Segment,sum(s.qty) as selling_value
from sales s 
inner join product_details as pd
on s.prod_id=pd.product_id
group by Name,Segment

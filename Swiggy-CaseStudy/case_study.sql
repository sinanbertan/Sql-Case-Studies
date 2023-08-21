/*
Case Study Questions
Each of the following case study questions can be answered using a single SQL statement:

HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THETOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.
RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARELOCATED IN DIFFERENT CITIES.
FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THANINDIAN CUISINE.
WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENUCATEGORY FOR EACH RESTAURANT?
WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?
WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN INALPHABETICAL ORDER OF RESTAURANT NAME.

*/

# 1. HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
SELECT count(distinct restaurant_name) as rest_name from swiggy
where rating >= 4.5;

# 2. WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
select city,count(distinct restaurant_name) from swiggy 
group by city 
order by count(restaurant_no)  desc 
limit 1;

# 3. HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
select count(distinct restaurant_name) from swiggy 
where restaurant_name like "%PIZZA%";

# 4. WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
select cuisine,count(*) as count_c from swiggy
group by cuisine 
order by count_c desc 
limit 10;

#5. WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
select city,avg(rating) as average_rating 
from swiggy
group by city
order by average_rating desc;

# 6. WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENUCATEGORY FOR EACH RESTAURANT?

select restaurant_name ,menu_category , max(price) as high_price from swiggy 
where menu_category = 'Recommended' 
group by restaurant_name,menu_category;

# 7.FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE.

select distinct restaurant_name , cost_per_person as cost from swiggy 
where cuisine<>"INDIAN" 
order by cost_per_person desc
limit 5;

#8. FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.

select distinct restaurant_name,cost_per_person as cost from swiggy 
where cost_per_person > (select avg(cost_per_person) from swiggy)
order by cost desc ;

# 9.RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARELOCATED IN DIFFERENT CITIES.alter

select distinct e1.restaurant_name,e1.city,e2.city from swiggy as e1 
join swiggy as e2 on e1.restaurant_name=e2.restaurant_name 
and e1.city<>e2.city;

#10. WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?

select distinct restaurant_name, count(item) as total_item from swiggy
where  menu_category = "Main Course"
group by restaurant_name,menu_category
order by total_item desc
limit 5;

# 11.LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN INALPHABETICAL ORDER OF RESTAURANT NAME

select distinct restaurant_name,veg_or_non_veg as totally_veg from swiggy
where veg_or_non_veg in ("Veg")
group by restaurant_name
order by restaurant_name desc;

#12. WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?

select distinct restaurant_name,avg(price) as average_price 
from swiggy 
group by restaurant_name
order by average_price asc 
limit 1;

# 13.WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

select distinct restaurant_name, count(distinct menu_category) as num_cat 
from swiggy
group by restaurant_name
order by num_cat desc
limit 5;

# 14.WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select distinct restaurant_name,(count(case when veg_or_non_veg = "Non-veg" then 1 end)*100 /count(*)) as Perc_Veg 
from swiggy
group by restaurant_name
order by Perc_Veg desc
limit 1 ;













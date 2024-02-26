SELECT * FROM consbeha

--1.How many males and females purchased from the e-commerce website 
-- Who purchased more? Male or Female? 

SELECT count(*)
FROM consbeha 
WHERE "Gender" = 'Male' 

--There are 2652 male customers who purchased from the e-commerce website 

SELECT count(*) 
FROM consbeha 
WHERE "Gender" = 'Female'

--There are 1248 females who purchased from the e-commerce website. 
--The males make a higher number of purchases than the females

-- 2. What were the distinct categories of products 

SELECT DISTINCT "Category" 
FROM consbeha 

--There are four distinct categories of products that consumers purchased
-- They are Accessories, Footwear, Clothing, Outerwear 


--3. What is the maximum and minimum age of the customer who purchased on 
-- e-commerce site

SELECT max("Age")
FROM consbeha

SELECT min("Age")
FROM consbeha

--The maximum age of customer who purchased on e-commerce site was 70
--The minimum age of the customer who purchased on e-commerce site was 18 

--4. Which category attracted the most number of customers? 

SELECT "Category", count(*)
FROM consbeha 
GROUP BY 1
ORDER BY 2 DESC 

--Total number of customers who got clothing is 1737 
--Total number of customers who got footwear is 599 
-- Total number of customers who got outerwear are 324 
-- Total number of customers who got Accessories are 1240 
-- The most number of customers made the clothing purchase (1737)
-- The least purchases made by the customers is outerwear that is 324 

--5. What are the unique locations customers make purchase from? 
-- And How much distinct locations are they buying the products from? 

SELECT DISTINCT "Location"
FROM consbeha 

SELECT COUNT (DISTINCT "Location")
FROM consbeha

--There are 50 unique locations that customers made purchases from 

-- 6. Which location made the most purchases?
-- Which location made the least purchases? 

SELECT "Location",count(*)
FROM consbeha 
GROUP BY "Location"
ORDER BY 2 

-- Montana made the most purchases with 96 customers
-- Kansas and Rhose Island made the least purchases with 63 customers purchasing 

-- 7. What is the average review ratings for various categories? 

SELECT "Category", ROUND(avg("Review_Rating")::numeric, 2)
FROM consbeha 
GROUP BY "Category" 
ORDER BY 2 desc 

--Footwear category attracted the highest average rating of 3.79 
--Clothing category got the least average rating of 3.72 

-- 8. What is the average review for gender? 

SELECT "Gender", ROUND(avg("Review_Rating")::numeric, 2)
FROM consbeha 
GROUP BY "Gender" 
ORDER BY 2 desc 

--Like Category, there is no much difference for the gender
-- Both make and female have almost the same average review rating 


-- 9. Which season experienced the highest quantity of sales from customers? 

SELECT "Season", count(*) 
FROM consbeha 
GROUP BY "Season" 
ORDER BY 2 DESC 

-- Spring attracted the highest quantity of sales with 999 
--Followed by Fall with 975, Winter with 971 and Summer with 955 


--10. Which shipping type was most preferred by the customers? 

SELECT "Shipping_Type",count(*) 
FROM consbeha 
GROUP BY 1
ORDER BY 2 DESC 

-- 675 customers preferred free shipping 
-- 654 preferred Standard delivery 
-- 650 preferred Store pickup
-- Least number of customers picked 2 day shipping that was 627  


--11. Which was the most preferred payment method of customers? 

SELECT "Payment_Method", count(*) 
FROM consbeha 
GROUP BY 1
ORDER BY 2 desc 

-- Paypal was the most preferred payment method of customers with 677 
-- Credit card was the second highest preferred payment method with 671 
-- Cash was the third preferred payment method with 670 
-- The least preferred payment method was Bank transfer that is 612 


--12. Which category obtained the most revenue? 

SELECT "Category", sum("Purchase_Amount_USD") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC 

--The clothing category obtained most revenue. It was 1.04k dollars  
--The category with the least revenue was the outerwear with 18524 
-- Accessories was the category with the second highest revenue 74200 

-- 13. Which season experienced the most revenue? 

SELECT "Season", sum("Purchase_Amount_USD") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC 

-- Fall was the season where the e-commerce website experienced most revenue
-- It was 60008 USD 
-- The Spring and Winter had more than 58600 dollars 

-- 14. From which region did the business obtain the maximum revenue? 

SELECT "Location", sum("Purchase_Amount_USD") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC 

-- Montana was the region from where the business got maximum revenue with 5784 USD
-- The Second is Illinois with 5617 USD 
-- The least is Kansas with 3437 USD 


-- 15. Through which shipping type did the business get more revenue?

SELECT "Shipping_Type", sum("Purchase_Amount_USD") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC  

-- Free shipping was the shipping option that obtained most revenue of 40.7K 
-- Express shipping contributed to the second highest revenue 39K 
-- Next day air obtained the least revenue of 37K 

-- 16. Through which payment type did the business obtain most revenue? 

SELECT "Payment_Method", sum("Purchase_Amount_USD") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC 

-- Credit card obtained the maximum revenue in terms of payment method with 40.3K
-- Paypal was the second highest in terms of payment method for revenues 40.1K
-- Bank transfer obtained the least revenue with 36.5K 


-- 17. What was the frequency of purchases with respect to customers?

SELECT "Frequency_of_Purchases", count(*) 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC 

-- Majority of customers made purchases for every 3 months (584 customers)
-- The second highest was the annual purchases that stood at 572 customers
-- The least was the weekly purchases with 539 customers 


-- 18. What was the revenue for the frequency of purchases?

SELECT "Frequency_of_Purchases", sum("Purchase_Amount_USD") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 DESC 

-- We could see almost same results in terms of revenue 
-- Customers who buy every three months contribute to most revenue 35K
-- Customers who buy contribute to the least revenue that is 31K 


-- 19. Which customer ID had the maximum previous purchases? 

SELECT "Customer_ID", MAX("Previous_Purchases") 
FROM consbeha 
GROUP BY 1 
ORDER BY 2 

-- 77 customers have the maximum previous purchases of 50 
-- 53 customers have the second highest number of previous purchases with 49 
-- 83 customers have purchased only once from the e-commerce website 
-- 72 customers have only purchases twice from the e-commerce website 

-- 20.  What was the revenue from customers and their percentage 
-- for those who subscribed and did not subscribe? 

SELECT "Subscription_Status", SUM("Purchase_Amount_USD")AS total_revenue,
ROUND((SUM("Purchase_Amount_USD")/SUM(SUM("Purchase_Amount_USD"))OVER())*100::numeric,2) AS
Revenue_percentage 
FROM consbeha 
GROUP BY 1 

-- Majority of revenue contribution has come from the customers who have not subscribed
-- 73% of revenue was received from customers who did not hold any subscription 
-- 27% of revenue was received from customers who subscribed to the e-commerce site

-- 21. How many customers subscribed to the website and how many did not subscribe?
-- What was their percentage? 

SELECT 
"Subscription_Status",
count(*)as Subscription_count, 
count(*)*100/(SELECT count(*)from consbeha)as subscription_percentage 
FROM consbeha
GROUP BY 1 

-- The same result applies here
-- 73% of customers who contributed to revenue are not subscribed into the website
-- 27% of customers who contribute to revenue have subscribed.
-- The number of non-subscribing customers are higher than the subscribing ones


-- 22. What is the total and percentage of previous purchases for various
-- payment types? 

SELECT "Payment_Method", SUM("Previous_Purchases")AS total_purchases,
ROUND((SUM("Previous_Purchases")/SUM(SUM("Previous_Purchases"))OVER())*100::numeric,2) AS
Percentages_purchases 
FROM consbeha 
GROUP BY 1 
ORDER BY 3 DESC

-- Paypal payments lead when it comes to previous purchases at 17% 
-- Credit card almost equals the PayPal for payment at 17.3% 
-- The least contribution towards total previous purchases was bank transfer 


-- 23. Average purchase amount of each category 

SELECT "Category", "Purchase_Amount_USD",
ROUND(AVG("Purchase_Amount_USD")OVER(PARTITION BY "Category")::numeric,2) as Average_Purchase_Amount
FROM consbeha 


-- 24. Dense rank of purchase amount for each category 

SELECT  

## Case Study 2: Kultra Mega Stores Inventory## 

CREATE DATABASE KMS_Sql_Case_Study;
USE KMS_Sql_Case_Study;
## I imported 2 files as my table; KMS_Sales and Order_Status into the Database(KMS_Sql_Case_Study)  ##
SELECT * FROM KMS_Sales;
SELECT * FROM Order_status;

## ANSWERS ###
###1. Product category thehighest sales?###
SELECT product_category, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY product_category
ORDER BY total_sales DESC
LIMIT 1;

###2.Top 3 and Bottom 3 regions in terms of sales###
-- Top 3 Regions
SELECT region, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY region
ORDER BY total_sales DESC
LIMIT 3;

-- Bottom 3 Regions
SELECT region, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY region
ORDER BY total_sales ASC
LIMIT 3;

###3.Total sales of appliances in Ontario###
SELECT SUM(sales) AS total_sales
FROM kms_sales
WHERE 'product_sub-category' = 'Appliances' AND province = 'Ontario';

###4. Advise on increasing revenue from bottom 10 customers##
-- Bottom 10 customers by sales
SELECT customer_name, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY customer_name
ORDER BY total_sales ASC
LIMIT 10;
##Advice: Management through the sales department Should target these customers with personalized promotions, 
## or loyalty rewards to boost their purchase volume.

###5.Shipping method with highest total shipping cost##
SELECT ship_mode, 
ROUND (SUM(shipping_cost), 2) AS total_shipping_cost
FROM kms_sales
GROUP BY ship_mode
ORDER BY total_shipping_cost DESC
LIMIT 1;

###6. Most valuable customers and what they buy###
-- Top customers by sales and what they purchase
SELECT customer_name, 
ROUND (SUM(sales), 2) AS total_sales, GROUP_CONCAT(DISTINCT product_category) AS categories
FROM kms_sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

###7. Small business customer with highest sales###
SELECT customer_name, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
WHERE customer_segment = 'Small Business'
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 1;

###8. Corporate customer with most orders from 2009–2012###
SELECT customer_name, COUNT(order_id) AS order_count
FROM kms_sales
WHERE customer_segment = 'Corporate'
  AND YEAR(order_date) BETWEEN 2009 AND 2012
GROUP BY customer_name
ORDER BY order_count DESC
LIMIT 1;

###9. Most profitable consumer customer##
SELECT customer_name, 
ROUND (SUM(profit), 2) AS total_profit
FROM kms_sales
WHERE customer_segment = 'Consumer'
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 1;

###10. Customer who returned items and their segment###
SELECT DISTINCT ks.customer_name, ks.customer_segment
FROM kms_sales ks
JOIN Order_Status os ON ks.order_id = os.order_id
WHERE os.status = 'Returned';

###11. Was shipping cost aligned with order priority?##
SELECT order_priority, ship_mode, 
ROUND (AVG(shipping_cost), 2) AS avg_shipping_cost,
COUNT(*) AS orders
FROM kms_sales
GROUP BY order_priority, ship_mode
ORDER BY order_priority, avg_shipping_cost;

#RESPONSE: No, the company did not appropriately allocate shipping costs based on Order Priority.
#Delivery Truck, the cheapest and slowest method, is used significantly even for Critical and High orders, which contradicts priority urgency.
#Express Air, the fastest and most expensive, is used noticeably for Low and Medium priority orders, which may be an unnecessary cost.
#Regular Air, the middle ground, is heavily used across all categories, but the balance is not optimized with priority levels.
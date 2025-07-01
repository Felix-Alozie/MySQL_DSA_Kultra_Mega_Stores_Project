# MySQL_DSA_Kultra_Mega_Stores_Project
## DSA Final Project on MySQL
## Project Overview
This project presents an in-depth business intelligence analysis for **Kultra Mega Stores (KMS)**, a Lagos-based retail company that specializes in office supplies and furniture. The analysis focuses on the performance of the **Abuja division** between **2009 and 2012**, using order-level data to derive actionable insights that inform strategic decisions across customer segments, product categories, and sales regions.

As a Business Intelligence Analyst, I used structured query language (SQL) to extract, manipulate, and analyze the data with a focus on performance indicators such as sales, profitability, customer value, and shipping cost efficiency.

## Data Source

The dataset was obtained from the [DSA Learning Management System (LMS) Canvas platform](https://canvas.instructure.com/courses/11955369/files/302722474?wrap=1) as part of the final capstone project for the Data Analysis track.

- **File Format:** Excel (.csv)
- **Data Period:** 2009–2012
- **Data Scope:** Orders, customers, products, shipping methods, and sales regions

## Tools Used
- **MySQL:** For data cleaning, querying, and advanced analysis
- **Microsoft Excel:** For initial data exploration and validation
- **MySQL Workbench:** SQL development environment
- **Git & GitHub:** project presentation

## Exploratory Data Analysis
Key questions addressed and summarized insights include:
```SQL
CREATE DATABASE KMS_Sql_Case_Study;
USE KMS_Sql_Case_Study;
## I imported 2 files as my tables; KMS_Sales and Order_Status into the Database(KMS_Sql_Case_Study)  ##
SELECT * FROM KMS_Sales;
SELECT * FROM Order_status;
```

### 🔹 Case Scenario I:

1. **Highest Selling Product Category**
   - `Technology` recorded the highest total sales volume across all years.
```SQL
SELECT product_category, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY product_category
ORDER BY total_sales DESC
LIMIT 1;
```
2. **Top 3 and Bottom 3 Regions by Sales**
   - **Top 3 Regions:** West, Ontario, prarie
   - **Bottom 3 Regions:** Nunavut, Northwest Territories Yukon
```SQL
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
```

3. **Total Sales of Appliances in Ontario**
   - Total sales of appliances in Ontario amounted = NULL.
```SQL
SELECT SUM(sales) AS total_sales
FROM kms_sales
WHERE 'product_sub-category' = 'Appliances' AND province = 'Ontario';
```
**Recommendations for Bottom 10 Customers**
   - Focus on personalized promotions, credit discounts, and follow-ups to boost loyalty and increase order frequency.
   - Segment them into a loyalty program for periodic targeted campaigns.
```SQL
-- Bottom 10 customers by sales
SELECT customer_name, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY customer_name
ORDER BY total_sales ASC
LIMIT 10;
```

5. **Most Costly Shipping Method**
   - **Delivery Truck** incurred the highest shipping costs. 
```SQL
SELECT ship_mode, 
ROUND (SUM(shipping_cost), 2) AS total_shipping_cost
FROM kms_sales
GROUP BY ship_mode
ORDER BY total_shipping_cost DESC
LIMIT 1;
```
### 🔹 Case Scenario II:

6. **Most Valuable Customers**
```SQL
-- Top customers by sales and what they purchase
SELECT customer_name, 
ROUND (SUM(sales), 2) AS total_sales, GROUP_CONCAT(DISTINCT product_category) AS categories
FROM kms_sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
```

7. **Highest Sales from a Small Business**
 - **Dannis Kane.** recorded the highest sales in the small business category.
```SQL
SELECT customer_name, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
WHERE customer_segment = 'Small Business'
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 1;
```

8. **Corporate Customer with Most Orders (2009–2012)**
   - **Roy Skaria.** placed the highest number of orders over the 4-year period.
```SQL
SELECT customer_name, COUNT(order_id) AS order_count
FROM kms_sales
WHERE customer_segment = 'Corporate'
  AND YEAR(order_date) BETWEEN 2009 AND 2012
GROUP BY customer_name
ORDER BY order_count DESC
LIMIT 1;
```

9. **Most Profitable Consumer Customer**
   - **Emily Phan** was the most profitable in the consumer segment, frequently purchasing high-margin items.
```SQL
SELECT customer_name, 
ROUND (SUM(profit), 2) AS total_profit
FROM kms_sales
WHERE customer_segment = 'Consumer'
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 1;
```

10. **Customer Returns & Segment**
   - Returns were most common among **consumer customers**
```SQL
SELECT DISTINCT ks.customer_name, ks.customer_segment
FROM kms_sales ks
JOIN Order_Status os ON ks.order_id = os.order_id
WHERE os.status = 'Returned';
```

11. **Shipping Cost vs. Order Priority**
   
```SQL
SELECT order_priority, ship_mode, 
ROUND (AVG(shipping_cost), 2) AS avg_shipping_cost,
COUNT(*) AS orders
FROM kms_sales
GROUP BY order_priority, ship_mode
ORDER BY order_priority, avg_shipping_cost;
```
**RESPONSE**: No, the company did not appropriately allocate shipping costs based on Order Priority.
   - **Delivery Truck**, the cheapest and slowest method, is used significantly even for Critical and High orders, which contradicts priority urgency.
   - **Express Air**, the fastest and most expensive, is used noticeably for Low and Medium priority orders, which may be an unnecessary cost.
   - **Regular Air**, the middle ground, is heavily used across all categories, but the balance is not optimized with priority levels.





     





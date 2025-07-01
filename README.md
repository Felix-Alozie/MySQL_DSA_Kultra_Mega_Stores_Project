# MySQL_DSA_Kultra_Mega_Stores_Project
## DSA Final Project on MySQL
## 📝 Project Overview
This project presents an in-depth business intelligence analysis for **Kultra Mega Stores (KMS)**, a Lagos-based retail company that specializes in office supplies and furniture. The analysis focuses on the performance of the **Abuja division** between **2009 and 2012**, using order-level data to derive actionable insights that inform strategic decisions across customer segments, product categories, and sales regions.

As a Business Intelligence Analyst, I used structured query language (SQL) to extract, manipulate, and analyze the data with a focus on performance indicators such as sales, profitability, customer value, and shipping cost efficiency.

## 📚 Data Source

The dataset was obtained from the [DSA Learning Management System (LMS) Canvas platform](https://canvas.instructure.com/courses/11955369/files/302722474?wrap=1) as part of the final capstone project for the Data Analysis track.

- **File Format:** Excel (.csv)
- **Data Period:** 2009–2012
- **Data Scope:** Orders, customers, products, shipping methods, and sales regions

## 🛠️ Tools Used
- **MySQL:** For data cleaning, querying, and advanced analysis
- **Microsoft Excel:** For initial data exploration and validation
- **MySQL Workbench:** SQL development environment
- **Git & GitHub:** project presentation

## 🔍 Exploratory Data Analysis

Key questions addressed and summarized insights include:
### 🔹 Case Scenario I:

1. **Highest Selling Product Category**
   - `Office Supplies` recorded the highest total sales volume across all years.

--- SQL
SELECT product_category, 
ROUND (SUM(sales), 2) AS total_sales
FROM kms_sales
GROUP BY product_category
ORDER BY total_sales DESC
LIMIT 1;
---



E‑Commerce Sales Analysis Dashboard
📖 Overview
This project analyzes the Olist Brazilian E‑Commerce dataset to uncover insights about sales, customers, products, payments, reviews, and delivery performance. The goal is to build a data‑driven dashboard that helps understand customer behavior and operational efficiency in an online retail environment.

📂 Repository Structure
Folder	Description
dataset/	Contains all CSV files used for analysis (orders, payments, reviews, products, sellers, customers, geolocation).
dashboard/	Includes Tableau/Power BI dashboards and visualizations.
Project file/	Contains project documentation, scripts, and presentation files (e.g., Project Bootcamp.pptx).


📊 Dataset Description
The Olist dataset consists of 9 CSV files representing different entities in the e‑commerce ecosystem:

olist_orders_dataset – Order details and timestamps

olist_order_items_dataset – Items per order (linked via order_id)

olist_order_payments_dataset – Payment methods and values

olist_order_reviews_dataset – Customer reviews and scores

olist_order_customer_dataset – Customer information

olist_products_dataset – Product details and categories

olist_sellers_dataset – Seller location and identifiers

olist_geolocation_dataset – Zip‑code‑based location mapping

product_category_name_translation – Translates product categories from Portuguese to English

🔗 Data Relationships
The datasets are connected through key fields such as:

order_id → links orders, payments, reviews, and items

product_id → connects items to products

seller_id → connects items to sellers

customer_id → connects orders to customers

zip_code_prefix → connects customers and sellers to geolocation data

(Refer to the schema diagram for visual relationships.)

📈 Key Performance Indicators (KPIs)
From the Project Bootcamp Program, the following KPIs were analyzed:

Weekday vs. Weekend payment statistics (order_purchase_timestamp)

Number of orders with review score = 5 and payment type = credit card

Average delivery days for pet_shop category

Average price and payment values for customers in São Paulo city

Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) and review scores

🧠 Tools & Technologies
Python / SQL – Data cleaning and transformation

Tableau / Power BI – Dashboard creation and visualization

Excel – Exploratory analysis and KPI calculations

🚀 Insights & Outcomes
Identified top‑performing product categories and cities

Analyzed delivery performance and customer satisfaction

Explored payment trends and review correlations

📬 Author
Khushi Mehra  
Data Analyst | Technical Consultant Aspirant
📧 Contact via GitHub

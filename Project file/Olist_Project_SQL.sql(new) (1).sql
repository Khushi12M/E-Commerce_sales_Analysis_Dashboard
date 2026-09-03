CREATE DATABASE olist_project;
USE olist_project;
SELECT COUNT(*) FROM customers;
DESCRIBE customers;
truncate table customers;
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
USE olist_project;
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
USE olist_project;

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_geolocation_dataset.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM geolocation;
USE olist_project;

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM order_items;
USE olist_project;

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM order_payments;
USE olist_project;

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM order_reviews;
USE olist_project;

CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM orders;
USE olist_project;

CREATE TABLE products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM products;
USE olist_project;

CREATE TABLE sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM sellers;
USE olist_project;

CREATE TABLE category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);
LOAD DATA LOCAL INFILE 'C:/Users/Suresh Choudhary/OneDrive/Desktop/product_category_name_translation.csv'
INTO TABLE category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM category_translation;
SELECT *
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;
SELECT *
FROM orders o
JOIN order_payments p
ON o.order_id = p.order_id;
SELECT *
FROM orders o
JOIN order_reviews r
ON o.order_id = r.order_id;
SELECT *
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name;
SELECT *
FROM order_items oi
JOIN sellers s
ON oi.seller_id = s.seller_id;
USE olist_project;

SHOW TABLES;
# What are the payment statistics for orders placed on weekdays versus weekends based on the order_purchase_timestamp?
SELECT
    CASE
        WHEN DAYOFWEEK(o.order_purchase_timestamp) IN (1, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS total_payment,
    ROUND(
        SUM(p.payment_value) * 100 /
        SUM(SUM(p.payment_value)) OVER (),
        2
    ) AS payment_percentage
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
GROUP BY day_type
ORDER BY day_type;
# What is the number of orders that have a review score of 5 and payment type as credit card?
SELECT COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
JOIN order_payments p
    ON o.order_id = p.order_id
WHERE r.review_score = 5
  AND p.payment_type = 'credit_card';
  
  # What is the average number of days taken for order delivery for the pet_shop product category?
  SELECT
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name = 'pet_shop'
  AND o.order_delivered_customer_date IS NOT NULL;
  
  # What are the average price and average payment values for customers from São Paulo city?
  SELECT
    ROUND(AVG(oi.price), 2) AS average_price,
    ROUND(AVG(op.payment_value), 2) AS average_payment_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE LOWER(c.customer_city) = 'sao paulo';

#What is the relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) and review scores?
SELECT
    r.review_score,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS average_shipping_days
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score;

# What are the top 10 product categories based on total sales amount?
SELECT
    ct.product_category_name_english AS product_category,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_sales DESC
LIMIT 10;

# Who are the top 10 sellers based on total sales revenue?
SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY
    s.seller_id,
    s.seller_city,
    s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;
  
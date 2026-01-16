-- Create database
CREATE DATABASE ecommerce_sales_analysis;

-- Use database
USE ecommerce_sales_analysis;

-- Join delivered order data across key tables
SELECT 
    o.order_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    oi.product_id,
    oi.price,
    oi.freight_value,
    p.product_category_name,
    t.product_category_name_english,
    r.review_score
INTO dbo.sales_analysis
FROM dbo.olist_orders_dataset o
INNER JOIN dbo.olist_customers_dataset c 
    ON o.customer_id = c.customer_id
INNER JOIN dbo.olist_order_items_dataset oi 
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset p 
    ON oi.product_id = p.product_id
LEFT JOIN dbo.product_category_name_translation t 
    ON p.product_category_name = t.product_category_name
LEFT JOIN dbo.olist_order_reviews_dataset r 
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';
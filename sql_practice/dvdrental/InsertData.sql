-- =====================================================
-- SHOPIFY DATA INTERNSHIP PRACTICE DATASETS
-- =====================================================
-- This script creates realistic e-commerce datasets for interview practice
-- Run this in PostgreSQL to set up your practice environment

-- =====================================================
-- DATASET 1: E-COMMERCE STORE DATA (Primary Practice Set)
-- =====================================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- Create Categories Table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category_id INTEGER REFERENCES categories(category_id),
    cost_price DECIMAL(10,2) NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    country VARCHAR(50),
    city VARCHAR(100),
    registration_date DATE NOT NULL,
    customer_segment VARCHAR(50) DEFAULT 'regular',
    total_orders INTEGER DEFAULT 0,
    total_spent DECIMAL(10,2) DEFAULT 0.00
);

-- Create Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date TIMESTAMP NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    shipping_cost DECIMAL(10,2) DEFAULT 0.00,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'pending',
    payment_method VARCHAR(50),
    shipping_country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Order Items Table
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00
);

-- =====================================================
-- INSERT SAMPLE DATA
-- =====================================================

-- Insert Categories
INSERT INTO categories (category_name) VALUES 
('Electronics'),
('Clothing'),
('Home & Garden'),
('Books'),
('Sports & Outdoors'),
('Beauty & Personal Care'),
('Toys & Games'),
('Automotive');

-- Insert Products (80 products across categories)
INSERT INTO products (product_name, category_id, cost_price, list_price, stock_quantity) VALUES 
-- Electronics (category_id = 1)
('iPhone 14 Pro', 1, 699.00, 999.00, 45),
('MacBook Air M2', 1, 899.00, 1199.00, 23),
('AirPods Pro', 1, 179.00, 249.00, 156),
('Samsung Galaxy S23', 1, 599.00, 799.00, 67),
('iPad Air', 1, 449.00, 599.00, 34),
('Sony WH-1000XM4', 1, 249.00, 349.00, 89),
('Dell XPS 13', 1, 799.00, 1099.00, 12),
('Nintendo Switch', 1, 199.00, 299.00, 78),
('Kindle Paperwhite', 1, 89.00, 139.00, 234),
('Apple Watch Series 8', 1, 299.00, 399.00, 56),

-- Clothing (category_id = 2)
('Levi''s 501 Jeans', 2, 39.00, 69.00, 145),
('Nike Air Force 1', 2, 59.00, 90.00, 234),
('Adidas Hoodie', 2, 29.00, 55.00, 167),
('Patagonia Jacket', 2, 119.00, 179.00, 45),
('Ray-Ban Sunglasses', 2, 89.00, 150.00, 78),
('Converse Chuck Taylor', 2, 35.00, 55.00, 189),
('North Face Backpack', 2, 69.00, 99.00, 123),
('Uniqlo T-Shirt', 2, 9.00, 19.00, 456),
('Zara Dress', 2, 25.00, 49.00, 234),
('H&M Sweater', 2, 15.00, 29.00, 345),

-- Home & Garden (category_id = 3)
('KitchenAid Mixer', 3, 199.00, 299.00, 23),
('Dyson V15 Vacuum', 3, 449.00, 649.00, 34),
('Instant Pot', 3, 59.00, 89.00, 145),
('Nespresso Machine', 3, 129.00, 199.00, 67),
('Shark Robot Vacuum', 3, 179.00, 249.00, 45),
('Philips Air Fryer', 3, 89.00, 129.00, 89),
('IKEA Desk Lamp', 3, 12.00, 24.00, 234),
('Amazon Echo Dot', 3, 29.00, 49.00, 345),
('Ring Doorbell', 3, 69.00, 99.00, 123),
('Nest Thermostat', 3, 179.00, 249.00, 56),

-- Books (category_id = 4)
('The Seven Husbands of Evelyn Hugo', 4, 8.00, 16.00, 456),
('Atomic Habits', 4, 9.00, 18.00, 234),
('Where the Crawdads Sing', 4, 8.00, 15.00, 345),
('The Silent Patient', 4, 9.00, 17.00, 234),
('Educated', 4, 10.00, 18.00, 189),
('Becoming', 4, 12.00, 20.00, 167),
('The Midnight Library', 4, 8.00, 16.00, 234),
('Dune', 4, 9.00, 18.00, 145),
('The Alchemist', 4, 7.00, 15.00, 345),
('1984', 4, 6.00, 13.00, 234),

-- Sports & Outdoors (category_id = 5)
('Yeti Water Bottle', 5, 19.00, 35.00, 234),
('Patagonia Hiking Boots', 5, 89.00, 149.00, 67),
('REI Camping Tent', 5, 199.00, 299.00, 23),
('Fitbit Charge 5', 5, 119.00, 179.00, 89),
('Wilson Tennis Racket', 5, 79.00, 129.00, 45),
('Spalding Basketball', 5, 15.00, 29.00, 156),
('Coleman Sleeping Bag', 5, 39.00, 69.00, 78),
('GoPro Hero 11', 5, 299.00, 399.00, 34),
('Hydro Flask', 5, 23.00, 39.00, 234),
('Garmin GPS Watch', 5, 199.00, 299.00, 45),

-- Beauty & Personal Care (category_id = 6)
('Fenty Beauty Foundation', 6, 19.00, 36.00, 234),
('Cetaphil Cleanser', 6, 8.00, 15.00, 345),
('The Ordinary Serum', 6, 4.00, 8.00, 456),
('Olaplex Hair Treatment', 6, 16.00, 28.00, 189),
('Glossier Cloud Paint', 6, 12.00, 22.00, 167),
('Drunk Elephant Moisturizer', 6, 35.00, 68.00, 89),
('Charlotte Tilbury Lipstick', 6, 21.00, 37.00, 123),
('La Mer Face Cream', 6, 189.00, 345.00, 12),
('Sephora Makeup Brush Set', 6, 29.00, 55.00, 145),
('Dyson Hair Dryer', 6, 249.00, 399.00, 23),

-- Toys & Games (category_id = 7)
('LEGO Creator Set', 7, 39.00, 69.00, 89),
('Monopoly Board Game', 7, 15.00, 29.00, 145),
('Pokemon Cards Booster', 7, 2.50, 4.99, 789),
('Barbie Dreamhouse', 7, 89.00, 149.00, 34),
('Hot Wheels Track Set', 7, 19.00, 34.00, 123),
('Rubik''s Cube', 7, 6.00, 12.00, 234),
('UNO Card Game', 7, 4.00, 8.00, 345),
('Nerf Blaster', 7, 15.00, 29.00, 156),
('Play-Doh Set', 7, 8.00, 16.00, 234),
('Jenga', 7, 6.00, 12.00, 189),

-- Automotive (category_id = 8)
('Car Phone Mount', 8, 8.00, 19.00, 234),
('Dash Cam', 8, 49.00, 89.00, 67),
('Car Air Freshener', 8, 2.00, 5.00, 567),
('Jump Starter', 8, 39.00, 69.00, 45),
('Tire Pressure Gauge', 8, 12.00, 24.00, 123),
('Car Vacuum', 8, 29.00, 55.00, 78),
('Seat Covers', 8, 19.00, 39.00, 145),
('Car Charger', 8, 6.00, 15.00, 345),
('Floor Mats', 8, 15.00, 29.00, 189),
('Car Wax', 8, 9.00, 18.00, 234);

-- Insert Customers (500 customers)
INSERT INTO customers (email, first_name, last_name, country, city, registration_date, customer_segment)
SELECT 
    'customer' || generate_series || '@email.com',
    CASE (random()*20)::INT 
        WHEN 0 THEN 'Emma' WHEN 1 THEN 'Liam' WHEN 2 THEN 'Olivia' WHEN 3 THEN 'Noah'
        WHEN 4 THEN 'Ava' WHEN 5 THEN 'Oliver' WHEN 6 THEN 'Sophia' WHEN 7 THEN 'Elijah'
        WHEN 8 THEN 'Charlotte' WHEN 9 THEN 'William' WHEN 10 THEN 'Amelia' WHEN 11 THEN 'James'
        WHEN 12 THEN 'Isabella' WHEN 13 THEN 'Benjamin' WHEN 14 THEN 'Mia' WHEN 15 THEN 'Lucas'
        WHEN 16 THEN 'Harper' WHEN 17 THEN 'Mason' WHEN 18 THEN 'Evelyn' ELSE 'Alex'
    END,
    CASE (random()*20)::INT 
        WHEN 0 THEN 'Smith' WHEN 1 THEN 'Johnson' WHEN 2 THEN 'Williams' WHEN 3 THEN 'Brown'
        WHEN 4 THEN 'Jones' WHEN 5 THEN 'Garcia' WHEN 6 THEN 'Miller' WHEN 7 THEN 'Davis'
        WHEN 8 THEN 'Rodriguez' WHEN 9 THEN 'Martinez' WHEN 10 THEN 'Hernandez' WHEN 11 THEN 'Lopez'
        WHEN 12 THEN 'Gonzalez' WHEN 13 THEN 'Wilson' WHEN 14 THEN 'Anderson' WHEN 15 THEN 'Thomas'
        WHEN 16 THEN 'Taylor' WHEN 17 THEN 'Moore' WHEN 18 THEN 'Jackson' ELSE 'Lee'
    END,
    CASE (random()*10)::INT 
        WHEN 0 THEN 'United States' WHEN 1 THEN 'Canada' WHEN 2 THEN 'United Kingdom'
        WHEN 3 THEN 'Australia' WHEN 4 THEN 'Germany' WHEN 5 THEN 'France'
        WHEN 6 THEN 'Japan' WHEN 7 THEN 'Brazil' WHEN 8 THEN 'India' ELSE 'Mexico'
    END,
    CASE (random()*10)::INT 
        WHEN 0 THEN 'New York' WHEN 1 THEN 'Los Angeles' WHEN 2 THEN 'Chicago'
        WHEN 3 THEN 'Toronto' WHEN 4 THEN 'London' WHEN 5 THEN 'Berlin'
        WHEN 6 THEN 'Paris' WHEN 7 THEN 'Tokyo' WHEN 8 THEN 'Sydney' ELSE 'Mexico City'
    END,
    CURRENT_DATE - INTERVAL '1 day' * (random() * 730)::INT, -- Random date within last 2 years
    CASE 
        WHEN random() < 0.6 THEN 'regular'
        WHEN random() < 0.85 THEN 'premium'
        ELSE 'vip'
    END
FROM generate_series(1, 500);

-- Insert Orders (2000 orders with realistic patterns)
INSERT INTO orders (customer_id, order_date, total_amount, discount_amount, shipping_cost, tax_amount, status, payment_method, shipping_country)
SELECT 
    (random() * 499 + 1)::INT, -- Random customer_id between 1-500
    -- Create realistic date distribution (more recent orders)
    CASE 
        WHEN random() < 0.4 THEN CURRENT_DATE - INTERVAL '1 day' * (random() * 30)::INT  -- 40% in last 30 days
        WHEN random() < 0.7 THEN CURRENT_DATE - INTERVAL '1 day' * (30 + random() * 60)::INT  -- 30% in 30-90 days ago
        ELSE CURRENT_DATE - INTERVAL '1 day' * (90 + random() * 640)::INT  -- 30% older than 90 days
    END + INTERVAL '1 second' * (random() * 86400)::INT, -- Add random time
    -- Total amount (will be updated later based on order items)
    0.00,
    -- Discount amount (some orders have discounts)
    CASE WHEN random() < 0.3 THEN (random() * 50)::DECIMAL(10,2) ELSE 0.00 END,
    -- Shipping cost
    CASE 
        WHEN random() < 0.2 THEN 0.00  -- Free shipping
        ELSE (5 + random() * 20)::DECIMAL(10,2)
    END,
    0.00, -- Tax (will calculate later)
    -- Status
    CASE 
        WHEN random() < 0.85 THEN 'completed'
        WHEN random() < 0.95 THEN 'shipped'
        WHEN random() < 0.98 THEN 'processing'
        ELSE 'cancelled'
    END,
    -- Payment method
    CASE (random() * 5)::INT
        WHEN 0 THEN 'credit_card'
        WHEN 1 THEN 'paypal'
        WHEN 2 THEN 'debit_card'
        WHEN 3 THEN 'apple_pay'
        ELSE 'google_pay'
    END,
    -- Shipping country
    CASE (random()*10)::INT 
        WHEN 0 THEN 'United States' WHEN 1 THEN 'Canada' WHEN 2 THEN 'United Kingdom'
        WHEN 3 THEN 'Australia' WHEN 4 THEN 'Germany' WHEN 5 THEN 'France'
        WHEN 6 THEN 'Japan' WHEN 7 THEN 'Brazil' WHEN 8 THEN 'India' ELSE 'Mexico'
    END
FROM generate_series(1, 2000);

-- Insert Order Items (3000+ items across the orders)
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount)
SELECT 
    order_id,
    (random() * 79 + 1)::INT, -- Random product_id between 1-80
    CASE 
        WHEN random() < 0.7 THEN 1  -- 70% single item
        WHEN random() < 0.9 THEN 2  -- 20% two items
        ELSE (random() * 3 + 3)::INT  -- 10% 3-5 items
    END,
    -- Unit price with some variation from list price
    p.list_price * (0.8 + random() * 0.4), -- Price between 80%-120% of list price
    -- Occasional item-level discounts
    CASE WHEN random() < 0.1 THEN (random() * 10)::DECIMAL(10,2) ELSE 0.00 END
FROM (
    -- Generate 1-3 items per order
    SELECT order_id,
           generate_series(1, CASE WHEN random() < 0.6 THEN 1 WHEN random() < 0.9 THEN 2 ELSE 3 END)
    FROM orders
    WHERE status != 'cancelled'
) AS order_expansions
CROSS JOIN LATERAL (
    SELECT list_price FROM products WHERE product_id = (random() * 79 + 1)::INT LIMIT 1
) AS p;

-- Update order totals based on order items
UPDATE orders 
SET total_amount = order_totals.subtotal + shipping_cost,
    tax_amount = order_totals.subtotal * 0.08  -- 8% tax
FROM (
    SELECT 
        oi.order_id,
        SUM((oi.quantity * oi.unit_price) - oi.discount) as subtotal
    FROM order_items oi
    GROUP BY oi.order_id
) as order_totals
WHERE orders.order_id = order_totals.order_id;

-- Update final total_amount to include tax
UPDATE orders 
SET total_amount = total_amount + tax_amount - discount_amount;

-- Update customer totals
UPDATE customers 
SET total_orders = customer_stats.order_count,
    total_spent = customer_stats.total_spent
FROM (
    SELECT 
        customer_id,
        COUNT(*) as order_count,
        SUM(total_amount) as total_spent
    FROM orders 
    WHERE status = 'completed'
    GROUP BY customer_id
) as customer_stats
WHERE customers.customer_id = customer_stats.customer_id;

-- =====================================================
-- CREATE INDEXES for better performance
-- =====================================================
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_customers_country ON customers(country);
CREATE INDEX idx_customers_registration_date ON customers(registration_date);

-- =====================================================
-- DATASET 2: ADDITIONAL TABLES FOR ADVANCED ANALYSIS
-- =====================================================

-- Website Analytics Table
CREATE TABLE website_sessions (
    session_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    session_date TIMESTAMP NOT NULL,
    page_views INTEGER DEFAULT 1,
    session_duration INTEGER, -- in seconds
    traffic_source VARCHAR(50), -- organic, paid_search, social, direct, email
    device_type VARCHAR(20), -- desktop, mobile, tablet
    converted BOOLEAN DEFAULT FALSE,
    order_id INTEGER REFERENCES orders(order_id)
);

-- Insert website session data
INSERT INTO website_sessions (customer_id, session_date, page_views, session_duration, traffic_source, device_type, converted, order_id)
SELECT 
    CASE WHEN random() < 0.7 THEN (random() * 499 + 1)::INT ELSE NULL END, -- 30% anonymous sessions
    CURRENT_DATE - INTERVAL '1 day' * (random() * 180)::INT + INTERVAL '1 second' * (random() * 86400)::INT,
    (1 + (random() * 15))::INT, -- 1-15 page views
    (30 + random() * 1800)::INT, -- 30 seconds to 30 minutes
    CASE (random() * 5)::INT
        WHEN 0 THEN 'organic'
        WHEN 1 THEN 'paid_search'
        WHEN 2 THEN 'social'
        WHEN 3 THEN 'direct'
        ELSE 'email'
    END,
    CASE (random() * 3)::INT
        WHEN 0 THEN 'desktop'
        WHEN 1 THEN 'mobile'
        ELSE 'tablet'
    END,
    random() < 0.03, -- 3% conversion rate
    NULL -- Will update with order_ids for converted sessions
FROM generate_series(1, 5000);

-- Update some sessions with order conversions
UPDATE website_sessions 
SET order_id = o.order_id,
    converted = TRUE
FROM (
    SELECT DISTINCT ON (customer_id) 
        order_id, customer_id, order_date
    FROM orders 
    WHERE status = 'completed' 
    ORDER BY customer_id, order_date DESC
) o
WHERE website_sessions.customer_id = o.customer_id 
  AND website_sessions.session_date <= o.order_date
  AND website_sessions.session_date >= o.order_date - INTERVAL '7 days'
  AND random() < 0.4; -- 40% chance to link session to order

-- Product Reviews Table
CREATE TABLE product_reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    order_id INTEGER REFERENCES orders(order_id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    review_date DATE NOT NULL,
    helpful_votes INTEGER DEFAULT 0
);

-- Insert product reviews
INSERT INTO product_reviews (product_id, customer_id, order_id, rating, review_date, helpful_votes)
SELECT DISTINCT
    oi.product_id,
    o.customer_id,
    o.order_id,
    -- Rating distribution (weighted toward positive)
    CASE 
        WHEN random() < 0.05 THEN 1  -- 5% 1-star
        WHEN random() < 0.10 THEN 2  -- 5% 2-star  
        WHEN random() < 0.20 THEN 3  -- 10% 3-star
        WHEN random() < 0.50 THEN 4  -- 30% 4-star
        ELSE 5                       -- 50% 5-star
    END,
    o.order_date + INTERVAL '1 day' * (random() * 14)::INT, -- Review 0-14 days after order
    (random() * 25)::INT -- 0-25 helpful votes
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed' 
  AND random() < 0.4; -- 40% of completed orders get reviews

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Summary statistics to verify data looks reasonable
SELECT 'Data Summary' as metric, NULL as value
UNION ALL
SELECT 'Total Customers', COUNT(*)::TEXT FROM customers
UNION ALL
SELECT 'Total Products', COUNT(*)::TEXT FROM products
UNION ALL
SELECT 'Total Orders', COUNT(*)::TEXT FROM orders
UNION ALL
SELECT 'Completed Orders', COUNT(*)::TEXT FROM orders WHERE status = 'completed'
UNION ALL
SELECT 'Total Order Items', COUNT(*)::TEXT FROM order_items
UNION ALL
SELECT 'Total Revenue', '$' || ROUND(SUM(total_amount), 2)::TEXT FROM orders WHERE status = 'completed'
UNION ALL
SELECT 'Avg Order Value', '$' || ROUND(AVG(total_amount), 2)::TEXT FROM orders WHERE status = 'completed'
UNION ALL
SELECT 'Date Range (Orders)', MIN(order_date)::DATE || ' to ' || MAX(order_date)::DATE FROM orders
UNION ALL
SELECT 'Website Sessions', COUNT(*)::TEXT FROM website_sessions
UNION ALL
SELECT 'Product Reviews', COUNT(*)::TEXT FROM product_reviews;

-- =====================================================
-- PRACTICE QUESTIONS TO EXPLORE
-- =====================================================

/*
BEGINNER QUESTIONS:
1. What's the total revenue and number of orders by month?
2. Which are the top 10 products by revenue?
3. What's the distribution of customers by country?
4. What's the average order value by customer segment?

INTERMEDIATE QUESTIONS:
5. Which product categories have the highest profit margins?
6. What's the customer retention rate (customers who made repeat purchases)?
7. How does order value vary by traffic source?
8. What's the seasonal pattern in sales?

ADVANCED QUESTIONS:
9. Create a customer cohort analysis showing retention by month
10. Calculate the correlation between product ratings and sales performance
11. Identify customers at risk of churning (haven't ordered in 90+ days)
12. What's the customer lifetime value by acquisition channel?

BUSINESS QUESTIONS:
13. Which marketing channels drive the highest value customers?
14. What products are frequently bought together?
15. How does shipping cost impact conversion rates?
16. What's the relationship between session duration and purchase probability?
*/
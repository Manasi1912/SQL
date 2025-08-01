DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(50),
	category VARCHAR(50),
	price NUMERIC(10,2),
	quantity INT,
	added_date DATE,
	discount_rate NUMERIC(5,2)
);

INSERT INTO products(product_name, category, price, quantity, added_date, discount_rate)
	VALUES ('Laptop', 'Electronics', 75000.50, 10, '2024-01-15', 10.00),
		('Smartphone', 'Electronics', 45000.99, 25, '2024-02-20', 5.00),
		('Headphones', 'Accessories', 1500.75, 50, '2024-03-05', 15.00),
		('Office Chair', 'Furniture', 5500.00, 20, '2023-12-01', 20.00),
		('Desk', 'Furniture', 8000.00, 15, '2023-11-20', 12.00),
		('Monitor', 'Electronics', 12000.00, 8, '2024-01-10', 8.00),
		('Printer', 'Electronics', 9500.50, 5, '2024-02-01', 7.50),
		('Mouse', 'Accessories', 750.00, 40, '2024-03-18', 10.00),
		('Keyboard', 'Accessories', 1250.00, 35, '2024-03-18', 10.00),
		('Tablet', 'Electronics', 30000.00, 12, '2024-02-28', 5.00);

SELECT * FROM products;

SELECT product_name, quantity,
	CASE 
		WHEN quantity >= 10 THEN 'In Stock'
		WHEN quantity <= 9 AND quantity >= 5 THEN 'Limited Stock'
		ELSE 'Out of Stock'
	END AS Stock_Status
FROM products;

SELECT product_name, category,
	CASE
		WHEN category LIKE 'Electronics' THEN 'Electronics Item'
		WHEN category LIKE 'Accessories' THEN 'Accessory Item'
		WHEN category LIKE 'Furniture' THEN 'Furniture Item'
	  --ELSE 'Furniture Item'
	END AS category_type
FROM products;


ALTER TABLE products
ADD COLUMN discount_price NUMERIC(10, 2);

UPDATE products
SET discount_price = price*0.9  -- 10% discount
WHERE product_name NOT IN ('Laptop', 'Desk')

	
-- Assign unique row numbers to each product within the same category
SELECT product_name, category, price, 
		ROW_NUMBER() OVER(PARTITION BY category ORDER BY price DESC) AS row_num
FROM products;

SELECT product_name, category, price, 
		RANK() OVER(PARTITION BY category ORDER BY price DESC) AS ranking
FROM products;

SELECT product_name, category, price, 
		DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) AS dense_ranking
FROM products;


-- running sum using SUM() of price
SELECT product_name, category, price, 
		SUM(price) OVER(ORDER BY price) AS running_sum
FROM products;
-- partition by category
SELECT product_name, category, price, 
		SUM(price) OVER(PARTITION BY category ORDER BY price) AS running_sum
FROM products;
/* COALESCE FUNCTION */
SELECT product_name, price, discount_price, 
	COALESCE (discount_price, price) AS Final_price
FROM products

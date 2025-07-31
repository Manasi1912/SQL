CREATE DATABASE Design;

CREATE TABLE Customers(
	CustomerID SERIAL PRIMARY KEY,
	FullName VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL
);

CREATE TABLE Products(
	ProductID SERIAL PRIMARY KEY,
	ProductName VARCHAR(100) NOT NULL, 
	Price DECIMAL(10, 2) NOT NULL	
);

CREATE TABLE Orders(
	OrderID SERIAL PRIMARY KEY,
	CustomerID INT,
	OrderDate DATE NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails(
		OrderDetailID SERIAL PRIMARY KEY,
		OrderID INT,
		ProductID INT,
		Quantity INT NOT NULL,
		FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
		FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (FullName, Email)
VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

INSERT INTO Products (ProductName, Price)
VALUES
('Laptop', 999.99),
('Smartphone', 499.99),
('Tablet', 299.99);

INSERT INTO Orders (CustomerID, OrderDate)
VALUES
(1, '2024-09-01'), -- Alice's order
(2, '2024-09-02'); -- Bob's order

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1), -- Alice ordered 1 Laptop
(1, 2, 2), -- Alice ordered 2 Smartphones
(2, 3, 1); -- Bob ordered 1 Tablet

-- 1. INNER JOIN
-- Retrieve all orders along with customer names.
SELECT o.orderid,c.fullname, o.orderdate
FROM Orders o 
INNER JOIN Customers c
ON O.CustomerID = C.CustomerID;

-- 2. LEFT JOIN
-- Retrieve all customers and their orders, including those who haven't placed any orders.
SELECT o.orderid,c.fullname, o.orderdate
FROM Customers c 
LEFT JOIN Orders o
ON O.CustomerID = C.CustomerID;

-- 3. RIGHT JOIN
-- Retrieve all products and the orders they are associated with, including products that have not been ordered.
SELECT P.ProductName, P.ProductID, O.OrderID, O.OrderDate
FROM Products P
RIGHT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
RIGHT JOIN Orders O ON OD.OrderID = O.OrderID;

-- 4. FULL OUTER JOIN
-- Retrieve all customers, orders, and products, including those without a match in any table.
SELECT o.orderid,c.fullname, o.orderdate
FROM Customers c 
FULL OUTER JOIN Orders o ON O.CustomerID = C.CustomerID
FULL OUTER JOIN Orderdetails OD ON O.OrderID = OD.OrderID
FULL OUTER JOIN Products P ON P.ProductID = OD.ProductID;

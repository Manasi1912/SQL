       -- Employee Management System --
	   
/* Objective
The goal of this project is to create a database for an Employee Management System that
manages employee information, departments, and salaries. We will demonstrate how to use
subqueries to retrieve specific data and use functions to manipulate data. */


-- Create Database
CREATE DATABASE EmployeeDB;


-- Create Tables
CREATE TABLE Departments (
	DepartmentID INT PRIMARY KEY IDENTITY(1, 1),
	DepartmentName NVARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
	EmployeeID SERIAL PRIMARY KEY IDENTITY(1, 1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Email NVARCHAR(100) NOT NULL,
	DepartmentID INT,
	Salary DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


-- Insert Data
INSERT INTO Departments (DepartmentName)
VALUES
('Human Resources'),
('IT'),
('Sales'),
('Marketing');

INSERT INTO Employees (FirstName, LastName, Email, DepartmentID, Salary)
VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', 1, 70000.00),
('Bob', 'Smith', 'bob.smith@example.com', 2, 80000.00),
('Charlie', 'Brown', 'charlie.brown@example.com', 3, 60000.00),
('David', 'Wilson', 'david.wilson@example.com', 2, 75000.00),
('Eva', 'Clark', 'eva.clark@example.com', 4, 55000.00);


-- Using Subqueries and Functions
--1. Subquery to Find Employees with Above Average Salary
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

--2. Subquery to List Employees in a Specific Department
SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments 
						WHERE DepartmentName = 'IT');

--3. Using Functions to Format Employee Names
CREATE FUNCTION dbo.GetFullName(@EmployeeID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @FullName NVARCHAR(100);
	SELECT @FullName = FirstName + ' ' + LastName
	FROM Employees
	WHERE EmployeeID = @EmployeeID;

	RETURN @FullName;
END:

--4. Using the Function in a Query
SELECT dbo.GetFullName(EmployeeID) AS FullName, Salary
FROM Employees;


/* Summary of SQL Concepts Used
1. Subqueries:
○ Used to find employees with above-average salaries and to filter employees by
department.
2. Functions:
○ Created a user-defined function to concatenate first and last names, enhancing
query capabilities.*/

/*Conclusion
In this project, we successfully created an EmployeeDB database, defined tables for employees
and departments, and inserted sample data. */

-- ProductMaster Table
CREATE TABLE ProductMaster (
  ProductId INT PRIMARY KEY,
  ProductName VARCHAR(30) NOT NULL
);
 
-- CustomerTransaction Table
CREATE TABLE CustomerTransaction (
  CustomerId INT,
  CustomerName VARCHAR(30) NOT NULL,
  CCPoints INT CHECK (CCPoints >= 20 AND CCPoints <= 67),
  DL VARCHAR(30) UNIQUE,
  ProductId INT REFERENCES ProductMaster(ProductId),
  ShippingDate DATE DEFAULT '2014-07-26'
);
 
-- UniqueKeyTable01 Table
CREATE TABLE UniqueKeyTable01 (
  EmpId INT PRIMARY KEY,
  EmpName VARCHAR(30) NOT NULL,
  DLno VARCHAR(30)
);
 
-- LOCATION Table
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(30)
);
 
-- DEPARTMENT Table
CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(30),
  Location_Id INT FOREIGN KEY REFERENCES LOCATION(Location_ID)
);
 
-- JOB Table
CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(30)
);
 
-- Employee Table
CREATE TABLE Employee (
  Employee_ID INT PRIMARY KEY,
  Employee_Name VARCHAR(30),
  Department_Id INT FOREIGN KEY REFERENCES DEPARTMENT(Department_Id),
  Job_Id INT FOREIGN KEY REFERENCES JOB(Job_ID)
);

-- Inserting values into ProductMaster table
INSERT INTO ProductMaster (ProductId, ProductName)
SELECT 1, 'Product 1'
UNION ALL
SELECT 2, 'Product 2'
UNION ALL
SELECT 3, 'Product 3';
 
-- Inserting values into CustomerTransaction table
INSERT INTO CustomerTransaction (CustomerId, CustomerName, CCPoints, DL, ProductId, ShippingDate)
SELECT 1, 'Customer 1', 25, 'DL001', 1, '2023-07-14'
UNION ALL
SELECT 2, 'Customer 2', 50, 'DL002', 2, '2023-07-15'
UNION ALL
SELECT 3, 'Customer 3', 35, 'DL003', 3, '2023-07-16';
 
-- Inserting values into UniqueKeyTable01 table
INSERT INTO UniqueKeyTable01 (EmpId, EmpName, DLno)
SELECT 1, 'Employee 1', 'DL001'
UNION ALL
SELECT 2, 'Employee 2', 'DL002'
UNION ALL
SELECT 3, 'Employee 3', 'DL003';
 
-- Inserting values into LOCATION table
INSERT INTO LOCATION (Location_ID, City)
SELECT 1, 'City 1'
UNION ALL
SELECT 2, 'City 2'
UNION ALL
SELECT 3, 'City 3';
 
-- Inserting values into DEPARTMENT table
INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
SELECT 1, 'Department 1', 1
UNION ALL
SELECT 2, 'Department 2', 2
UNION ALL
SELECT 3, 'Department 3', 3;
 
-- Inserting values into JOB table
INSERT INTO JOB (Job_ID, Designation)
SELECT 1, 'Job 1'
UNION ALL
SELECT 2, 'Job 2'
UNION ALL
SELECT 3, 'Job 3';
 
-- Inserting values into Employee table
INSERT INTO Employee (Employee_ID, Employee_Name, Department_Id, Job_Id)
SELECT 1, 'Employee 1', 1, 1
UNION ALL
SELECT 2, 'Employee 2', 2, 2
UNION ALL
SELECT 3, 'Employee 3', 3, 3;

-- Example of query optimization using indexes
SELECT *
FROM CustomerTransaction
WHERE CustomerId = 1
AND ProductId = 2; 

-- Example of data analysis query
SELECT CustomerName, COUNT(*) AS TotalTransactions
FROM CustomerTransaction
GROUP BY CustomerName; 

-- Example of data visualization query
SELECT ProductName, SUM(CCPoints) AS TotalPoints
FROM ProductMaster
JOIN CustomerTransaction ON ProductMaster.ProductId = CustomerTransaction.ProductId
GROUP BY ProductName; 

-- List out the distinct jobs in the Sales and Accounting departments
SELECT DISTINCT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');

-- List out all the jobs in the Sales and Accounting departments
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');

-- List out the common jobs in the Research and Accounting departments in ascending order
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id
JOIN DEPARTMENT D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting'
ORDER BY J.Designation ASC;

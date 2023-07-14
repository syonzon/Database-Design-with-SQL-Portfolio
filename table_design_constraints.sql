```sql
-- Create the ProductMaster table
-- This table stores information about products.
CREATE TABLE ProductMaster (
    ProductId INT PRIMARY KEY, -- Primary key column for ProductId
    ProductName VARCHAR(30) NOT NULL -- ProductName column, not allowing null values
);

-- Retrieve all records from the ProductMaster table
SELECT * FROM ProductMaster;

-- Create the CustomerTransaction table
-- This table tracks customer transactions.
CREATE TABLE CustomerTransaction (
    CustomerId INT,
    CustomerName VARCHAR(30) NOT NULL,
    CCPoints INT CHECK (CCPoints >= 20 AND CCPoints <= 67), -- CCPoints column with a check constraint
    DL VARCHAR(30) UNIQUE, -- DL column with a unique constraint
    ProductId INT REFERENCES ProductMaster(ProductId), -- Foreign key referencing ProductMaster(ProductId)
    ShippingDate DATE DEFAULT '2014-07-26' -- ShippingDate column with a default value
);

-- Retrieve all records from the CustomerTransaction table
SELECT * FROM CustomerTransaction;

-- Rename the CustomerTranaction table to CustomerTransaction
EXEC sp_rename 'CustomerTranaction', 'CustomerTransaction';

-- Identifying primary key constraints in the ProductMaster table
SELECT name
FROM sys.key_constraints
WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = 'ProductMaster';

-- Identifying default constraints in the ProductMaster table
SELECT name
FROM sys.default_constraints
WHERE parent_object_id = OBJECT_ID('ProductMaster')
  AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('ProductMaster'), 'ProductId', 'ColumnId');

-- Dropping the primary key constraint in the ProductMaster table
-- This step removes the primary key constraint from the ProductMaster table.
ALTER TABLE ProductMaster
DROP CONSTRAINT PK__ProductM__B40CC6CD6EC925E1;

-- Add Primary Key constraint
-- Alter Table [TABLENAME]
-- Add CONSTRAINT [Primary Key] PRIMARY KEY(Column1, Column2, ...)

-- Adding the Primary key constraint to the ProductMaster table
-- This step adds a primary key constraint to the ProductMaster table on the ProductId column.
ALTER TABLE ProductMaster
ADD CONSTRAINT PK_ProductMaster PRIMARY KEY (ProductId);

-- Dropping the Primary key constraint in the ProductMaster table
-- This step removes the primary key constraint from the ProductMaster table.
ALTER TABLE ProductMaster
DROP CONSTRAINT PK_ProductMaster;

-- Altering the ProductName column to allow NULL values in the ProductMaster table
-- This step modifies the ProductName column in the ProductMaster table to allow NULL values.
ALTER TABLE ProductMaster
ALTER COLUMN ProductName VARCHAR(30) NULL;

-- Dropping the foreign key constraint in the CustomerTransaction table
-- This step removes the foreign key constraint from the CustomerTransaction table.
ALTER TABLE CustomerTransaction
DROP CONSTRAINT FK__CustomerT__Produ__6383C8BA;

-- Add Foreign Key Constraint
-- Alter Table [TABLENAME]
-- Add CONSTRAINT [CONSTRAINTNAME] FOREIGN KEY (Column) REFERENCES Table2 (Column)

-- Adding the foreign key constraint to the CustomerTransaction table
-- This step adds a foreign key constraint to the CustomerTransaction table, referencing the ProductMaster table.
ALTER TABLE CustomerTransaction
ADD CONSTRAINT FK_CustomerTransaction FOREIGN KEY (ProductId) REFERENCES ProductMaster (ProductId);

-- Drop Foreign Key Constraint
-- This step removes the foreign key constraint from the CustomerTransaction table.
ALTER TABLE CustomerTransaction 
DROP CONSTRAINT FK_CustomerTransaction;

-- Create the UniqueKeyTable01 table
-- This table stores unique keys with associated employee information.
CREATE TABLE UniqueKeyTable01 (
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(30) NOT NULL,
    DLno VARCHAR(30)
);

-- Create a unique nonclustered index on DLno column in UniqueKeyTable01
-- This index ensures that the DLno values are unique where DLno is not null.
CREATE UNIQUE NONCLUSTERED INDEX idx_tbl_UniqueKeyTable_DLno
ON UniqueKeyTable01(DLno)
WHERE DLno IS NOT NULL;

-- Insert records into the UniqueKeyTable01 table
INSERT INTO UniqueKeyTable01
VALUES (1, 'Madhav01', NULL),
       (2, 'Madhav02', NULL),
       (3, 'Madhav03', NULL);

-- Retrieve all records from the UniqueKeyTable01 table
SELECT * FROM UniqueKeyTable01;

-- Insert additional records into the UniqueKeyTable01 table
INSERT INTO UniqueKeyTable01
VALUES (4, 'Madhav04', NULL),
       (5, 'Madhav05', NULL);

-- Retrieve all records from the UniqueKeyTable01 table
SELECT * FROM UniqueKeyTable01;

-- CASE STUDY

-- Create the LOCATION table
-- This table stores information about different locations.
CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(30)
);

-- Create the DEPARTMENT table
-- This table stores information about departments with a foreign key reference to the LOCATION table.
CREATE TABLE DEPARTMENT (
    Department_Id INT PRIMARY KEY,
    Name VARCHAR(30),
    Location_Id INT REFERENCES LOCATION(Location_Id)
);

-- Retrieve all records from the LOCATION table
SELECT * FROM LOCATION;

-- Retrieve all records from the DEPARTMENT table
SELECT * FROM DEPARTMENT;

-- Retrieve all records from the JOB table
SELECT * FROM JOB;

-- Retrieve all records from the Employee table
SELECT * FROM Employee;

-- Get column names from the JOB table
-- This query retrieves the column names for the JOB table in the EmployeeDB database.
USE EmployeeDB;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'JOB';

-- SET OPERATORS (CASE STUDY)

-- List out the distinct jobs in the Sales and Accounting departments
-- This query lists the distinct job titles in the Sales and Accounting departments.
SELECT DISTINCT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id_FK
JOIN DEPARTMENT D ON E.Department_Id_FK = D.Department_ID_PK
WHERE D.Name IN ('Sales', 'Accounting');

-- List out all the jobs in the Sales and Accounting departments
-- This query lists all the job titles in the Sales and Accounting departments.
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id_FK
JOIN DEPARTMENT D ON E.Department_Id_FK = D.Department_ID_PK
WHERE D.Name IN ('Sales', 'Accounting');

-- List out the common jobs in the Research and Accounting departments in ascending order
-- This query lists the common job titles in the Research and Accounting departments, sorted in ascending order.
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id_FK
JOIN DEPARTMENT D ON E.Department_Id_FK = D.Department_ID_PK
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id_FK
JOIN DEPARTMENT D ON E.Department_Id_FK = D.Department_ID_PK
WHERE D.Name = 'Accounting'
ORDER BY J.Designation ASC;
```

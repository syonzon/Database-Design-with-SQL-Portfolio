```sql
-- Create the ProductMaster table
create table ProductMaster (
    ProductId Int Primary Key, -- Primary key column for ProductId
    ProductName varchar(30) not null -- ProductName column, not allowing null values
);

-- Retrieve all records from the ProductMaster table
select * from ProductMaster;

-- Create the CustomerTransaction table
create table CustomerTransaction (
    CustomerId int,
    CustomerName varchar(30) not null,
    CCPoints int check(CCPoints >= 20 and CCPoints <= 67), -- CCPoints column with a check constraint
    DL varchar(30) unique, -- DL column with a unique constraint
    ProductId int Foreign key references ProductMaster(ProductId), -- Foreign key referencing ProductMaster(ProductId)
    ShippingDate date default '2014-07-26' -- ShippingDate column with a default value
);

-- Retrieve all records from the CustomerTransaction table
select * from CustomerTransaction;

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
ALTER TABLE ProductMaster
DROP CONSTRAINT PK__ProductM__B40CC6CD6EC925E1;

-- Add Primary Key constraint
-- Alter Table [TABLENAME]
-- add constraint [Primary Key] Primary key(Column1,Column2,.....)

-- Adding the Primary key constraint to the ProductMaster table
ALTER TABLE ProductMaster
ADD CONSTRAINT PK_ProductMaster PRIMARY KEY (ProductId);

-- Dropping the Primary key constraint in the ProductMaster table
ALTER TABLE ProductMaster
DROP CONSTRAINT PK_ProductMaster;

-- Altering the ProductName column to allow NULL values in the ProductMaster table
ALTER TABLE ProductMaster
ALTER COLUMN ProductName VARCHAR(30) NULL;

-- Dropping the foreign key constraint in the CustomerTransaction table
ALTER TABLE CustomerTransaction
DROP CONSTRAINT FK__CustomerT__Produ__6383C8BA;

-- Add Foreign Key Constraint
-- Alter Table [TABLENAME]
-- Add Constraint [CONSTRAINTNAME] Foreign Key (Column) References Table2 (Column)

-- Adding the foreign key constraint to the CustomerTransaction table
ALTER TABLE CustomerTransaction
ADD CONSTRAINT FK_CustomerTransaction Foreign Key (ProductId) References ProductMaster (ProductId);

-- Drop Foreign Key Constraint
ALTER TABLE CustomerTransaction 
DROP CONSTRAINT FK_CustomerTransaction;

-- Create the UniqueKeyTable01 table
create table UniqueKeyTable01 (
    EmpId int Primary Key,
    EmpName varchar(30) not null,
    DLno varchar(30)
);

-- Create a unique nonclustered index on DLno column
Create unique nonclustered index idx_tbl_UniqueKeyTable_DLno
On UniqueKeyTable01(DLno)
where DLno is not null;

-- Insert records into UniqueKeyTable01
insert into UniqueKeyTable01
values (1, 'Madhav01', null);

insert into UniqueKeyTable01
values (2, 'Madhav02', null);

insert into UniqueKeyTable01
values (3, 'Madhav03', null);

-- Retrieve all records from UniqueKeyTable01
select * from UniqueKeyTable01;

insert into UniqueKeyTable01
values (4, 'Madhav04', null);

insert into UniqueKeyTable01
values (5, 'Madhav05', null);

-- Retrieve all records from UniqueKeyTable01
select * from UniqueKeyTable01;

-- CASE STUDY
-- Create the LOCATION table
create table LOCATION (
    Location_ID int Primary Key,
    City varchar(30)
);

-- Create the DEPARTMENT table
Create table DEPARTMENT(
    Department_Id int Primary Key,
    Name varchar(30),
    Location_Id int Foreign Key references LOCATION (Location_Id)
);

-- Retrieve all records from the LOCATION table
select * from LOCATION;

-- Retrieve all records from the DEPARTMENT table
select * from DEPARTMENT;

-- Retrieve all records from the JOB table
select * from JOB;

-- Retrieve all records from the Employee table
select * from Employee;

-- Get column names from the EmployeeDB database
USE EmployeeDB;
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'JOB';

-- SET OPERATORS (CASE STUDY)
-- 1. LIST OUT THE DISTINCT JOBS IN SALES AND ACCOUNTING DEPARTMENTS.
SELECT DISTINCT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id_FK
JOIN DEPARTMENT D ON E.Department_Id_FK = D.Department_ID_PK
WHERE D.Name IN ('Sales', 'Accounting');

-- 2. LIST OUT ALL THE JOBS IN SALES AND ACCOUNTING DEPARTMENTS.
SELECT J.Designation
FROM JOB J
JOIN Employee E ON J.Job_ID = E.Job_Id_FK
JOIN DEPARTMENT D ON E.Department_Id_FK = D.Department_ID_PK
WHERE D.Name IN ('Sales', 'Accounting');

-- 3. LIST OUT THE COMMON JOBS IN RESEARCH AND ACCOUNTING DEPARTMENTS IN ASCENDING ORDER. 
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

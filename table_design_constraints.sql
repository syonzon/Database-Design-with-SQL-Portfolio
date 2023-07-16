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

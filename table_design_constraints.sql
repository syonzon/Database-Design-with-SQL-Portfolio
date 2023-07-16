#create table code snippet
-- Creating the proMas table 
CREATE TABLE proMas (
    ProdId INT PRIMARY KEY,
    ProdName VARCHAR(30) NOT NULL, --constraint
    ProdCost MONEY
);

-- Selecting all records from UniTab table
SELECT * FROM UniTab;

-- Creating the CusmTr table
CREATE TABLE CusmTr (
    CusmId INT PRIMARY KEY,
    CusmName VARCHAR(30) NOT NULL,
    CusmLoc VARCHAR(30) NOT NULL,
    EmailId VARCHAR(30) NOT NULL,
    CCP INT CHECK (CCP >= 20 AND CCP <= 67),
    DL VARCHAR(30) UNIQUE,
    ProdID INT REFERENCES proMas(ProdID),
    ShipDate DATE DEFAULT '2014-07-26'
);

-- Creating the UniTab table
CREATE TABLE UniTab (
    EmId INT PRIMARY KEY,
    EmNam VARCHAR(30) NOT NULL,
    DL VARCHAR(30)
);

-- Creating a unique nonclustered index on UniTab table
CREATE UNIQUE NONCLUSTERED INDEX uni_idx_DL
ON UniTab(DL)
WHERE DL IS NOT NULL;

-- Creating the UniqueKeyTable01 table
CREATE TABLE UniqueKeyTable01 (
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(30) NOT NULL,
    DLno VARCHAR(30)
);

-- Creating a unique nonclustered index on UniqueKeyTable01 table
CREATE UNIQUE NONCLUSTERED INDEX idx_tbl_UniqueKeyTable_DLno
ON UniqueKeyTable01(DLno)
WHERE DLno IS NOT NULL;

-- Inserting records into UniqueKeyTable01 table
INSERT INTO UniqueKeyTable01
VALUES (1, 'Madhav01', NULL);

INSERT INTO UniqueKeyTable01
VALUES (2, 'Madhav02', NULL);

INSERT INTO UniqueKeyTable01
VALUES (3, 'Madhav03', NULL);

INSERT INTO UniqueKeyTable01
VALUES (4, 'Madhav04', NULL);

INSERT INTO UniqueKeyTable01
VALUES (5, 'Madhav05', NULL);

-- Selecting all records from UniqueKeyTable01 table
SELECT * FROM UniqueKeyTable01;

-- Dropping the unique constraint on CusmTr table
ALTER TABLE CusmTr
DROP CONSTRAINT UQ__CusmTr__3214621E02D795EA;

-- Retrieving constraint information for CusmTr table
SELECT 
    CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    TABLE_NAME = 'CusmTr';

-- Adding a foreign key constraint to CusmTr table
ALTER TABLE CusmTr
ADD CONSTRAINT FK_ProID FOREIGN KEY (ProdID) REFERENCES proMas(ProdID);

-- Adding a composite primary key constraint to CusmTr table
ALTER TABLE CusmTr
ADD CONSTRAINT PK_CusmID PRIMARY KEY (CusmID, CusmNam);

-- Selecting all records from CusmTr table
SELECT * FROM CusmTr;

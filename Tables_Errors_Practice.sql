IF NOT EXISTS (SELECT name FROM master.sys.databases WHERE name = N'TestDB')
Begin
CREATE DATABASE TestDB;
END
-- Checking to see if the database exist.

USE TestDB
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'HumanResources')
BEGIN
EXEC('CREATE SCHEMA HumanResources')
END
-- Checking to see if the SCHEMA exist and creating it.


IF NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'HumanResources' 
                 AND TABLE_NAME = 'Employees')
BEGIN
CREATE Table [TestDB].[HumanResources].[Employees] (
Employeeid INT PRIMARY KEY NOT NULL,
Salary varchar(15),
Name Text
);
END

IF NOT EXISTS (SELECT * FROM HumanResources.Employees HAVING COUNT(*) > 0)
BEGIN
INSERT INTO [TestDB].[HumanResources].[Employees] 
	([Employeeid], [Salary], [Name]) 
	VALUES (19456, 50000, 'John Doe')
INSERT INTO [TestDB].[HumanResources].[Employees] 
	VALUES (19795, 55000, 'Ryan Bark')
INSERT INTO [TestDB].[HumanResources].[Employees] 
	VALUES (19799, 53000, 'Arnold Baggins')
INSERT INTO [TestDB].[HumanResources].[Employees] 
	VALUES (19861, 55675, 'Matt Hickens')
END

TRUNCATE TABLE HumanResources.Employees
UPDATE HumanResources.Employees SET Name = NULL WHERE LEN(Salary) > 1
DROP TABLE HumanResources.Employees

CREATE TABLE Customer(
Customer_Id Int Identity(1,1) PRIMARY KEY,
FName Nvarchar(30) Not Null,
LName Nvarchar(30) Not Null,
Email Nvarchar(30) Not Null,
Phone Nvarchar(30) Not Null,
City Nvarchar(30) Not Null,
Address Nvarchar(30) Not Null,
Postcode Nvarchar(4) Not Null,
);
CREATE TABLE Supplier(
Supplier_Id Int Identity(1,1) PRIMARY KEY,
CompanyName Nvarchar(30) Not Null,
SupplierFullName Nvarchar(30) Not Null,
Phone Nvarchar(30) Not Null,
);
CREATE TABLE Category(
Category_Id Int Identity(1,1) PRIMARY KEY,
CategoryType Nvarchar(30) Not Null,
);



CREATE TABLE Orders(
Order_Id Int Identity(1,1) PRIMARY KEY,
OrderName Nvarchar(30) Not Null,
PaymentType Nvarchar(20) Not Null,
Details Nvarchar(100) Not Null,
Customer_Id INT FOREIGN KEY REFERENCES Customer(Customer_Id),
);
CREATE TABLE Product(
Product_Id Int Identity(1,1) PRIMARY KEY,
ProductName Nvarchar(30) Not Null,
Count  Int Not Null,
Description Nvarchar(255) Not Null,
Price Decimal(18,2) Not Null,
Category_Id INT FOREIGN KEY REFERENCES Category(Category_Id),
Supplier_Id INT FOREIGN KEY REFERENCES Supplier(Supplier_Id)
);
CREATE TABLE OrderProduct(
Quantity  Int Not Null,
Order_Id INT FOREIGN KEY REFERENCES Orders(Order_Id),
Product_Id INT FOREIGN KEY REFERENCES Product(Product_Id),
);


INSERT INTO Customer(FName,LName,Email,Phone,Address,City,Postcode) VALUES('Alex', 'Joe', 'alks58@abv.bg','+359 680 50 20','Str Main 35','Plovdiv','2020');
INSERT INTO Customer(FName,LName,Email,Phone,Address,City,Postcode) VALUES('Nina', 'Bend', 'ninka4@abv.bg','+359 300 51 54','Str Ken 15','Sofia','2010');
INSERT INTO Customer(FName,LName,Email,Phone,Address,City,Postcode) VALUES('Viki', 'Gineva', 'viks11@abv.bg','+359 112 55 68','Str Hin 6','Varna','2030');
INSERT INTO Customer(FName,LName,Email,Phone,Address,City,Postcode) VALUES('Mike', 'Dim', 'mks71@abv.bg','+359 290 66 23','Str Main 70','Burgas','2024');
INSERT INTO Customer(FName,LName,Email,Phone,Address,City,Postcode) VALUES('Tia', 'Ken', 'tkn34@abv.bg','+359 720 50 74','Str Len 5','Karlovo','2051');
INSERT INTO Customer(FName,LName,Email,Phone,Address,City,Postcode) VALUES('Joe', 'Klo', 'jkls1765@abv.bg','+359 151 49 60','Str KO 6','Varna','2031');

INSERT INTO Supplier(CompanyName,SupplierFullName,Phone) VALUES('Speedy', 'John K.','+359 180 12 07');
INSERT INTO Supplier(CompanyName,SupplierFullName,Phone) VALUES('Ekont', 'Tito F.','+359 880 39 29');
INSERT INTO Supplier(CompanyName,SupplierFullName,Phone) VALUES('Walmart', 'Mila M.','+359 578 45 01');

INSERT INTO Category(CategoryType) VALUES('Electronic');
INSERT INTO Category(CategoryType) VALUES('Fashion');
INSERT INTO Category(CategoryType) VALUES('HealthAndBeauty');
INSERT INTO Category(CategoryType) VALUES('Home');


INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('TV',20,'Brand:Sumsung,Resolution:720p(HD)',199.00,1,1);
INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('HairBand',10,'MadeIn:Chineese,',4.00,2,2);
INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('Shampoo-Olive',30,'Apply:for normal hair',35.00,3,3);
INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('Blouse',54,'Material:Cotton,Colors:White/Green',49.00,2,2);
INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('Bingo',100,'Strong preparat',5.60,3,1);
INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('Tablet',45,'Brand:Lenovo',125.00,1,3);

INSERT INTO Orders(OrderName,PaymentType,Details,Customer_Id) VALUES('ORDM2578','cash','OrderDate:29/01/2020 Reciving:after 2weeks',1);
INSERT INTO Orders(OrderName,PaymentType,Details,Customer_Id) VALUES('ORDM1578','pay pal','OrderDate:11/05/2020 Reciving:after 3days',2);
INSERT INTO Orders(OrderName,PaymentType,Details,Customer_Id) VALUES('ORDM2678','credit card','OrderDate:21/06/2020 Reciving:after 1day',3);
INSERT INTO Orders(OrderName,PaymentType,Details,Customer_Id) VALUES('ORDM2508','master card','OrderDate:04/01/2020 Reciving:after 5weeks',4);
INSERT INTO Orders(OrderName,PaymentType,Details,Customer_Id) VALUES('ORDM1518','pay pal','OrderDate:25/05/2020 Reciving:after 3days',5);
INSERT INTO Orders(OrderName,PaymentType,Details,Customer_Id) VALUES('ORDM2648','credit card','OrderDate:08/06/2020 Reciving:after 1day',6);

INSERT INTO OrderProduct(Quantity,Order_Id,Product_Id) VALUES(1,1,1);
INSERT INTO OrderProduct(Quantity,Order_Id,Product_Id) VALUES(2,2,2);
INSERT INTO OrderProduct(Quantity,Order_Id,Product_Id) VALUES(5,3,3);
INSERT INTO OrderProduct(Quantity,Order_Id,Product_Id) VALUES(4,4,4);
INSERT INTO OrderProduct(Quantity,Order_Id,Product_Id) VALUES(3,5,5);
INSERT INTO OrderProduct(Quantity,Order_Id,Product_Id) VALUES(1,6,6);

CREATE PROCEDURE CreateSuppliers(
	@C as NVARCHAR(255),
	@SN as NVARCHAR(255),
	@P as NVARCHAR(32))
AS
BEGIN
	INSERT INTO Supplier(CompanyName,SupplierFullName, Phone)
	VALUES(@C, @SN, @P);
END;
EXEC CreateSuppliers 'Speedy','Mikel K.','+359 850 36 40';

CREATE FUNCTION Information1()    
returns table       
as      
return(SELECT c.FName,c.LName,p.ProductName ,SUM(p.Price * op.Quantity) as Total
FROM Customer c
JOIN Orders o
ON c.Customer_Id =o.Customer_Id 
JOIN OrderProduct op 
ON op.Order_Id =o.Order_Id
JOIN Product p
ON p.Product_Id=op.Product_Id
GROUP BY c.FName,c.LName,p.ProductName)
SELECT * FROM Information1()

CREATE TRIGGER INSERT_TRIGGER ON
Product AFTER INSERT AS BEGIN 
SELECT * FROM Product END

INSERT INTO Product(ProductName,Count,Description,Price,Category_Id,Supplier_Id) VALUES('Gaming phone',50,'Color:black,blue',955.00,4,1);

CREATE VIEW View1 AS
SELECT C.FName,C.LName,C.Address,O.Details,O.PaymentType
FROM Customer C
JOIN Orders O
ON C.Customer_Id=O.Customer_Id;

SELECT * FROM View1

CREATE TABLE Logs(
Log_Id INTEGER PRIMARY KEY Identity(1,1),
Info VARCHAR(100) NOT NULL, 
AtTime DATE NOT NULL);

CREATE TRIGGER LogAfterCategoryCreation
ON Category
AFTER INSERT
AS
BEGIN
DECLARE @Name AS NVARCHAR(255) = (SELECT CategoryType FROM inserted);
	INSERT INTO Logs(Info, AtTime) 
	VALUES(@Name +' категория беше създадена', GETDATE());
END;

INSERT INTO Category(CategoryType) VALUES('Cooking');
SELECT * FROM Logs

CREATE TRIGGER LogAfterCategoryDelete
ON Category
AFTER DELETE
AS
BEGIN
	DECLARE @Name AS NVARCHAR(255) = (SELECT CategoryType FROM deleted);
	INSERT INTO Logs(Info, AtTime) 
	VALUES( @Name + ' категория беше изтрита', GETDATE());
END;
DELETE FROM Category WHERE Category_Id=8
SELECT * FROM Logs



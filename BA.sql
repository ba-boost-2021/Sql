--             KULLANILAN DOCKER KOMUTLARI


--docker ps                    						-> Çalışan container listesi
--docker ps -a                 						-> tüm container listesi
--docker image ls              						-> image listesi
--docker rmi [id||name]        						-> image sil
--docker rm [id||name]         						-> container sil
--docker stop [id||name]       						-> container durdur
--docker start [id|name]       						-> container başlat 
--docker cp .\[filename] [id]:[path]/[filename] 	-> Lokal bilgisayardan container'a dosya kopyalar
--docker run -d --name bilgeadam-sql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=1q2w3e4R!" -p 12000:1433 -d mcr.microsoft.com/mssql/server

--Kullanılan Şifre : 1q2w3e4R!
--SQL : Structured Query Language

--SQL SERVER default olarak 1433 portunda çalışır
SELECT 2
SELECT 3 * (3 + 4) AS Result
SELECT 1.0 * 23 / 5

--UNION kullanımında tüm sorgu çıktılarındaki kolon sayıları ve sıralı veri türleri aynı olmalı
--UNION DISTICT ederek çıktı üretir: DISTINCT bakınız: aşağıdaki örnekler

SELECT 'Can' AS 'FirstName', 'PERK' AS 'LastName', 33 AS 'Age'
UNION
SELECT 'İsmail', 'KARA', 25
UNION 
SELECT 'Ata', 'TAN', 25
UNION
SELECT 'Kaan', 'ÇALIŞKAN', 25
UNION
SELECT 'Esengül', 'ÖZKUL', 25
UNION
SELECT 'Berk', 'ÖZERDOĞAN', 25
UNION ALL
SELECT 'Berk', 'ÖZERDOĞAN', 25
UNION ALL
SELECT 'Esengül', 'ÖZKUL', 25
--UNION ALL DISTINC özelliği sonraki tablo için kapatır

DROP DATABASE Northwind 
RESTORE DATABASE Northwind FROM DISK = N'/home/Northwind.bak' WITH MOVE 'Northwind' TO '/var/opt/mssql/data/Northwind.mdf', MOVE 'Northwind_Log' TO '/var/opt/mssql/data/Northwind_Log.ldf', REPLACE
RESTORE DATABASE AdventureWorks FROM DISK = N'/var/opt/mssql/data/AW2019Latest.bak' WITH MOVE 'AdventureWorks' TO '/var/opt/mssql/data/AdventureWorks.mdf', MOVE 'AdventureWorks_Log' TO '/var/opt/mssql/data/AdventureWorks_Log.ldf', REPLACE
----- MİLAT
--RDBMS -> Relational DataBase Management Service
--DML : Data Manipulation Language
--CRUD Operations:
---- CREATE, READ, UPDATE, DELETE

USE Northwind 
-- SELECT [kolon adı], [kolon adi], [kolon adi] AS [gösterilecek başlık] FROM [tabloadı]
-- WHERE [kolon adı] [operatör] [değer] 
SELECT * FROM Products
SELECT * FROM Employees
SELECT * FROM Customers
SELECT FirstName, LastName FROM Employees
SELECT FirstName + ' ' + LastName AS [Full Name] FROM Employees
SELECT CompanyName, ContactName, Country, Phone FROM Customers
SELECT CompanyName, ContactName, Phone FROM Customers WHERE Country = 'Sweden'
SELECT FirstName, LastName, City FROM Employees WHERE Country = 'USA'
SELECT FirstName, LastName, BirthDate FROM Employees WHERE BirthDate < '1960-01-01'
SELECT FirstName, LastName FROM Employees WHERE Country = 'USA' AND City = 'Tacoma'

SELECT p.ProductName AS Name, p.UnitPrice AS Price, p.UnitsInStock AS Stock FROM Products AS p 

--FOREIGN KEY : Verinin referans bilgisi alt tabloda, esas bilgisi üst tabloda olan değere Foreign Key denir. 
-- !!ÖNEMLİ!! -> Foreign Key olan kolon kendi tablosunda benzersiz olmalıdır (unique)

--PRIMARY KEY: Bir kolonun bir tabloda benzersiz şekilde veri tutması özelliğine (unique) Primary Key denir. Ör: TC Kimlik No


-- SELECT [kolon adı], [kolon adi], [kolon adi] AS [gösterilecek başlık] FROM [tabloadı]
-- INNER JOIN [diğer tablo ad] ON [ilişki kolonu] = [diğer ilişki kolonu]
-- WHERE [kolon adı] [operatör] [değer] 
-- ORDER BY [kolon adı veya alias] 
SELECT 
	p.ProductName AS Name, 
	p.UnitPrice AS Price, 
	p.UnitsInStock AS Stock, 
	c.CategoryName AS Category, 
	s.CompanyName AS Company, 
	s.Country  
FROM Products AS p 
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID 
INNER JOIN Suppliers AS s ON p.SupplierID = s.SupplierID 
WHERE p.CategoryID = 1
ORDER BY Name

SELECT p.ProductName AS Name, p.UnitPrice * p.UnitsInStock AS [Total Price] FROM Products AS p 
ORDER BY 2 DESC -- 2 demek 2. sıradaki kolon demek

--GÜN 2

SELECT * FROM Orders
WHERE CustomerID = 'ALFKI'

SELECT od.OrderID, p.ProductName, p.UnitPrice,  od.UnitPrice, od.Quantity, od.Discount 
FROM [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID 
WHERE p.UnitPrice <> od.UnitPrice 

-- Sipariş Detayında ürünün fiyatı, satış fiyatı ve diğer bilgileri, sipariş tarihi
SELECT p.ProductName, p.UnitPrice,  od.UnitPrice, od.Quantity, od.Discount, o.OrderDate  
FROM [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID 
INNER JOIN Orders o ON od.OrderID = o.OrderID 
WHERE od.OrderID = 10250

--Sipariş Detayındaki indirim bilgileri
SELECT 
	UnitPrice * Quantity AS Orijinal, 
	UnitPrice * Quantity * (1 - Discount) AS Indirimli,
	UnitPrice * Quantity * Discount AS Indirim
FROM [Order Details] od 
WHERE OrderID = 10250
--AGGREATE FUNCTIONS -> COUNT, SUM, AVG, MIN, MAX

--Toplam kazanç
SELECT SUM(UnitPrice * Quantity * (1 - Discount)) AS Summary -- ROUND(kolon, 2) 2 basamağa yuvarlar
FROM [Order Details] od 
WHERE OrderID = 10250

--Siparişlerdeki ortalama kazanç nedir
SELECT AVG(UnitPrice * Quantity * (1 - Discount)) AS Average FROM [Order Details]

-- 1-n relation (1 veriye karşılık n adet verinin tutulması) => 1 Customer'ın n tane siparişi olabilir
--Kaç adet sipariş var
SELECT COUNT(0)
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID 

--GROUP BY
--Müşterilerin çoktan aza sipariş verme sayısı
SELECT c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
ORDER BY [Order Count] DESC

--En çok sipariş veren 10 müşteri
SELECT TOP 10 c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
ORDER BY [Order Count] DESC

--En çok sipariş veren 6 müşteri
SELECT TOP 6 WITH TIES c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
ORDER BY [Order Count] DESC --8 kayıt döner çünkü 6. satıra ait veriye eşit başka 2 satır daha var

-------------       -----------  
--ALFKI | 6         BOTTM | 9         
--ANATR | 4         BERGS | 8         
--ANTON | 3         ALFKI | 6         
--...               ...
--...               ...
--BOTTM | 9         ANTON | 3

SELECT TOP 3 c.CustomerID, c.ContactName, c.Phone, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName, c.Phone 
ORDER BY [Order Count] DESC

--İndirimlerden ne kadar zarar elde edildi
SELECT 
	SUM(UnitPrice * Quantity) AS [Total Amount], 
	SUM(UnitPrice * Quantity * Discount) AS [Total Discount],
	SUM(UnitPrice * Quantity * Discount) / SUM(UnitPrice * Quantity) * 100 AS Ratio -- KEKO Yöntem
FROM [Order Details]

-- TODO: Ay ay ne kadar indirim yapılmış

--HAVING
-- en çok alışveriş yapan ve alışveriş sayısın 20'den çok olan ilk 10 müşteri
SELECT TOP 10 c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
HAVING COUNT(0) > 20 -- AGGREATE FUNCTION için filtreleme yapabilmek için kullanılır
ORDER BY [Order Count] DESC

-- Toplam alışverişi 5000 lirayı geçmeyen müşterilerin telefon numaraları ve isimleri
SELECT 
	c.CompanyName AS Name, 
	c.Phone AS Phone,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)), 2) AS Summary
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName, c.Phone
HAVING SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) < 5000
ORDER BY 3 ASC

---JOIN Türleri
SELECT p.ProductName, c.CategoryName FROM Categories c 
INNER JOIN Products p ON c.CategoryID = p.CategoryID -- Sadece JOIN de olur
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
LEFT JOIN Products p ON c.CategoryID = p.CategoryID -- LEFT OUTER JOIN de olur
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
RIGHT JOIN Products p ON c.CategoryID = p.CategoryID -- RIGHT OUTER JOIN
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
FULL OUTER JOIN Products p ON c.CategoryID = p.CategoryID 
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
CROSS JOIN Products p 
ORDER BY c.CategoryID DESC

--DATETIME FONKSIYONLARI
SELECT DATEPART(YEAR, GETDATE())
SELECT DATEDIFF(MONTH, '1988-02-08', GETDATE())
SELECT DATEDIFF(MONTH, '2017-05-08', GETDATE()) / 4 ---> Ah seni bekleyeli belki 14 bahar geçti :D
SELECT FORMAT(GETDATE(), 'dd MMMM yyyy')
SELECT DATEADD(MONTH, 3, GETDATE()) 
SELECT DATEADD(SECOND, 30, GETDATE()) 
SELECT DATEADD(DAY, 3, '2022-01-01')
-- Intervals -> YEAR, MONTH, DAY, HOUR, MINUTE, SECOND, MILLISECOND

--Personel Yaşları
SELECT FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age  FROM Employees 

--En yaşlı çalışan
SELECT TOP 1 WITH TIES FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age  
FROM Employees 
ORDER BY Age DESC

SELECT TOP 1 WITH TIES FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age  
FROM Employees 
ORDER BY BirthDate

--LIKE 
SELECT ContactName, CompanyName FROM Customers c 
WHERE ContactName LIKE 'mar%'
ORDER BY ContactName

SELECT ContactName, CompanyName FROM Customers c 
WHERE ContactName LIKE '%ler'
ORDER BY ContactName

--CASE WHEN
SELECT 
	FirstName, 
	LastName, 
	CASE Country 
		WHEN 'USA' THEN 'Amerika' 
		WHEN 'UK' THEN 'İngiltere' 
		ELSE 'Tanımsız' 
	END AS Country 
FROM Employees
--Kritik Seviye 10
SELECT 
	ProductName,
	CASE WHEN UnitsInStock > 10 THEN 'Stokta Var'
		 WHEN UnitsInStock BETWEEN 1 AND 10 THEN 'Kritik Seviye'
		 ELSE 'Yok'
	END AS Status
FROM Products 

SELECT 
	CASE TitleOfCourtesy 
		WHEN 'Mr.' THEN 'Male'
		WHEN 'Mrs.' THEN 'Female'
		WHEN 'Ms.' THEN 'Female'
		ELSE 'Unknown'
	END AS Gender,
	FirstName + ' ' + LastName AS FullName 
FROM Employees

--COALESCE
SELECT 
	FirstName, 
	LastName,
	COALESCE(Region, City, Country, 'No Region') AS Region
FROM Employees

--GÜN 3

SELECT '           Mustafa Kemal Atatürk          '
SELECT LEN('           Mustafa Kemal Atatürk          ')
SELECT TRIM('           Mustafa Kemal Atatürk          ')
SELECT LTRIM('           Mustafa Kemal Atatürk          ')
SELECT RTRIM('           Mustafa Kemal Atatürk          ')
SELECT LEN(TRIM('           Mustafa Kemal Atatürk          ')) 
SELECT SUBSTRING('Mustafa Kemal Atatürk', 0, 14) 

SELECT mka.value AS Name, c.CategoryName FROM STRING_SPLIT('Mustafa Kemal Atatürk', ' ') mka
CROSS JOIN Categories c 

-- Database uyumluluk versiyonunu String Split in çalışabileceği versiyona yükselltik (Backup dosyası 100 sayılı uyumluluk modunda idi)
ALTER DATABASE Northwind SET COMPATIBILITY_LEVEL = 150

SELECT name, compatibility_level FROM sys.databases -- sistemimizdeki veritabanı uyumluluk seviyesi kontrolü için

SELECT TRANSLATE('2*[3+4]/{7-2}', '[]{}', '()()'); -- denedik translate değilmiş :D

--Tekilleştirme amaçlı yazılır
SELECT DISTINCT
	p.ProductName,
	o.OrderDate 
FROM [Order Details] od 
INNER JOIN Orders o ON od.OrderID = od.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID 

SELECT p.ProductName, o.OrderDate, COUNT(0) AS Count
FROM [Order Details] od 
INNER JOIN Orders o ON od.OrderID = od.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID 
WHERE o.OrderDate BETWEEN '1996-12-01' AND '1996-12-31' AND p.ProductID = 3
GROUP BY p.ProductName, o.OrderDate 

----
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p 
INNER JOIN Categories c ON c.CategoryID = p.CategoryID 
WHERE c.CategoryName LIKE 'Cond%';


--Sub Query
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p  
WHERE p.CategoryID = (SELECT TOP 1 c.CategoryId FROM Categories c WHERE c.CategoryName LIKE 'Cond%')


--IN Kullanımı
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p  
WHERE p.CategoryID = 1 OR p.CategoryID = 2

SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p
WHERE p.CategoryID IN (1, 2)

-- EXIST
-- STOKTA TÜKENMİŞ ÜRÜNLERİ KATEGORİLERİ
SELECT c.CategoryName 
FROM Categories c 
WHERE EXISTS (SELECT p.ProductName FROM Products AS p 
			  WHERE p.CategoryID = c.CategoryID AND p.UnitsInStock = 0);

SELECT c.CategoryName 
FROM Categories c 
WHERE CategoryID IN (SELECT DISTINCT p.CategoryID FROM Products p
					 WHERE p.UnitsInStock = 0)

-- ROLL UP
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)
WITH ROLLUP 
ORDER BY ProductName

-- CUBE
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)
WITH CUBE 
ORDER BY ProductName, Year, Month

--GROUPING SETS
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY GROUPING SETS (p.ProductName, (DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)))
ORDER BY ProductName 


SELECT NULL AS ProductName,  NULL AS Year, NULL AS Month, SUM(UnitPrice * Quantity) Total FROM [Order Details] od
UNION
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductID = 1 AND DATEPART(YEAR, o.OrderDate) = 1996 
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)
UNION
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, NULL AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductID = 1 AND DATEPART(YEAR, o.OrderDate) = 1996 
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate)
-- ... ve diğer super master keko çözüm


SET STATISTICS TIME OFF
SET STATISTICS IO OFF


--- ROW_NUMBER & OVER
SELECT ROW_NUMBER () OVER(ORDER BY SUM(od.UnitPrice * od.Quantity)) AS OrderNo,  p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE DATEPART(YEAR, o.OrderDate) = 1996 
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate)


SELECT 
	ROW_NUMBER () OVER(PARTITION BY DATEPART(YEAR, o.OrderDate) ORDER BY p.ProductName) AS OrderNo,  
	p.ProductName, 
	DATEPART(YEAR, o.OrderDate) AS Year, 
	SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate)

-- GÜN 4
--CRUD : Create, Read, Update, Delete
--CREATE : Oluşturma -> SQL => INSERT

INSERT INTO Categories (CategoryName, Description) VALUES ('Electronics', 'Devices that are works with electricty')
INSERT INTO Categories (CategoryName, Description) VALUES ('Furniture', 'Wooden stuffs')

SELECT TOP 5 * FROM Suppliers ORDER BY SupplierID DESC
SELECT TOP 5 * FROM Categories ORDER BY CategoryID DESC

SELECT c.CategoryName, COUNT(0) AS Count FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY CategoryName
ORDER BY Count

SELECT p.ProductName, p.UnitPrice, s.CompanyName, s.Phone FROM Products p
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID 

INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock)
VALUES ('Trust Microphone', 9, 110, 24)

INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock)
VALUES ('EPSON Projector', 9, 820, 9)

INSERT INTO Products (ProductName, CategoryID, SupplierID, UnitPrice, UnitsInStock)
VALUES ('LINGO Chair', 10, 30, 340, 120)

INSERT INTO Suppliers (CompanyName, ContactName, City, Country, Phone)
VALUES ('Sil', 'Can Perk', 'Ankara', 'Turkey', '+90 555 444 55 55')

SELECT * FROM Products WHERE CategoryID IN (9, 10)
------
-- UPDATE
UPDATE Products SET SupplierID = 31 WHERE ProductID = 78
UPDATE Products SET SupplierID = 30 WHERE ProductID = 79

UPDATE Products SET SupplierID = 30 WHERE SupplierID = 31

DELETE FROM Suppliers WHERE SupplierID = 31
-- ÖNEMLİ !!!!
-- DELETE ve UPDATE sorgularında, kesinkes WHERE kullanılmalıdır!!!!!
-- Aksi halde geri dönülmez veri kayıpları yaşanabilir

-- NO NO NO NO !!!!
--UPDATE Products SET UnitPrice = 5 
--DELETE FROM [Order Details]
--DELETE FROM Products
--USE master
--DROP DATABASE Northwind

SELECT * FROM Employees


UPDATE Employees SET BirthDate = DATEADD(YEAR, 30, BirthDate), 
					 HireDate = DATEADD(YEAR, 30, HireDate)

UPDATE Employees SET BirthDate = DATEADD(YEAR, 5, BirthDate), 
					 HireDate = DATEADD(YEAR, 5, HireDate)

UPDATE Employees SET HireDate = DATEADD(YEAR, -1, HireDate)

SELECT * FROM Employees
SELECT TOP 20 * FROM Orders

SELECT OrderDate, ShippedDate
FROM Orders
WHERE EmployeeID = 9
--KISS
UPDATE Orders SET OrderDate = DATEADD(YEAR, 25, OrderDate),
				  ShippedDate = DATEADD(YEAR, 25, ShippedDate),
				  RequiredDate = DATEADD(YEAR, 25, ShippedDate)

UPDATE Orders SET OrderDate = DATEADD(YEAR, -2, OrderDate),
				  ShippedDate = DATEADD(YEAR, -2, ShippedDate)

DECLARE @CID char(5)
SET @CID = 'ERNSH'
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipCity, ShipCountry)
VALUES (@CID, 
		9, 
		GETDATE(), 
		(SELECT City FROM Customers WHERE CustomerID = @CID), 
		(SELECT Country FROM Customers WHERE CustomerID = @CID))

SELECT TOP 1 * FROM Orders ORDER BY OrderID DESC

INSERT INTO [Order Details]
VALUES (11078, 78, 110, 1, 0),
	   (11078, 79, 803.6, 1, 0.02),
	   (11078, 80, 340, 2, 0),
	   (11078, 62, 49.3, 6, 0),
	   (11078, 76, 18, 1, 0)

SELECT p.ProductName, ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS Summary 
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE od.OrderID = 11078
GROUP BY p.ProductName

UPDATE [Order Details] SET UnitPrice = 820 WHERE OrderID = 11078 AND ProductID = 79

SELECT 
	CONCAT(FORMAT(o.OrderDate, 'yyMMdd'), o.OrderID) AS [Invoice Number],
	ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS [Summary]
FROM Orders o
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.CustomerID = 'ERNSH'
GROUP BY CONCAT(FORMAT(o.OrderDate, 'yyMMdd'), o.OrderID)
ORDER BY [Invoice Number] DESC

SELECT * FROM Products
ORDER BY ProductID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

SELECT ContactName, Phone, 'C' AS Type
INTO Contacts --!!! BAKIN BURASI ÇOK ÖNEMLİ :D
FROM Customers
UNION
SELECT FirstName + ' ' + LastName, HomePhone, 'E'
FROM Employees

SELECT * FROM Contacts WHERE Type = 'E'

--GÜN 5
-- DDL : Data Definition Language
-- CREATE, DROP, ALTER
--VIEW

--Tablolardan getirilecek veriyi çalıştırdığımız sorguya verdiğimiz bir isimdir.
--Güvenlik vb amaçlı kullanılabilir
SELECT * FROM [Alphabetical list of products]
ORDER BY ProductName

SELECT * FROM [Invoices]
GO
CREATE VIEW Contacts
--WITH SCHEMABINDING --: sorguda şema belirtmek zorunlu
AS
SELECT ContactName, Phone, 'C' AS Type
FROM dbo.Customers WHERE Phone IS NOT NULL
UNION
SELECT FirstName + ' ' + LastName, HomePhone, 'E'
FROM dbo.Employees

GO

DROP VIEW Contacts
GO
CREATE VIEW AmericanEmployees
AS 
SELECT * FROM Employees WHERE Country = 'USA'
GO
SELECT * FROM Contacts
GO
CREATE SCHEMA Reporting
GO
--CONSTRAINTS
--  > NOT NULL		: boş geçemez
--  > NULL			: boş geçebilir (yazmak zorunda değiliz)
--  > PRIMARY KEY   : satırdaki unique olma özelliğini getirir
--  > FOREIGN KEY	: bir kolonun esas verisini başka bir kolondan alma ilişkisidir
--  > DEFAULT		: kolona insert anında bir değer verilmez ise atanacak değer
--  > IDENTITY		: sayılar veri içeren bir kolonun değerini kendisini belirlemesidir ve devam ettirmesidir
CREATE TABLE Reporting.Notes
(
	NoteID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	EmployeeID INT NOT NULL,
	Content varchar(256) NOT NULL,
	CustomerID nchar(5) NULL,
	CreatedAt DATETIME NULL DEFAULT(GETDATE()),

	CONSTRAINT FK_Notes_Employees FOREIGN KEY (EmployeeID) REFERENCES dbo.Employees(EmployeeID),
	CONSTRAINT FK_Notes_Customers FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID)
)

SELECT * FROM Reporting.Notes
--IDENTITY TANIMLI DEĞİLKEN
INSERT INTO Reporting.Notes (NoteID, EmployeeID, Content) VALUES (1, 9, 'Çıkmadan lambaları kapat')
INSERT INTO Reporting.Notes (NoteID, EmployeeID, Content) VALUES (2, 5, 'Raporları mail at')
--IDENTITY TANIMLI İKEN
INSERT INTO Reporting.Notes (EmployeeID, Content) VALUES (9, 'Çıkmadan lambaları kapat')
INSERT INTO Reporting.Notes (EmployeeID, Content) VALUES (5, 'Raporları mail at')
INSERT INTO Reporting.Notes (EmployeeID, CustomerID, Content) VALUES (4, 'BERGS', 'Olmayan veriler')
DROP TABLE Reporting.Notes
/*
varchar, nvarchar, char, nchar, text
tinyint, int, bigint
*/

--INSERT INTO Contacts VALUES ('Can PERK', '233445', 'C')

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Employee, c.ContactName, n.Content 
FROM Reporting.Notes n
INNER JOIN Employees e ON e.EmployeeID = n.EmployeeID
LEFT JOIN Customers c ON c.CustomerID = n.CustomerID

SELECT 
	CONCAT(e.FirstName, ' ', e.LastName) AS Employee,
	CONCAT(m.FirstName, ' ', m.LastName) AS Manager
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID

SELECT * FROM Reporting.Notes
--ALTER
GO
ALTER TABLE Reporting.Notes
ADD NotificationDate DATETIME NULL

ALTER TABLE Reporting.Notes
ADD Title varchar(24) NULL

UPDATE Reporting.Notes SET Title = 'Başlık Yok'

ALTER TABLE Reporting.Notes
ALTER COLUMN Title varchar(24) NOT NULL

INSERT INTO Reporting.Notes (EmployeeID, Title, Content, NotificationDate) 
VALUES (2, 'Su', 'Su içme zamanı', DATEADD(MINUTE, 15, GETDATE()))

ALTER TABLE Reporting.Notes
ADD DeleteMe INT DEFAULT(0)
GO
ALTER TABLE Reporting.Notes
DROP CONSTRAINT DF__Notes__DeleteMe__04E4BC85

ALTER TABLE Reporting.Notes
DROP COLUMN DeleteMe
---V2
ALTER TABLE Reporting.Notes
ADD DeleteMe INT

ALTER TABLE Reporting.Notes
ADD CONSTRAINT DF_DeleteMe DEFAULT 0 FOR DeleteMe

ALTER TABLE Reporting.Notes
DROP CONSTRAINT DF_DeleteMe

ALTER TABLE Reporting.Notes
DROP COLUMN DeleteMe


--GÜN 6
--Normalizasyon Kuralları
--INDEXLEME

SELECT * FROM [Order Details] od 
WHERE OrderID = 10282

SELECT * FROM [Order Details] od 
WHERE UnitPrice > 10

SET STATISTICS TIME OFF
SET STATISTICS IO OFF

CREATE NONCLUSTERED INDEX IX_UnitPrice
ON [Order Details] (UnitPrice)

CREATE NONCLUSTERED INDEX IX_UnitPrice
ON [Products] (UnitPrice)

DROP INDEX IX_UnitPrice ON [Order Details]
DROP INDEX IX_UnitPrice ON [Products]

USE AdventureWorks


SELECT * FROM HumanResources.Employee e 

RESTORE DATABASE AdventureWorks FROM DISK = '/home/Can.bak' WITH REPLACE

USE AdventureWorks 
SELECT * FROM Production.Product p 
SELECT * FROM Person.Person p WHERE p.Suffix IS NOT NULL

CREATE NONCLUSTERED INDEX IX_Person_Suffix ON Person.Person (Suffix)

DROP INDEX IX_Person_Suffix ON Person.Person

SELECT @@SPID


-- CTE : Common Table Expression
SELECT p.ProductNumber, p.Name, p.ListPrice, s.Name AS [SubCategory] , c.Name AS [Category] 
FROM Production.Product p
INNER JOIN Production.ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID 
INNER JOIN Production.ProductCategory c ON c.ProductCategoryID = s.ProductCategoryID 
WHERE c.ProductCategoryID = 1

WITH CTE AS
(
	SELECT s.ProductSubcategoryID AS [Id], c.Name AS [Category], s.Name AS [SubCategory] 
	FROM Production.ProductCategory c
	INNER JOIN Production.ProductSubcategory s ON c.ProductCategoryID = s.ProductCategoryID 
	WHERE c.ProductCategoryID = 1
)

SELECT p.ProductNumber, p.Name, p.ListPrice, c.Category , c.SubCategory
FROM Production.Product p
INNER JOIN CTE c ON c.Id = p.ProductSubcategoryID

CREATE VIEW Production.vProductSummary
AS
(
	SELECT p.ProductNumber, p.Name, p.ListPrice--, c.Category , c.SubCategory
	FROM Production.Product p
)

SELECT * FROM Production.mvProductSummary

--CREATE MATERIALIZED VIEW Production.mvProductSummary -- Yobaz SQL Server desteklemiyor :D 
--AS
--(
--  	SELECT p.ProductNumber, p.Name, p.ListPrice--, c.Category , c.SubCategory
--	    FROM Production.Product p
--)

--DIRTY DATA

SELECT * FROM Person.Person p WHERE p.BusinessEntityID = 19
SELECT * FROM HumanResources.EmployeePayHistory h WHERE h.BusinessEntityID = 16
SELECT h.BusinessEntityID, COUNT(0)  FROM HumanResources.EmployeePayHistory h
GROUP BY h.BusinessEntityID 
ORDER BY 2 DESC

--v1
SELECT CONCAT(prs.FirstName, ' ', prs.LastName) AS SalesPerson, p.Name, SUM(od.OrderQty * od.UnitPrice) AS Summary 
FROM Sales.SalesOrderDetail od
INNER JOIN Production.Product p ON od.ProductID = p.ProductID 
INNER JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID 
INNER JOIN Sales.SalesOrderHeader h ON h.SalesOrderID = od.SalesOrderID 
INNER JOIN Person.Person prs ON prs.BusinessEntityID = h.SalesPersonID 
WHERE s.ProductSubcategoryID = 1
GROUP BY p.Name, CONCAT(prs.FirstName, ' ', prs.LastName)
HAVING SUM(od.OrderQty * od.UnitPrice) > 10000

--v2
;WITH CTEProducts AS
(
	SELECT p.Name, p.ProductID FROM Production.Product p WHERE p.ProductSubcategoryID = 1
),
CTEOrders AS 
(
	SELECT h.SalesPersonID, od.ProductID, SUM(od.OrderQty * od.UnitPrice) AS Summary FROM Sales.SalesOrderDetail od
	INNER JOIN Sales.SalesOrderHeader h ON h.SalesOrderID  = od.SalesOrderID 
	WHERE h.SalesPersonID IS NOT NULL
	GROUP BY h.SalesPersonID, od.ProductID 
	HAVING SUM(od.OrderQty * od.UnitPrice) > 10000
)

SELECT CONCAT(prs.FirstName, ' ', prs.LastName) AS SalesPerson,
	   p.Name,
	   o.Summary
FROM Person.Person prs
INNER JOIN CTEOrders o ON o.SalesPersonID = prs.BusinessEntityID  
INNER JOIN CTEProducts p ON p.ProductID = o.ProductID

-- GÜN 7 

SELECT DATEPART(YEAR, GETDATE())
--SCALAR FUNCTIONS
CREATE OR ALTER FUNCTION GetTotalSummary() RETURNS MONEY
AS BEGIN
	RETURN (SELECT SUM(UnitPrice * Quantity) FROM [Order Details])
END;

CREATE OR ALTER FUNCTION GetSalesYearCount() RETURNS INT
AS BEGIN
	DECLARE @result INT;
	;WITH CTEYear 
	AS 
	(
		SELECT 
			ROW_NUMBER() OVER (PARTITION BY DATEPART(YEAR, OrderDate) ORDER BY OrderDate) AS Row, 
			DATEPART(YEAR,o.OrderDate) AS Year
		FROM Orders o 
	)
	SELECT @result = COUNT(0) FROM CTEYear WHERE Row = 1
	RETURN @result;
END;

SELECT dbo.GetTotalSummary()
SELECT dbo.GetSalesYearCount()
SELECT dbo.GetTotalSummary() / dbo.GetSalesYearCount() AS YearlyAverage
SELECT 3 / 2


--SELECT @@ROWCOUNT;
--SELECT @@IDENTITY;

SELECT ROW_NUMBER() OVER (PARTITION BY DATEPART(YEAR, OrderDate) ORDER BY OrderDate) FROM Orders
--TABLE VALUED FUNCTIONS
CREATE FUNCTION GetSummaryByCustomerId (@id nchar(5)) 
RETURNS TABLE
AS RETURN (SELECT CONVERT(VARCHAR, o.OrderDate, 103) AS Date, FORMAT(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 'N2') AS Price
		FROM Orders o
		INNER JOIN [Order Details] od ON od.OrderID  = o.OrderID 
		WHERE o.CustomerID = @id
		GROUP BY CONVERT(VARCHAR, o.OrderDate, 103))
		
SELECT * FROM GetSummaryByCustomerId('BOLID')
	
CREATE OR ALTER FUNCTION GetAllContacts(@filter varchar(20))
RETURNS @result TABLE (
	FullName varchar(40),
	Phone varchar(25),
	Type char
)
AS BEGIN 
	INSERT INTO @result
	SELECT ContactName AS FullName, Phone, 'C' AS Type FROM Customers WHERE ContactName LIKE @filter + '%'
	UNION 
	SELECT CONCAT(FirstName, ' ', LastName), HomePhone, 'E' FROM Employees WHERE FirstName LIKE @filter + '%'
	RETURN;
END

SELECT * FROM GetAllContacts ('alex')

--STORED PROCEDURE
CREATE OR ALTER PROCEDURE Deneme
AS BEGIN
	DECLARE @i INT
	SET @i = 0
	WHILE @i < 10
	BEGIN 
		PRINT @i
		SET @i = @i + 1
	END
END
EXEC Deneme

CREATE OR ALTER PROCEDURE HayvanlarParaIleSatinAlinamaz
AS BEGIN
	DECLARE @i INT
	DECLARE @t AS TABLE (Number INT)
	SET @i = 0
	WHILE @i < 10
	BEGIN 
		INSERT INTO @t VALUES (@i)
		SET @i = @i + 1
	END
	
	SELECT * FROM @t
END

EXEC HayvanlarParaIleSatinAlinamaz 

CREATE OR ALTER PROCEDURE Contacts
AS BEGIN 
	SELECT ContactName AS FullName, Phone, 'C' AS Type FROM Customers
	UNION 
	SELECT CONCAT(FirstName, ' ', LastName), HomePhone, 'E' FROM Employees
END

EXECUTE Contacts

CREATE OR ALTER PROCEDURE ContactsByFilter (@fn varchar(10) = NULL, @ln varchar(10) = NULL)
AS BEGIN 
	SELECT e.FirstName, e.LastName, e.HireDate, e.HomePhone FROM Employees e 
	WHERE e.FirstName LIKE @fn + '%' OR e.LastName LIKE @ln + '%'
END

EXEC ContactsByFilter 'na'

CREATE TABLE Logs
(
	Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	UserName VARCHAR(20) NOT NULL,
	Date DATETIME DEFAULT GETDATE(),
	TableName VARCHAR(30)
)
DROP TABLE Logs 
--TRUNCATE : tabloyu sıfırlar, varsa identity insert, ona ait sequence da sıfırlanır
--			 delete ile tablo sıfırlanır ise sequence kaldığı yerden devam eder			
TRUNCATE TABLE Logs

ALTER TABLE Logs
DROP COLUMN TableName

ALTER TABLE Logs 
ADD ExecutedQuery nvarchar(max)
SELECT NEWID()

CREATE OR ALTER PROCEDURE GetCustomersById (@id nchar(5))
AS BEGIN 
	SELECT ContactName, CompanyName, Country, City, Phone FROM Customers WHERE CustomerID = @id
	INSERT INTO Logs (UserName, ExecutedQuery) VALUES (SUSER_NAME(), 'Customers')
END

CREATE OR ALTER PROCEDURE GetCustomersByIdV2 (@id nchar(5))
AS BEGIN 
	DECLARE @query nvarchar(1024);
	SET @query = FORMATMESSAGE('SELECT ContactName, CompanyName, Country, City, Phone FROM Customers WHERE CustomerID = ''%s''', CAST(@id AS varchar))
	--PRINT @query -- anlık çıktı alabilmek için (Console.WriteLine)
	EXEC (@query)
	INSERT INTO Logs (UserName, ExecutedQuery) VALUES (SUSER_NAME(), @query)
END

DECLARE @q nvarchar(20)
SET @q = 'SELECT 2'
EXEC SP_EXECUTESQL @q
EXEC GetCustomersById 'bergs'
--DCL
CREATE USER canperk WITH PASSWORD='1qaz2wsX!' 
GRANT EXECUTE ON OBJECT::dbo.GetCustomersById TO canperk
GRANT EXECUTE ON OBJECT::dbo.GetCustomersByIdV2 TO canperk

SELECT 2

SELECT login_name
FROM sys.dm_exec_sessions ;

SELECT @@SPID
SELECT SUSER_NAME()

SELECT * FROM Logs

EXEC GetCustomersByIdV2 'bergs'

SELECT FORMATMESSAGE('This is the %s and this is the', CAST(1 AS varchar)) AS Result;

SELECT CHECKSUM(NEWID()) -- Hascode

SELECT NEWID()

SELECT TOP 2 * FROM Employees e ORDER BY NEWID()

-- GÜN 8
CREATE OR ALTER PROCEDURE CreateOrder (@customerId NCHAR(5), @employeeId INT)
AS BEGIN 
	INSERT INTO Orders (CustomerID, OrderDate, ShippedDate, RequiredDate, EmployeeID)	
	VALUES (@customerId, GETDATE(), DATEADD(DAY,1, GETDATE()), DATEADD(DAY, 3, GETDATE()), @employeeId)
	SELECT @@IDENTITY -- Bir önceki eklenen satırdan elde edilen sequence değerini gösterir
END

CREATE OR ALTER PROCEDURE CreateOrderDetail(@orderId INT, @productId INT, @quantity INT, @hasdiscount bit = 0)
AS BEGIN 
	DECLARE @quantityInProducts INT
	DECLARE @price MONEY
	SELECT @quantityInProducts = UnitsInStock, @price = UnitPrice FROM Products WHERE ProductID = @productId
	IF @quantityInProducts >= @quantity  
	BEGIN 
		DECLARE @discount DECIMAL(5,2)
		SET @discount = 0
		IF @hasDiscount = 1
		BEGIN 
			SET @discount = 0.05
		END
		INSERT INTO [Order Details] VALUES(@orderId, @productId, @price, @quantity, @discount)
		UPDATE Products SET UnitsInStock = UnitsInStock - @quantity WHERE ProductID = @productId
	END
	ELSE
	BEGIN 
		THROW 50001, 'Ürün stokta belirtilen kadar yok', 1 -- RAISEERROR(50001, 'Message', 1)
	END
END

----------------
EXECUTE CreateOrder 'ANTON', 4

EXECUTE CreateOrderDetail 11078, 23, 1
EXECUTE CreateOrderDetail 11078, 4, 1, 1
EXECUTE CreateOrderDetail 11078, 1, 1, 1
----
SELECT * FROM Orders WHERE OrderID = 11078
SELECT * FROM [Order Details] WHERE OrderID = 11078

--TRIGGER
--CREATE OR ALTER TRIGGER OnOrderCreated
--FOR INSERT ON [Order Details] -- after ile aynı
--AFTER INSERT ON [Order Details] -- for ile aynı
--INSTEAD OF INSERT

CREATE OR ALTER TRIGGER OnProductIsBeingDeleted
ON Products INSTEAD OF DELETE 
AS BEGIN 
	THROW 50000, 'Ürün silinemez', 1
END


DELETE FROM Products WHERE ProductID = 1
SELECT * FROM Products WHERE ProductID = 1

ALTER TABLE Products 
ADD IsDeleted BIT DEFAULT (0)

UPDATE Products SET IsDeleted = 0 WHERE 1 = 1

ALTER TABLE Products
ALTER COLUMN IsDeleted BIT NOT NULL 
--------------------------------------------
ALTER TABLE Products
DROP CONSTRAINT DF__Products__IsDele__0E6E26BF

ALTER TABLE Products
DROP COLUMN IsDeleted

ALTER TABLE Products 
ADD IsDeleted BIT NOT NULL DEFAULT (0)

CREATE OR ALTER TRIGGER OnProductIsBeingDeleted
ON Products INSTEAD OF DELETE 
AS BEGIN 
	DECLARE @Id INT
	SELECT @Id = ProductID FROM DELETED
	UPDATE Products SET IsDeleted = 1 WHERE ProductID = @Id
END
DELETE FROM Products WHERE ProductID = 1
------------------------------------------------
CREATE OR ALTER TRIGGER OnOrderCreated
ON [Order Details] AFTER INSERT
AS BEGIN 
	DECLARE @Id INT
	DECLARE @Quantity INT
	SELECT @Id = ProductID, @Quantity = Quantity FROM INSERTED
	UPDATE Products SET UnitsInStock = UnitsInStock - @Quantity WHERE ProductID = @Id
END

SELECT * FROM Products WHERE ProductID = 1
SELECT * FROM [Order Details] WHERE OrderID = 11078

INSERT INTO [Order Details] VALUES (11078, 1078, 50, 2, 0)

-------
CREATE SCHEMA History
CREATE TABLE Northwind.History.ProductAudits (
	AuditID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	CreatedAt DATETIME DEFAULT GETDATE(),
	ProductID int NOT NULL,
	ProductName nvarchar(40) NULL,
	SupplierID int NULL,
	CategoryID int NULL,
	QuantityPerUnit nvarchar(20) NULL,
	UnitPrice money NULL,
	UnitsInStock smallint NULL,
	UnitsOnOrder smallint NULL,
	ReorderLevel smallint NULL,
	Discontinued bit NULL,
	IsDeleted bit NULL,
);

CREATE OR ALTER TRIGGER OnProductUpserted
ON Products FOR INSERT, UPDATE
AS BEGIN 
	INSERT INTO History.ProductAudits 
	(ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, IsDeleted)
	SELECT 
		ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, IsDeleted
	FROM INSERTED
END

--KISS : Keep It Simple and Stupid

INSERT INTO Products
	(ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued, IsDeleted)
VALUES ('Coca - Cola', 1, 1, '6 btls in 1 pck.', 50, 120, 0, 1, 0, 0)


DELETE FROM Products WHERE ProductID = 1078
UPDATE Products SET IsDeleted = 0, UnitPrice = 54 WHERE ProductID = 1078

SELECT * FROM History.ProductAudits

--- CURSOR: 

--Döngü ile karmaşık olan koşulları tek tek yönetmenin çözülebildiği bileşen

-- Fiyatı 50 lira üstünde olup stokta olan ürünlere %10; olmayanlara %0 : stokta var ise : 60 -> 66, yok ise 60
-- Fiyatı 50 lira altında olanlara %20 zam yapılsın : stok durumuna bakılmaksınız : 40 -> 48
DECLARE @productId INT
DECLARE productCursor CURSOR FOR 
SELECT ProductID FROM Products
OPEN productCursor
FETCH NEXT FROM productCursor INTO @productId

WHILE @@FETCH_STATUS = 0
BEGIN 
	DECLARE @price MONEY 
	SET @price = (SELECT UnitPrice FROM Products WHERE ProductID = @productId AND UnitsInStock > 0 AND UnitPrice >= 50)
	IF @price IS NOT NULL
	BEGIN 
		UPDATE Products SET UnitPrice = @price * 1.1 WHERE ProductID = @productId 
	END
	ELSE
	BEGIN
		SET @price = (SELECT UnitPrice FROM Products WHERE ProductID = @productId AND UnitPrice < 50)
		IF @price IS NOT NULL
		BEGIN 
			UPDATE Products SET UnitPrice = @price * 1.2 WHERE ProductID = @productId 
		END
	END
	FETCH NEXT FROM productCursor INTO @productId
END
CLOSE productCursor 
DEALLOCATE productCursor















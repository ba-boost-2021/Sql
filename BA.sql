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

DROP DATABASE Northwind 
RESTORE DATABASE Northwind FROM DISK = N'/home/Northwind.bak' WITH MOVE 'Northwind' TO '/var/opt/mssql/data/Northwind.mdf', MOVE 'Northwind_Log' TO '/var/opt/mssql/data/Northwind_Log.ldf', REPLACE
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

-----------       -----------  
ALFKI | 6         BOTTM | 9         
ANATR | 4         BERGS | 8         
ANTON | 3         ALFKI | 6         
...               ...
...               ...
BOTTM | 9         ANTON | 3

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






--1.	在【員工】資料表中找出所有男性員工的資料。
SELECT *
FROM Employees
WHERE TitleOfCourtesy IN ('Mr.', 'Dr.'); --Dr.只有一個且備註為his


--2.	在【員工】資料表中找出所有在1993年(含)以後到職的資料。
SELECT *
FROM Employees
WHERE HireDate >= '1993-01-01';

--3.	在【訂單】資料表找出送貨郵遞區號為44087與05022及82520的資料。
SELECT *
FROM Orders
WHERE ShipPostalCode IN ('44087', '05022', '82520');

--4.	在【產品】資料表中找出庫存量最多的前6名資料記錄。
SELECT  *
FROM Products

SELECT TOP 6 WITH TIES *
FROM Products
ORDER BY UnitsInStock DESC;


--5.	找出訂單號碼10847的訂購產品明細（不需join產品資料）。
SELECT *
FROM OrderDetails
WHERE OrderID = 10847;

--6.	在【訂單】資料表中找出尚未有送貨日期的記錄資料。
SELECT *
FROM Orders
WHERE ShippedDate IS NULL;

--7.	在【訂單名細】資料表中找出訂購的產品數量介於20~40件的資料記錄。
SELECT *
FROM OrderDetails
WHERE Quantity BETWEEN 20 AND 40;

--1.	計算【產品】資料表中類別號為2的產品資料平均單價。
SELECT *
FROM Products
WHERE CategoryID = 2;

SELECT ROUND(AVG(UnitPrice), 0) AS avg_price
FROM Products
WHERE CategoryID = 2;


--2.	在【產品】資料表中找出庫存量小於安全存量，且尚未進行採購的產品資料記錄。

SELECT *
FROM Products
WHERE UnitsInStock < ReorderLevel AND UnitsOnOrder = 0;


--3.	在【訂單明細】資料表找出訂單中包含超過5種產品的資料記錄。
SELECT  OrderID
FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(DISTINCT ProductID) > 5;


--3.2rd解法
SELECT od.OrderID, 
       STUFF((
           SELECT ', ' + CAST(ProductID AS VARCHAR(MAX))
           FROM OrderDetails od2
           WHERE od.OrderID = od2.OrderID
           ORDER BY ProductID
           FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ProductID_List
FROM (
    SELECT OrderID
    FROM OrderDetails
    GROUP BY OrderID
    HAVING COUNT(DISTINCT ProductID) > 5
) od;


--4.在【訂單明細】資料表中顯示出訂單號碼10263所有產品的價格小計。


SELECT 
    OrderID, 
    ProductID, 
    ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 0) AS Price_Subtotal
FROM OrderDetails
WHERE OrderID = 10263
GROUP BY OrderID, ProductID;

--5.	利用【產品】資料表資料，統計出每一個供應商各提供了幾樣產品。
SELECT SupplierID, COUNT(ProductID) AS 提供產品數量
FROM Products
GROUP BY SupplierID;

--6.	利用【訂單】資料表資料，統計出每一位客戶被每一位員工所服務次數。

SELECT CustomerID, EmployeeID, COUNT(EmployeeID) AS times
FROM Orders
GROUP BY CustomerID, EmployeeID;
--6-2解法
SELECT CustomerID, EmployeeID, COUNT (*) AS times
FROM Orders
GROUP BY CustomerID, EmployeeID;



---7.利用【訂單明細】資料表資料，統計出各項商品的平均單價與平均銷售數量，並列出平均銷售數量大於10的資料，且將資料依產品編號由小到大排序。

SELECT 
    ProductID, 
    ROUND(AVG(UnitPrice), 0) AS avg_unit_price, 
    ROUND(AVG(Quantity), 0) AS avg_sale_quantity
FROM OrderDetails
GROUP BY ProductID
HAVING AVG(Quantity) > 10
ORDER BY ProductID ;



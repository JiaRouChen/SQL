--合併查詢
SELECT *
FROM Products
WHERE ProductID IN (
    SELECT DISTINCT ProductID
    FROM OrderDetails
    WHERE OrderID IN (
        SELECT OrderID
        FROM Orders
        WHERE YEAR(OrderDate) = 1998
    )
)
ORDER BY ProductID ASC;

--子查詢

SELECT *
FROM Products
WHERE ProductID IN (
    SELECT DISTINCT od.ProductID
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE YEAR(o.OrderDate) = 1998
)
ORDER BY ProductID ASC;
----------------------------------------------------------------------老師解法
--合併查詢
SELECT DISTINCT Products.*
FROM Orders INNER JOIN  
					OrderDetails ON Orders.OrderID = OrderDetails.OrderID INNER JOIN 
					Products ON OrderDetails.ProductID = Products.ProductID
WHERE OrderDate between '1998-1-1' and '1998-12-31'
ORDER BY Products.ProductID ASC



------------



--子查詢


SELECT *
FROM Products
WHERE ProductID IN (
    SELECT  ProductID FROM OrderDetails
WHERE orderID IN 

(SELECT		OrderID
FROM Orders
WHERE OrderDate between '1998-1-1' and '1998-12-31')
)
Order by ProductID
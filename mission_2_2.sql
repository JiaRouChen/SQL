SELECT 
    c.CustomerID,
    c.ContactName,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantity
FROM 
    Orders o
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Customers c ON o.CustomerID = c.CustomerID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    c.CustomerID = 'ANTON'
GROUP BY 
    c.CustomerID,
    c.ContactName,
    p.ProductName;

SELECT *
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);


------------------------2下面比較清楚，只是有join

SELECT 
    c.CustomerID,
    c.ContactTitle,
    COUNT(o.OrderID) AS OrderCount
FROM
    Customers c
LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Orders o2
        WHERE o2.CustomerID = c.CustomerID
    )
GROUP BY
    c.CustomerID, c.ContactTitle
ORDER BY
    c.CustomerID;


	----

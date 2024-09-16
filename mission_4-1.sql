SELECT *
FROM Orders;
------------

CREATE PROCEDURE Sum_for_Products_Sales_Pivot
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQLQuery AS NVARCHAR(MAX)

    -- 動態生成 pivot 查詢語句
    SET @SQLQuery = N'
    SELECT ProductName,
           ISNULL([1], 0) AS January,
           ISNULL([2], 0) AS February,
           ISNULL([3], 0) AS March,
           ISNULL([4], 0) AS April,
           ISNULL([5], 0) AS May,
           ISNULL([6], 0) AS June,
           ISNULL([7], 0) AS July,
           ISNULL([8], 0) AS August,
           ISNULL([9], 0) AS September,
           ISNULL([10], 0) AS October,
           ISNULL([11], 0) AS November,
           ISNULL([12], 0) AS December
    FROM (
        SELECT p.ProductName,
               MONTH(o.OrderDate) AS OrderMonth,
               SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * (od.Discount / 100))) AS TotalSales
        FROM Northwind.dbo.Products p
        INNER JOIN Northwind.dbo.[OrderDetails] od ON p.ProductID = od.ProductID
        INNER JOIN Northwind.dbo.Orders o ON od.OrderID = o.OrderID
        WHERE YEAR(o.OrderDate) = ' + CAST(@Year AS NVARCHAR(4)) + '
        GROUP BY p.ProductName, MONTH(o.OrderDate)
    ) AS SalesData
    PIVOT (
        SUM(TotalSales)
        FOR OrderMonth IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
    ) AS PivotTable
    ORDER BY ProductName;
    '

    -- 執行動態生成的 SQL 查詢
    EXEC sp_executesql @SQLQuery

END;


EXEC Sum_for_Products_Sales_Pivot @Year = 1998; -- 替換年份為你需要查詢的年份
EXEC Sum_for_Products_Sales_Pivot @Year = 1997; -- 替換年份為你需要查詢的年份(接近題目的)
EXEC Sum_for_Products_Sales_Pivot @Year = 1996; -- 替換年份為你需要查詢的年份




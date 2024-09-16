CREATE PROCEDURE Sum_for_Products_Sales_Pivot
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQLQuery AS NVARCHAR(MAX)

    -- 動態生成 pivot 查詢語句
    SET @SQLQuery = N'
    SELECT ProductName,
           ROUND(ISNULL([1], 0), 2) AS "1月",
           ROUND(ISNULL([2], 0), 2) AS "2月",
           ROUND(ISNULL([3], 0), 2) AS "3月",
           ROUND(ISNULL([4], 0), 2) AS "4月",
           ROUND(ISNULL([5], 0), 2) AS "5月",
           ROUND(ISNULL([6], 0), 2) AS "6月",
           ROUND(ISNULL([7], 0), 2) AS "7月",
           ROUND(ISNULL([8], 0), 2) AS "8月",
           ROUND(ISNULL([9], 0), 2) AS "9月",
           ROUND(ISNULL([10], 0), 2) AS "10月",
           ROUND(ISNULL([11], 0), 2) AS "11月",
           ROUND(ISNULL([12], 0), 2) AS "12月"
    FROM (
        SELECT p.ProductName,
               MONTH(o.OrderDate) AS OrderMonth,
               ROUND(SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Quantity * (od.Discount / 100))), 0) AS TotalSales
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

--執行查詢
EXEC Sum_for_Products_Sales_Pivot @Year = 1997; --題目要ㄉ
EXEC Sum_for_Products_Sales_Pivot @Year = 1996;
EXEC Sum_for_Products_Sales_Pivot @Year = 1998;
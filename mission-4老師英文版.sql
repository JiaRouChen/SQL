CREATE PROCEDURE Sum_for_Products_Sales_Pivot2
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQLQuery AS NVARCHAR(MAX)

    -- �ʺA�ͦ� pivot �d�߻y�y
    SET @SQLQuery = N'
    SELECT ProductName,
           ISNULL([1], 0) AS "1��",
           ISNULL([2], 0) AS "2��",
           ISNULL([3], 0) AS "3��",
           ISNULL([4], 0) AS "4��",
           ISNULL([5], 0) AS "5��",
           ISNULL([6], 0) AS "6��",
           ISNULL([7], 0) AS "7��",
           ISNULL([8], 0) AS "8��",
           ISNULL([9], 0) AS "9��",
           ISNULL([10], 0) AS "10��",
           ISNULL([11], 0) AS "11��",
           ISNULL([12], 0) AS "12��"
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

    -- ����ʺA�ͦ��� SQL �d��
    EXEC sp_executesql @SQLQuery

END;

EXEC Sum_for_Products_Sales_Pivot2 @Year = 1997;
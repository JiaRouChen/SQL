CREATE PROCEDURE Sum_for_Products_Salse_Pivot3
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(@Year, 12, 31);

    SELECT 
        ISNULL(pvt.ProductID, '') AS 產品編號,
        ISNULL(p.ProductName, '') AS 產品名稱,
        ISNULL([1], 0) AS [1月],
        ISNULL([2], 0) AS [2月],
        ISNULL([3], 0) AS [3月],
        ISNULL([4], 0) AS [4月],
        ISNULL([5], 0) AS [5月],
        ISNULL([6], 0) AS [6月],
        ISNULL([7], 0) AS [7月],
        ISNULL([8], 0) AS [8月],
        ISNULL([9], 0) AS [9月],
        ISNULL([10], 0) AS [10月],
        ISNULL([11], 0) AS [11月],
        ISNULL([12], 0) AS [12月]
    FROM 
        (
        SELECT 
            od.ProductID, 
            ISNULL(ROUND(SUM((od.UnitPrice * od.Quantity - od.Discount)), 0), 0) AS 銷售額, 
            MONTH(o.OrderDate) AS 月份
        FROM 
            [OrderDetails] AS od 
            INNER JOIN Orders AS o ON od.OrderID = o.OrderID
        WHERE 
            o.OrderDate >= @StartDate AND o.OrderDate <= @EndDate
        GROUP BY 
            od.ProductID, 
            MONTH(o.OrderDate)
        ) AS t
    PIVOT
    (
        SUM(銷售額)
        FOR 月份 IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
    ) AS pvt
    LEFT JOIN Products AS p ON pvt.ProductID = p.ProductID
    ORDER BY 
        產品編號;

END;

EXEC Sum_for_Products_Salse_Pivot3 @Year = 1997;
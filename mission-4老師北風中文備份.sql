CREATE PROCEDURE Sum_for_Products_Salse_Pivot2
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, 1, 1);
    DECLARE @EndDate DATE = DATEFROMPARTS(@Year, 12, 31);

    SELECT 
        ISNULL(pvt.產品編號, '') AS 產品編號,
        ISNULL(p.產品, '') AS 產品名稱,
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
            od.產品編號, 
            ISNULL(ROUND(SUM((od.單價 * od.數量 - od.折扣)), 0), 0) AS 銷售額, 
            MONTH(o.訂單日期) AS 月份
        FROM 
            訂貨明細 AS od 
            INNER JOIN 訂貨主檔 AS o ON od.訂單號碼 = o.訂單號碼
        WHERE 
            o.訂單日期 >= @StartDate AND o.訂單日期 <= @EndDate
        GROUP BY 
            od.產品編號, 
            MONTH(o.訂單日期)
        ) AS t
    PIVOT
    (
        SUM(銷售額)
        FOR 月份 IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
    ) AS pvt
    LEFT JOIN 產品資料 AS p ON pvt.產品編號 = p.產品編號
    ORDER BY 
        產品編號;

END;

EXEC Sum_for_Products_Salse_Pivot2 @Year = 1997;
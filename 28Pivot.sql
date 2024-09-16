

select 訂單號碼,產品編號, 數量 from 訂貨明細



select * from 
(select 訂單號碼,產品編號, 數量
from 訂貨明細) as t
pivot
(
	count(產品編號)
	for 數量 in ([20],[15],[10],[5],[1])

) as p;


----------------------------------------------------------------------------
select 產品編號, [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12] from 
(select od.產品編號, od.數量, MONTH(o.訂單日期) as 月份
from 訂貨明細 as od inner join 訂貨主檔 as o 
on od.訂單號碼=o.訂單號碼
) as t
pivot
(
	sum(t.數量)
	for t.月份 in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])

) as p
order by 產品編號
------------null = 0

SELECT 
    ISNULL(產品編號, '') as 產品編號,
    ISNULL([1], 0) as [1月],
    ISNULL([2], 0) as [2月],
    ISNULL([3], 0) as [3月],
    ISNULL([4], 0) as [4月],
    ISNULL([5], 0) as [5月],
    ISNULL([6], 0) as [6月],
    ISNULL([7], 0) as [7月],
    ISNULL([8], 0) as [8月],
    ISNULL([9], 0) as [9月],
    ISNULL([10], 0) as [10月],
    ISNULL([11], 0) as [11月],
    ISNULL([12], 0) as [12月]
FROM 
    (
    SELECT 
        od.產品編號, 
        ISNULL(SUM(od.數量), 0) as 銷售額, 
        MONTH(o.訂單日期) as 月份
    FROM 
        訂貨明細 as od 
        INNER JOIN 訂貨主檔 as o ON od.訂單號碼 = o.訂單號碼
    GROUP BY 
        od.產品編號, 
        MONTH(o.訂單日期)
    ) AS t
PIVOT
(
    SUM(銷售額)
    FOR 月份 IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS p
ORDER BY 
    產品編號;

---------------顯示的值為每月份產品的銷售額。(售價*銷售數量-折扣)
SELECT 
    ISNULL(產品編號, '') as 產品編號,
    ISNULL([1], 0) as [1月],
    ISNULL([2], 0) as [2月],
    ISNULL([3], 0) as [3月],
    ISNULL([4], 0) as [4月],
    ISNULL([5], 0) as [5月],
    ISNULL([6], 0) as [6月],
    ISNULL([7], 0) as [7月],
    ISNULL([8], 0) as [8月],
    ISNULL([9], 0) as [9月],
    ISNULL([10], 0) as [10月],
    ISNULL([11], 0) as [11月],
    ISNULL([12], 0) as [12月]
FROM 
    (
    SELECT 
        od.產品編號, 
        ISNULL(ROUND(SUM((od.單價 * od.數量 - od.折扣)), 0), 0) as 銷售額, 
    MONTH(o.訂單日期) as 月份
    FROM 
        訂貨明細 as od 
        INNER JOIN 訂貨主檔 as o ON od.訂單號碼 = o.訂單號碼
    GROUP BY 
        od.產品編號, 
        MONTH(o.訂單日期)
    ) AS t
PIVOT
(
    SUM(銷售額)
    FOR 月份 IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS p
ORDER BY 
    產品編號;

	------------須建立參數查詢，可對預存程序傳入年度，樞鈕分析表即顯示當年度的銷售樞鈕分析結果。


	--///////////////////////////////////////////////////

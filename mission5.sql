use HW2DDL
go

create function getOrderID2()
	returns char(12)
as
begin
	
	--抓今天的日期
	
	declare @lastID char(12), @newID char(12)


	--抓今天的最後一張訂單編號
	select top 1 @lastID=訂單代號 from 訂單資料表
	where Convert(varchar,訂購日期,112)= Convert(varchar,getdate(),112)
	order by 訂購日期 desc


	--有找到=>流水號為n+1

	--沒找到=>流水號為0001

	if @lastID is null
	begin
		set @newID = Convert(varchar,getdate(),112)+'0001'
	end
	else 
		set @newID = cast( cast(@lastID as bigint)+1  as varchar)


	return @newID
end

--測試
print dbo.getOrderID2()

insert into 訂單資料表 values(dbo.getOrderID(),getDate())


select * from 訂單資料表

--------------------------------------我ㄉ的答-----------------------
USE HW2DDL
CREATE FUNCTION getOrderID ()
RETURNS char(12)
AS
BEGIN
    DECLARE @TodayDate char(8);
    DECLARE @NextSerial int;
    DECLARE @NewOrderID char(12);

    -- 取得當天日期，格式為西元年月日(8碼)
    SET @TodayDate = CONVERT(char(8), GETDATE(), 112);

    -- 取得當日的下一個流水號，假設訂單代號格式為8位日期+4位流水號
    SELECT @NextSerial = ISNULL(MAX(SUBSTRING(訂單代號, 9, 4)), 0) + 1
    FROM 訂單資料表
    WHERE SUBSTRING(訂單代號, 1, 8) = @TodayDate;

    -- 生成新的訂單編號
    SET @NewOrderID = @TodayDate + RIGHT('000' + CAST(@NextSerial AS varchar(4)), 4);

    RETURN @NewOrderID;
END;
GO

-----------------------------------------------
	   DECLARE @NewOrderID char(12);
SET @NewOrderID = dbo.getOrderID();
PRINT 'New Order ID: ' + @NewOrderID;
----------------

SELECT 訂單代號, 訂購日期
FROM 訂單資料表
ORDER BY 訂單代號 DESC;
------

DECLARE @NewOrderID char(12);
SET @NewOrderID = dbo.getOrderID();
SELECT @NewOrderID AS NewOrderID;

-----
DECLARE @NewOrderID char(12);
SET @NewOrderID = dbo.getOrderID();
PRINT 'New Order ID: ' + @NewOrderID;
----------------------------
INSERT INTO 訂單資料表(訂單代號, 訂購日期)
VALUES (dbo.getOrderID(), GETDATE());

-- 查詢測試表，檢查插入結果
SELECT 訂單代號, 訂購日期
FROM 訂單資料表

------------
INSERT INTO 訂單資料表 (訂單代號, 訂購日期)
VALUES 
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE());

-- 查詢訂單資料表，檢查插入結果的前五筆資料
SELECT 訂單代號, 訂購日期
FROM 訂單資料表
ORDER BY 訂單代號 ASC; 

--刪除表單
DELETE FROM 訂單資料表
WHERE 訂購日期 < '2024-06-26';





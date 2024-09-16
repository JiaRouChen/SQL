use HW2DDL
go

create function getOrderID2()
	returns char(12)
as
begin
	
	--�줵�Ѫ����
	
	declare @lastID char(12), @newID char(12)


	--�줵�Ѫ��̫�@�i�q��s��
	select top 1 @lastID=�q��N�� from �q���ƪ�
	where Convert(varchar,�q�ʤ��,112)= Convert(varchar,getdate(),112)
	order by �q�ʤ�� desc


	--�����=>�y������n+1

	--�S���=>�y������0001

	if @lastID is null
	begin
		set @newID = Convert(varchar,getdate(),112)+'0001'
	end
	else 
		set @newID = cast( cast(@lastID as bigint)+1  as varchar)


	return @newID
end

--����
print dbo.getOrderID2()

insert into �q���ƪ� values(dbo.getOrderID(),getDate())


select * from �q���ƪ�

--------------------------------------�ڣx����-----------------------
USE HW2DDL
CREATE FUNCTION getOrderID ()
RETURNS char(12)
AS
BEGIN
    DECLARE @TodayDate char(8);
    DECLARE @NextSerial int;
    DECLARE @NewOrderID char(12);

    -- ���o��Ѥ���A�榡���褸�~���(8�X)
    SET @TodayDate = CONVERT(char(8), GETDATE(), 112);

    -- ���o��骺�U�@�Ӭy�����A���]�q��N���榡��8����+4��y����
    SELECT @NextSerial = ISNULL(MAX(SUBSTRING(�q��N��, 9, 4)), 0) + 1
    FROM �q���ƪ�
    WHERE SUBSTRING(�q��N��, 1, 8) = @TodayDate;

    -- �ͦ��s���q��s��
    SET @NewOrderID = @TodayDate + RIGHT('000' + CAST(@NextSerial AS varchar(4)), 4);

    RETURN @NewOrderID;
END;
GO

-----------------------------------------------
	   DECLARE @NewOrderID char(12);
SET @NewOrderID = dbo.getOrderID();
PRINT 'New Order ID: ' + @NewOrderID;
----------------

SELECT �q��N��, �q�ʤ��
FROM �q���ƪ�
ORDER BY �q��N�� DESC;
------

DECLARE @NewOrderID char(12);
SET @NewOrderID = dbo.getOrderID();
SELECT @NewOrderID AS NewOrderID;

-----
DECLARE @NewOrderID char(12);
SET @NewOrderID = dbo.getOrderID();
PRINT 'New Order ID: ' + @NewOrderID;
----------------------------
INSERT INTO �q���ƪ�(�q��N��, �q�ʤ��)
VALUES (dbo.getOrderID(), GETDATE());

-- �d�ߴ��ժ�A�ˬd���J���G
SELECT �q��N��, �q�ʤ��
FROM �q���ƪ�

------------
INSERT INTO �q���ƪ� (�q��N��, �q�ʤ��)
VALUES 
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE()),
    (dbo.getOrderID(), GETDATE());

-- �d�߭q���ƪ�A�ˬd���J���G���e�������
SELECT �q��N��, �q�ʤ��
FROM �q���ƪ�
ORDER BY �q��N�� ASC; 

--�R�����
DELETE FROM �q���ƪ�
WHERE �q�ʤ�� < '2024-06-26';





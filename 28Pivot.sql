

select �q�渹�X,���~�s��, �ƶq from �q�f����



select * from 
(select �q�渹�X,���~�s��, �ƶq
from �q�f����) as t
pivot
(
	count(���~�s��)
	for �ƶq in ([20],[15],[10],[5],[1])

) as p;


----------------------------------------------------------------------------
select ���~�s��, [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12] from 
(select od.���~�s��, od.�ƶq, MONTH(o.�q����) as ���
from �q�f���� as od inner join �q�f�D�� as o 
on od.�q�渹�X=o.�q�渹�X
) as t
pivot
(
	sum(t.�ƶq)
	for t.��� in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])

) as p
order by ���~�s��
------------null = 0

SELECT 
    ISNULL(���~�s��, '') as ���~�s��,
    ISNULL([1], 0) as [1��],
    ISNULL([2], 0) as [2��],
    ISNULL([3], 0) as [3��],
    ISNULL([4], 0) as [4��],
    ISNULL([5], 0) as [5��],
    ISNULL([6], 0) as [6��],
    ISNULL([7], 0) as [7��],
    ISNULL([8], 0) as [8��],
    ISNULL([9], 0) as [9��],
    ISNULL([10], 0) as [10��],
    ISNULL([11], 0) as [11��],
    ISNULL([12], 0) as [12��]
FROM 
    (
    SELECT 
        od.���~�s��, 
        ISNULL(SUM(od.�ƶq), 0) as �P���B, 
        MONTH(o.�q����) as ���
    FROM 
        �q�f���� as od 
        INNER JOIN �q�f�D�� as o ON od.�q�渹�X = o.�q�渹�X
    GROUP BY 
        od.���~�s��, 
        MONTH(o.�q����)
    ) AS t
PIVOT
(
    SUM(�P���B)
    FOR ��� IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS p
ORDER BY 
    ���~�s��;

---------------��ܪ��Ȭ��C������~���P���B�C(���*�P��ƶq-�馩)
SELECT 
    ISNULL(���~�s��, '') as ���~�s��,
    ISNULL([1], 0) as [1��],
    ISNULL([2], 0) as [2��],
    ISNULL([3], 0) as [3��],
    ISNULL([4], 0) as [4��],
    ISNULL([5], 0) as [5��],
    ISNULL([6], 0) as [6��],
    ISNULL([7], 0) as [7��],
    ISNULL([8], 0) as [8��],
    ISNULL([9], 0) as [9��],
    ISNULL([10], 0) as [10��],
    ISNULL([11], 0) as [11��],
    ISNULL([12], 0) as [12��]
FROM 
    (
    SELECT 
        od.���~�s��, 
        ISNULL(ROUND(SUM((od.��� * od.�ƶq - od.�馩)), 0), 0) as �P���B, 
    MONTH(o.�q����) as ���
    FROM 
        �q�f���� as od 
        INNER JOIN �q�f�D�� as o ON od.�q�渹�X = o.�q�渹�X
    GROUP BY 
        od.���~�s��, 
        MONTH(o.�q����)
    ) AS t
PIVOT
(
    SUM(�P���B)
    FOR ��� IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS p
ORDER BY 
    ���~�s��;

	------------���إ߰ѼƬd�ߡA�i��w�s�{�ǶǤJ�~�סA�϶s���R��Y��ܷ�~�ת��P��϶s���R���G�C


	--///////////////////////////////////////////////////

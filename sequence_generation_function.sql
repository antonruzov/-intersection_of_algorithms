--»нициализаци€ функции в базе данных, котора€ генерирует числовую последовательность.
--¬ текущем варианте происходит генераци€ последовательности от start до end с шагом в 1 min
IF OBJECT_ID('dbo.GetNums', 'IF') IS NOT NULL DROP FUNCTION dbo.GetNums;

GO
CREATE FUNCTION dbo.GetNums(@low AS BIGINT, @high AS BIGINT) RETURNS TABLE
AS
RETURN
  WITH
    L0   AS (SELECT c FROM (VALUES(1),(1)) AS D(c)),
    L1   AS (SELECT 1 AS c FROM L0 AS A CROSS JOIN L0 AS B),
    L2   AS (SELECT 1 AS c FROM L1 AS A CROSS JOIN L1 AS B),
    L3   AS (SELECT 1 AS c FROM L2 AS A CROSS JOIN L2 AS B),
    L4   AS (SELECT 1 AS c FROM L3 AS A CROSS JOIN L3 AS B),
    L5   AS (SELECT 1 AS c FROM L4 AS A CROSS JOIN L4 AS B),
    Nums AS (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rownum
            FROM L5)
  SELECT @low + rownum - 1 AS n
  FROM Nums
  ORDER BY rownum
  OFFSET 0 ROWS FETCH FIRST @high - @low + 1 ROWS ONLY;

DECLARE 
  @start AS DATETIME2 = '2012-02-12 00:00:00.0000000',
  @end   AS DATETIME2 = '2012-02-13 12:00:00.0000000';

SELECT DATEADD(minute, n*60, @start) AS dt
FROM [DataBase].[dbo].GetNums(0, DATEDIFF(minute, @start, @end)/60) AS Nums;
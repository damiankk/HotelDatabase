SELECT 
  OBJECT_NAME(st.object_id) as NazwaTabeli, 
  LiczbaRekordow = SUM(st.row_count),
  case when SUM(st.row_count) <50 then 'mala'
	when SUM(st.row_count)<300 then 'srednia'
	else 'duza'
	end as WielkoscTabeli
FROM sys.dm_db_partition_stats st
INNER JOIN sys.objects AS o 
  ON o.object_id = st.object_id
WHERE (index_id < 2)
  AND o.type = 'U'
GROUP BY st.object_id
ORDER BY LiczbaRekordow;
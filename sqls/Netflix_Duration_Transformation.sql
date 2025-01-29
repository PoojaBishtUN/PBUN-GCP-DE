SELECT *
FROM your_table
WHERE duration LIKE '%min%' 
  AND duration NOT LIKE '%season%' 
  AND CAST(SUBSTRING(duration, 1, CHARINDEX('min', duration) - 1) AS INT) > 5;

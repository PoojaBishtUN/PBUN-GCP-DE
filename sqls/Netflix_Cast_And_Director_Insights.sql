--Directors Who Frequently Work with Specific Actors:

SELECT 
    director, 
    cast_member, 
    COUNT(*) AS collaborations
FROM 
    (SELECT id, title, director, TRIM(SPLIT_PART(cast, ',', n)) AS cast_member  FROM Source
     JOIN generate_series(1, LENGTH(cast) - LENGTH(REPLACE(cast, ',', '')) + 1) n
     ON TRUE) subquery
GROUP BY 
    director, cast_member
ORDER BY 
    collaborations DESC
LIMIT 10;

select type, country,release_year,rating,count(*) as c from source
group by 1,2,3,4
order by 1;
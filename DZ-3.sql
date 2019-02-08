SELECT 'FIO: Bordacheva Yulia';
--- Запрос ФИО

SELECT userId, movieId,

       (rating - MIN(rating) OVER (PARTITION BY userId)) / (MAX(rating) OVER (PARTITION BY  userId)) - (MIN(rating) OVER (PARTITION BY userId)) normed_rating, AVG(rating) OVER (PARTITION BY userId) avg_rating
FROM (
     SELECT DISTINCT
          userId, movieId, rating
  FROM  ratings
  WHERE userId <> 1 LIMIT 1000
       ) as samplepsql
ORDER BY userId, rating DESC LIMIT 30;

-----Вывести список пользователей в формате userId, movieId, normed_rating, avg_rating

psql -U postgres -c 'CREATE TABLE IF NOT EXISTS keywords (id bigint, tags varchar):'
--------------- создала таблицу

psql -U postgres -c "\\copy keywords FROM '/usr/local/share/netology/raw_data/keywords.csv' DELIMITER ',' CSV HEADER"

-------- Скопировала данные в таблицу

psql -U postgres
----- подключилась к контейнеру

SELECT  COUNT(*) FROM keywords;

------- 92838 - результат

SELECT movieid, AVG(rating)::numeric(10,2) as avg_rating FROM public.ratings GROUP BY movieid HAVING COUNT(userid) > 50 ORDER BY movieid ASC, avg_rating DESC LIMIT 150;

WITH top_rated AS (SELECT movieid, AVG(rating)::numeric(1Ы  Ы0,2) as avg_rating FROM public.ratings GROUP BY movieid HAVING COUNT(userid) > 50 ORDER BY movieid ASC, avg_rating DESC LIMIT 150 ) SELECT id, tags FROM keywords LIMIT 150;
-------- Запрос 1 и 2

WITH top_rated as ( SELECT movieid, AVG(rating)::numeric(10,2) as avg_rating FROM public.ratings GROUP BY movieid HAVING COUNT(userid) > 50 ORDER BY movieid ASC, avg_rating DESC LIMIT 150) SELECT movieid, top_rated_tags INTO top_rated_tags FROM public.top_rated, public.ratings LIMIT 150;
----- Запрос 3

\copy (SELECT * FROM ratings LIMIT 150) TO 'top_rated_tags.csv' WITH CSV HEADER DELIMITER as 'E\t';

----команда выгрузки таблицы в файл

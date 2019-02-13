SELECT 'FIO: Bordacheva Yulia';

----Первый запрос

SELECT userid, rating FROM ratings WHERE rating = 3 LIMIT 10;

----Выбрала 10 записей из таблицы ratings

SELECT imdbId, movieId FROM links WHERE imdbId like '%42' AND movieId BETWEEN 100 and 1000 LIMIT 10;

 --------П1.2, выбрала из таблицы IMDBID которые оканчиваются на 42, и MovieID от 100 до 1000

 SELECT * FROM public.links INNER JOIN public.ratings ON links.movieid=ratings.movieid WHERE ratings.rating=5 LIMIT 10;
----- П2.1 выбрала из таблицы links все imdbid которым ставили рейтинг 5

SELECT count(movieId) FROM ratings WHERE rating = 0 LIMIT 10;

---------3.1 COUNT() Посчитать число фильмов без оценок


SELECT userId, AVG(rating) as avg_rating FROM public.ratings GROUP BY userId HAVING AVG(rating) > 5 LIMIT 10;
 ------- П3.2 вывести top-10 пользователей, у который средний рейтинг выше 3.5

 SELECT imdbid, movieid FROM links WHERE movieid IN (SELECT movieid FROM ratings GROUP BY ratings.movieid HAVING AVG (rating) > 3.5) LIMIT 10;
--------4.1 Подзапросы: достать любые 10 imbdId из links у которых средний рейтинг больше 3.5.

WITH tmp_table AS (SELECT userid FROM public.ratings GROUP BY userid HAVING COUNT(rating) > 10) SELECT AVG(rating) FROM public.ratings WHERE ratings.userid IN (SELECT userId FROM tmp_table) LIMIT 10;
---------4.2 Common Table Expressions: посчитать средний рейтинг по пользователям, у которых более 10 оценок.
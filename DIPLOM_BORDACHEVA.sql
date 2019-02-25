

SELECT airport_code, airport_name FROM airports WHERE airport_code LIKE 'SVO';
----1 запрос: найти полные названия аэропортов, у которых код аэропорта 'SVO'.


(SELECT ticket_no FROM ticket_flights WHERE fare_conditions LIKE 'Business' LIMIT 5) UNION (SELECT ticket_no FROM boarding_passes WHERE seat_no = '4' LIMIT 5);
------2 запрос, объединили в один столбец номера билетов пассажиров, которые пользовались бизнес-классом и сидели на месте №4


SELECT a.aircraft_code, a.model, s.seat_no, s.fare_conditions FROM     aircrafts a JOIN seats s ON a.aircraft_code = s.aircraft_code WHERE    a.model = 'Боинг 737-300' ORDER BY s.seat_no DESC;

----- 3 запрос, вывод списка всех мест в салоне самолета БОИНГ 737-300Б пример объединения таблиц с помощью JOIN

SELECT   a.airport_code as code, a.airport_name, a.city, a.coordinates FROM     airports a WHERE    a.city IN (SELECT   aa.city FROM     airports aa GROUP BY aa.city HAVING   COUNT(*) > 1
         )
ORDER BY a.city, a.airport_code;
----- 4 запрос, вывод списка городов, которые имеют более одного аэропорта

SELECT   * FROM  bookings ORDER BY total_amount desc LIMIT 5;

---- 5 запрос, вывод списка бронирований с самой высокой стоимостью

SELECT ticket_no, passenger_id, passenger_name FROM   tickets WHERE  book_ref = '3B54BB';
 ----- 6 запрос, найти из каких билетов состоит бронирование 3B54BB

 SELECT   to_char(f.scheduled_departure, 'DD.MM.YYYY') AS when,
         f.departure_city || ' (' || f.departure_airport || ')' AS departure,
         f.arrival_city || ' (' || f.arrival_airport || ')' AS arrival,
         tf.fare_conditions AS class,
         tf.amount
FROM     ticket_flights tf
         JOIN flights_v f ON tf.flight_id = f.flight_id
WHERE    tf.ticket_no = '0005432537033'
ORDER BY f.scheduled_departure;
---7 запрос, из которого можно узнать, что пассажир Дарья Тихонова с номером билета 0005432537033 летала бизнес классом из Южно-Сахалинска в Сочи с пересадкой в Москве, поэтому у нее дорогая бронь

WITH tmp_table AS (SELECT fare_conditions, amount FROM ticket_flights WHERE amount < 50000.00) SELECT fare_conditions, COUNT(amount) as num_of_tickets FROM tmp_table GROUP BY fare_conditions;
----- 8 запрос как пример использования обобщенных табличных выражений, который выводит количество билетов каждого класса, цена которых ниже 50000 рублей

SELECT model FROM aircrafts WHERE range < (SELECT AVG(range) FROM aircrafts);
------ 9 запрос, пример подзапроса, с помошью которого вывели модели самолетов, у которых дальность полетов была меньше средней по таблице

SELECT fare_conditions, seat_no, COUNT(seat_no)OVER (PARTITION BY fare_conditions) AS number_seats_in_class FROM seats WHERE fare_conditions = 'Business' LIMIT 1;
----- 10 запрос, с использованием оконных функций, в котором мы нашли общее количество мест в бизнес классе, которое равно 152.

SELECT *, ROW_NUMBER() OVER (ORDER BY range DESC) AS numb FROM aircrafts WHERE range > 1000 ORDER BY numb;

----- 11 запрос, с использованием ROW Number, коотрый вывел список самолетов, которые пролетели юолее длянную дистанцию в нумерованном порядке по убыванию, в список попали только самолеты, у которых налет более 1000 км.

SELECT book_date, total_amount, MIN(total_amount) OVER (ORDER BY total_amount) AS min_amount FROM bookings WHERE total_amount > 10000;
----- 12 запрос, который вывел даты, в которые цена бронирования была минимальной, для диапазона цен от 10000






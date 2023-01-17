/* New table TRIP */

SELECT name, city, per_diem, date_first, date_last
FROM trip
WHERE name LIKE '%а %'
ORDER BY date_last DESC;

SELECT name FROM trip
WHERE city = 'Москва'
GROUP BY name
ORDER BY 1;

SELECT city, count(city) 'Количество'
FROM trip
GROUP BY 1
ORDER BY 1;


/* Using LIMIT condition */
SELECT city, count(city) 'Количество'
FROM trip
GROUP BY city
ORDER BY Количество DESC
LIMIT 2;


/* Using DATEDIFF condition */
SELECT name, city, DATEDIFF(date_last, date_first) + 1 'Длительность'
FROM trip
WHERE city NOT IN ('Москва', 'Санкт-Петербург')
ORDER BY 3 DESC;

SELECT name, city, date_first, date_last
FROM trip
WHERE DATEDIFF(date_last, date_first)+1 = (SELECT min(DATEDIFF(date_last, date_first)+1) FROM trip);


/* Using MONTH condition */
SELECT name, city, date_first, date_last
FROM trip
WHERE MONTH(date_last) = MONTH(date_first)
ORDER BY city, name;


/* Using MONTHNAME condition */
SELECT MONTHNAME(date_first) 'Месяц', count(name) 'Количество' FROM trip
GROUP BY 1
ORDER BY 2 DESC, 1;

SELECT name, city, date_first, per_diem * (DATEDIFF(date_last, date_first)+1) 'Сумма'
FROM trip
WHERE MONTH(date_first) IN (2, 3)
ORDER BY 1, Сумма DESC;

SELECT name, sum(per_diem*(DATEDIFF(date_last, date_first)+1)) 'Сумма'
FROM trip
GROUP BY name
HAVING count(name) > 3
ORDER BY Сумма DESC;

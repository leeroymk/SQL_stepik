/* New table TRIP */
CREATE TABLE trip
(
trip_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30),
city VARCHAR(25),
per_diem DECIMAL(8,2),
date_first DATE,
date_last DATE
);

INSERT INTO trip VALUES
("1", "Баранов П.Е.", "Москва", "700", "2020-01-12", "2020-01-17"),
("2", "Абрамова К.А.", "Владивосток", "450", "2020-01-14", "2020-01-27"),
("3", "Семенов И.В.", "Москва", "700", "2020-01-23", "2020-01-31"),
("4", "Ильиных Г.Р.", "Владивосток", "450", "2020-01-12", "2020-02-02"),
("5", "Колесов С.П.", "Москва", "700", "2020-02-01", "2020-02-06"),
("6", "Баранов П.Е.", "Москва", "700", "2020-02-14", "2020-02-22"),
("7", "Абрамова К.А.", "Москва", "700", "2020-02-23", "2020-03-01"),
("8", "Лебедев Т.К.", "Москва", "700", "2020-03-03", "2020-03-06"),
("9", "Колесов С.П.", "Новосибирск", "450", "2020-02-27", "2020-03-12"),
("10", "Семенов И.В.", "Санкт-Петербург", "700", "2020-03-29", "2020-04-05"),
("11", "Абрамова К.А.", "Москва", "700", "2020-04-06", "2020-04-14"),
("12", "Баранов П.Е.", "Новосибирск", "450", "2020-04-18", "2020-05-04"),
("13", "Лебедев Т.К.", "Томск", "450", "2020-05-20", "2020-05-31"),
("14", "Семенов И.В.", "Санкт-Петербург", "700", "2020-06-01", "2020-06-03"),
("15", "Абрамова К.А.", "Санкт-Петербург", "700", "2020-05-28", "2020-06-04"),
("16", "Федорова А.Ю.", "Новосибирск", "450", "2020-05-25", "2020-06-04"),
("17", "Колесов С.П.", "Новосибирск", "450", "2020-06-03", "2020-06-12"),
("18", "Федорова А.Ю.", "Томск", "450", "2020-06-20", "2020-06-26"),
("19", "Абрамова К.А.", "Владивосток", "450", "2020-07-02", "2020-07-13"),
("20", "Баранов П.Е.", "Воронеж", "450", "2020-07-19", "2020-07-25");
SELECT * FROM trip;


/* Work with trip table */
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

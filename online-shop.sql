SELECT buy.buy_id, book.title, book.price, buy_book.amount
FROM client
JOIN buy USING(client_id)
JOIN buy_book USING(buy_id)
JOIN book USING(book_id)
WHERE client.name_client = 'Баранов Павел'
ORDER BY 1, 2;


SELECT author.name_author, book.title, count(buy_book.amount) Количество
FROM author
JOIN book USING(author_id)
LEFT JOIN buy_book USING(book_id)
GROUP BY author.name_author, book.title
ORDER BY 1, 2;


SELECT city.name_city, count(buy.buy_id) Количество
FROM city
JOIN client USING(city_id)
JOIN buy USING(client_id)
GROUP BY 1
ORDER BY 2 DESC, 1;


SELECT buy_id, date_step_end FROM step
JOIN buy_step USING(step_id)
WHERE step_id = 1 AND date_step_end  IS NOT NULL;


SELECT buy.buy_id, client.name_client, sum(buy_book.amount * book.price) AS Стоимость FROM book
JOIN buy_book USING(book_id)
JOIN buy USING(buy_id)
JOIN client USING(client_id)
GROUP BY 1
ORDER BY 1;


SELECT buy_step.buy_id, step.name_step FROM step
JOIN buy_step USING(step_id)
WHERE buy_step.date_step_beg IS NOT NULL AND buy_step.date_step_end IS NULL
ORDER BY 1;


SELECT buy.buy_id,
DATEDIFF(buy_step.date_step_end, buy_step.date_step_beg) Количество_дней ,
IF(DATEDIFF(buy_step.date_step_end, buy_step.date_step_beg) > city.days_delivery,
DATEDIFF(buy_step.date_step_end, buy_step.date_step_beg) - city.days_delivery, 0) Опоздание
FROM city JOIN client USING(city_id)
JOIN buy USING(client_id)
JOIN buy_step USING(buy_id)
JOIN step USING(step_id)
WHERE step.name_step = 'Транспортировка' AND buy_step.date_step_end;


SELECT DISTINCT client.name_client FROM author
JOIN book USING(author_id)
JOIN buy_book USING(book_id)
JOIN buy USING(buy_id)
JOIN client USING(client_id)
WHERE author.name_author LIKE 'Достоевский%'
ORDER BY 1;

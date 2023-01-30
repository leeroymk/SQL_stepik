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
INSERT INTO client(name_client, city_id, email)
SELECT 'Попов Илья', city_id, 'popov@test'
FROM city
WHERE name_city = 'Москва';


INSERT INTO buy (buy_description, client_id)
SELECT 'Связаться со мной по вопросу доставки', client_id
FROM client
WHERE name_client = 'Попов Илья';


INSERT INTO buy_book(buy_id, book_id, amount)
SELECT 5, book_id, 2
FROM book JOIN author USING(author_id)
WHERE title = 'Лирика' AND name_author LIKE 'Пастернак%';
INSERT INTO buy_book(buy_id, book_id, amount)
SELECT 5, book_id, 1
FROM book JOIN author USING(author_id)
WHERE title = 'Белая гвардия' AND name_author LIKE 'Булгаков%';


UPDATE book JOIN buy_book USING(book_id)
SET book.amount = book.amount - buy_book.amount
WHERE buy_id = 5;


CREATE TABLE buy_pay AS
SELECT title, name_author, price, buy_book.amount, price * buy_book.amount Стоимость
FROM author
JOIN book USING(author_id)
JOIN buy_book USING(book_id)
WHERE buy_id = 5
ORDER BY title;
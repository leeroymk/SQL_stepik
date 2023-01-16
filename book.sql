/* step 1.1.8 - Create table */
CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);


/* step 1.1.9 - Fill attributes */
INSERT INTO book(title, author, price, amount)
VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3)


/* step 1.1.10 - Fill more attributes */
INSERT INTO book(title, author, price, amount) VALUES 
('Белая гвардия', 'Булгаков М.А.', 540.50, 5),
('Идиот', 'Достоевский Ф.М.', 460.00, 10),
('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2);


/* Selection */
SELECT * FROM book

SELECT author, title, price FROM book


/* Selection with rename*/
SELECT title AS Название, author AS Автор FROM book


/* Create one more column with new value(1.65* amount) */
SELECT title, amount, 1.65 * amount AS pack FROM book


/* Create column with ROUND */
SELECT title, author, amount, ROUND((0.7 * price), 2) AS new_price FROM book

/* Create column with ROUND and 2 IF conditions */
SELECT author, title, 
ROUND(IF(author='Есенин С.А.', price*1.05, IF(author='Булгаков М.А.', price*1.1, price)), 2) AS new_price 
FROM book

/* Using WHERE condition */
SELECT author, title, price FROM book WHERE amount < 10

/* Using WHERE condition with AND, OR operators*/
SELECT title, author, price, amount 
FROM book 
WHERE (price > 600 OR price < 500) AND amount * price >= 5000


/* Using BETWEEN condition */
SELECT title, author FROM book WHERE (price BETWEEN 540.50 AND 800) AND amount IN (2, 3, 5, 7)


/* Using sorting */
SELECT author, title FROM book WHERE amount BETWEEN 2 AND 14 ORDER BY author DESC, title


/* Using  % and _ for sorting*/
SELECT title, author FROM book WHERE title LIKE '%_ _%' AND author LIKE '%С.%' ORDER BY title


/* Using GROUP BY and DISTINCT condintions */
SELECT DISTINCT amount FROM book
SELECT amount FROM book GROUP BY amount


/* Using SUM and COUNT functions */
SELECT author AS Автор,
count(title) AS Различных_книг,
sum(amount) AS Количество_экземпляров 
FROM book GROUP BY author


/* Using MIN, MAX, AVG functions */
SELECT author, min(price) 'Минимальная_цена', 
max(price) 'Максимальная_цена', 
avg(price) 'Средняя_цена' 
FROM book GROUP BY author


/* Using various group functions */
SELECT author, sum(price*amount) 'Стоимость',
round(sum(price*amount)*0.18/(1.18), 2) 'НДС',
round(sum(price*amount)/1.18, 2) 'Стоимость_без_НДС'
FROM book
GROUP BY author


/* Using calculations through all table */
SELECT min(price) 'Минимальная_цена',
max(price) 'Максимальная_цена',
round(avg(price), 2) 'Средняя_цена'
FROM book

SELECT round(avg(price), 2) 'Средняя_цена',
sum(price*amount) 'Стоимость'
FROM book
WHERE amount BETWEEN 5 AND 14


/* порядок выполнения  SQL запроса на выборку на СЕРВЕРЕ: */
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY

MySQL: FROM => WHERE = SELECT = GROUP BY = HAVING = ORDER BY = LIMIT.   

PostgreSQL: FROM => WHERE = GROUP BY = HAVING = SELECT = DISTINCT = ORDER BY = LIMIT.


/* IMPORTANT ! */
SELECT author,
sum(price*amount) 'Стоимость'
FROM book
WHERE title NOT IN ('Идиот', 'Белая гвардия')
GROUP BY author
HAVING Стоимость > 5000
ORDER BY Стоимость DESC


/* Nested request */
SELECT author, title, price
FROM book
WHERE price < (SELECT avg(price) FROM book)
ORDER BY price DESC


SELECT author, title, amount FROM book
WHERE price IN (SELECT count(amount) = 1 FROM book));


SELECT author, title, amount FROM book
WHERE amount IN (SELECT amount FROM book GROUP BY amount HAVING count(amount) = 1)


SELECT author, title, price FROM book
WHERE price < ANY (SELECT min(price) FROM book
GROUP BY author);


SELECT title, author, amount, (SELECT max(amount) FROM book) - amount 'Заказ' 
FROM book
WHERE amount != (SELECT max(amount) FROM book)
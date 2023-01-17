/* Creating new table named "supply" */
CREATE TABLE supply(
supply_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR (50),
author VARCHAR (30),
price DECIMAL(8, 2),
amount INT);


/* Inserting new values */
INSERT INTO supply(title, author, price, amount)
VALUES
    ('Лирика', 'Пастернак Б.Л.', 518.99, 2),
    ('Черный человек', 'Есенин С.А.', 570.20, 6),
    ('Белая гвардия', 'Буглаков М.А.', 540.50, 7),
    ('Идиот', 'Достоевский Ф.М.', 360.80, 3);


/* Inserting values from supply to book */
INSERT INTO book(title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN ('Булгаков М.А.', 'Достоевский Ф.М.');

INSERT INTO book(title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN (SELECT DISTINCT author FROM book);


/* UPDATE table, setting new values */
UPDATE book
SET price = 0.9 * price
WHERE amount IN (5, 10);


/* UPDATE using IF */
UPDATE book
SET buy = IF(buy > amount, amount, buy),
price = IF(buy = 0, price * 0.9, price);


/* UPDATE using . */
UPDATE book, supply
SET book.amount = book.amount + supply.amount,
book.price = (book.price + supply.price) / 2
WHERE book.title = supply.title AND book.author = supply.author;


/* DELETE FROM some table */
DELETE
    FROM supply
    WHERE author IN (
        SELECT author
        FROM book
        GROUP BY author
        HAVING SUM(amount) > 10
);


/* CREATE TABLE using other table */
CREATE TABLE ordering AS
SELECT author, title, (SELECT ROUND(AVG(amount)) FROM book) AS amount
FROM book
WHERE amount < (SELECT AVG(amount) FROM book);


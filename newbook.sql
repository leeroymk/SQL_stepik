/* INNER JOIN */
SELECT title, name_genre, price
FROM genre INNER JOIN book
ON genre.genre_id = book.genre_id
WHERE amount > 8
ORDER BY price DESC;


/* LEFT JOIN */
SELECT name_genre
FROM genre LEFT JOIN book
ON genre.genre_id = book.genre_id
WHERE book.genre_id IS NULL;


/* CROSS JOIN */
SELECT name_city, name_author, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) 'Дата'
FROM city, author
ORDER BY 1, 3 DESC;


/* JOIN from 2 tables */
SELECT name_genre, title, name_author
FROM author JOIN book ON author.author_id = book.author_id
            JOIN genre ON book.genre_id = genre.genre_id
WHERE name_genre = 'Роман'
ORDER BY title;


SELECT name_author, sum(amount) Количество
FROM author LEFT JOIN book ON author.author_id = book.author_id
GROUP BY name_author
HAVING Количество < 10 or Количество IS NULL
ORDER BY 2
;


SELECT name_author
FROM book JOIN author ON book.author_id = author.author_id
GROUP BY name_author
HAVING COUNT(DISTINCT(genre_id)) = 1;


SELECT title, name_author, name_genre, price, amount FROM
genre JOIN book ON genre.genre_id = book.genre_id
      JOIN author on book.author_id = author.author_id
GROUP BY title, name_author, name_genre, price, amount, genre.genre_id
HAVING genre.genre_id IN
(SELECT all_genre.genre_id FROM
(SELECT genre_id, sum(amount) sum_amount
FROM book GROUP BY genre_id) all_genre
JOIN (SELECT genre_id, sum(amount) sum_amount FROM book
GROUP BY genre_id
ORDER BY sum_amount DESC
LIMIT 1) max_genre
ON all_genre.sum_amount = max_genre.sum_amount)
ORDER BY title;


/* using USING instead of ON */
SELECT title Название,
name_author Автор,
SUM(book.amount + supply.amount) Количество
FROM supply
JOIN book USING(title, price)
JOIN author USING(author_id)
GROUP BY author.name_author, book.title;
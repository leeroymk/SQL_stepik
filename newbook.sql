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
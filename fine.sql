/* Create table fine */
CREATE TABLE fine
(
    fine_id        INT PRIMARY KEY AUTO_INCREMENT,
    name           VARCHAR(30),
    number_plate   VARCHAR(6),
    violation      VARCHAR(50),
    sum_fine       DECIMAL(8, 2),
    date_violation DATE,
    date_payment   DATE
);

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES
       ('Баранов П.Е.', 'P523BT', 'Превышение скорости(от 40 до 60)', 500.00, '2020-01-12', '2020-01-17'),
       ('Абрамова К.А.', 'О111AB', 'Проезд на запрещающий сигнал', 1000.00, '2020-01-14', '2020-02-27'),
       ('Яковлев Г.Р.', 'T330TT', 'Превышение скорости(от 20 до 40)', 500.00, '2020-01-23', '2020-02-23'),
       ('Яковлев Г.Р.', 'M701AA', 'Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
       ('Колесов С.П.', 'K892AX', 'Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL),
       ('Баранов П.Е.', 'P523BT', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
       ('Абрамова К.А.', 'О111AB', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'T330TT', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);

CREATE TABLE traffic_violation
(
    violation_id INT PRIMARY KEY AUTO_INCREMENT,
    violation    VARCHAR(50),
    sum_fine     DECIMAL(8, 2)
);

INSERT INTO traffic_violation (violation, sum_fine)
VALUES ('Превышение скорости(от 20 до 40)', 500),
       ('Превышение скорости(от 40 до 60)', 1000),
       ('Проезд на запрещающий сигнал', 1000);

UPDATE fine f, traffic_violation tv
SET f.sum_fine = tv.sum_fine
WHERE f.sum_fine IS NULL AND f.violation = tv.violation;


/* Use GROUP BY for few columns */
SELECT name, number_plate, violation FROM fine
GROUP BY name, number_plate, violation
HAVING count(name) > 1
ORDER BY 1, 2, 3;

UPDATE fine,
    (SELECT name, number_plate, violation
     FROM fine
     GROUP BY name, number_plate, violation
     HAVING count(*) > 1) query_in
SET fine.sum_fine = fine.sum_fine * 2
WHERE (fine.violation, fine.name, fine.number_plate) =
      (query_in.violation, query_in.name, query_in.number_plate) AND
      fine.date_payment IS NULL;

UPDATE fine f, payment p
SET f.date_payment = if(f.date_payment IS NULL, p.date_payment, f.date_payment),
f.sum_fine = if(p.date_payment - p.date_violation <= 20, f.sum_fine / 2, f.sum_fine)
WHERE (f.name,f.number_plate,f.violation) = (p.name,p.number_plate,p.violation);

CREATE TABLE back_payment AS
SELECT name, number_plate, violation, sum_fine, date_violation FROM fine
WHERE fine.date_payment IS NULL;

DELETE FROM fine
WHERE date_violation < '2020-02-01';

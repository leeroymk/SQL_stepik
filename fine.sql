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

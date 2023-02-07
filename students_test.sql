SELECT name_student, date_attempt, result FROM student
JOIN attempt USING(student_id)
JOIN subject USING(subject_id)
WHERE name_subject = 'Основы баз данных'
ORDER BY result DESC;


SELECT name_subject,
count(attempt_id) Количество,
ROUND(AVG(result), 2) Среднее
FROM subject
LEFT JOIN attempt USING(subject_id)
GROUP BY name_subject
ORDER BY Среднее DESC;


SELECT name_student, result FROM student JOIN attempt USING(student_id)
HAVING result = (SELECT max(result) FROM attempt)
ORDER BY name_student;


SELECT name_student,
name_subject,
DATEDIFF(max(date_attempt), min(date_attempt)) Интервал
FROM subject
JOIN attempt USING(subject_id)
JOIN student USING(student_id)
GROUP BY name_student, name_subject
HAVING count(name_subject) > 1
ORDER BY Интервал;


SELECT name_subject, count(DISTINCT(student_id)) Количество
FROM attempt
RIGHT JOIN subject USING(subject_id)
GROUP BY name_subject
ORDER BY Количество DESC, name_subject;


SELECT question_id, name_question
FROM question
JOIN subject USING(subject_id)
WHERE name_subject = 'Основы баз данных'
ORDER BY RAND()
LIMIT 3;


SELECT name_question,
name_answer,
IF(is_correct=1, 'Верно', 'Неверно') Результат
FROM question
JOIN testing USING(question_id)
JOIN answer USING(answer_id)
WHERE attempt_id = 7;


SELECT name_student, name_subject, date_attempt, round(sum(is_correct)/3*100, 2) Результат
FROM attempt
JOIN student USING(student_id)
JOIN testing USING(attempt_id)
JOIN subject USING(subject_id)
JOIN answer USING(answer_id)
GROUP BY name_student, name_subject, date_attempt
ORDER BY name_student, date_attempt DESC;


SELECT name_subject,
CONCAT(LEFT(name_question, 30), '...') Вопрос,
count(testing_id) Всего_ответов,
ROUND(sum(is_correct)/count(testing_id)*100, 2) Успешность
FROM question
JOIN testing USING(question_id)
JOIN answer USING(answer_id)
JOIN subject USING(subject_id)
GROUP BY name_subject, Вопрос
ORDER BY name_subject, Успешность DESC, Вопрос;

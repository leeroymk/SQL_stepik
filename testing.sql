INSERT INTO attempt(student_id, subject_id, date_attempt)
SELECT student_id, subject_id, NOW()
FROM student, subject
WHERE name_student = 'Баранов Павел' AND name_subject = 'Основы баз данных';


INSERT INTO testing(attempt_id, question_id)
SELECT (SELECT MAX(attempt_id) FROM attempt), question_id
FROM attempt JOIN testing USING(attempt_id)
ORDER BY RAND()
LIMIT 3;


INSERT INTO testing(attempt_id, question_id)
SELECT (SELECT MAX(attempt_id) FROM attempt) max_attempt, question_id
FROM
(SELECT question_id FROM question
 WHERE subject_id = (SELECT subject_id FROM attempt
                     WHERE attempt_id = (SELECT MAX(attempt_id) FROM attempt))) q_id
ORDER BY RAND()
LIMIT 3;


UPDATE attempt
SET result = (SELECT ROUND(sum(is_correct)/3*100)
FROM testing JOIN answer USING(answer_id)
WHERE attempt_id = 8
GROUP BY attempt_id)
WHERE attempt_id = 8;

SELECT name_enrollee
FROM program JOIN program_enrollee USING(program_id)
JOIN enrollee USING(enrollee_id)
WHERE name_program = 'Мехатроника и робототехника'
ORDER BY 1;


SELECT name_program
FROM program_subject JOIN subject USING(subject_id)
JOIN program USING(program_id)
WHERE name_subject = 'Информатика'
ORDER BY 1 DESC;


SELECT name_subject,
COUNT(enrollee_id) Количество,
max(result) Максимум,
min(result) Минимум,
round(avg(result), 1) Среднее
FROM enrollee_subject JOIN subject USING(subject_id)
GROUP BY subject_id
ORDER BY name_subject;


SELECT name_program
FROM program JOIN program_subject USING(program_id)
GROUP BY name_program
HAVING min(min_result) >= 40
ORDER BY 1;


SELECT name_program, plan FROM program
WHERE plan = (SELECT max(plan) FROM program);


SELECT name_enrollee, IFNULL(sum(bonus), 0) Бонус
FROM achievement JOIN enrollee_achievement USING(achievement_id)
RIGHT JOIN enrollee USING(enrollee_id)
GROUP BY name_enrollee
ORDER BY name_enrollee;


SELECT name_department,
name_program,
plan,
count(enrollee_id) Количество,
ROUND(count(enrollee_id)/plan, 2) Конкурс
FROM department JOIN program USING(department_id)
JOIN program_enrollee USING(program_id)
GROUP BY program_id
ORDER BY Конкурс DESC;


SELECT name_program
FROM program JOIN program_subject USING(program_id)
JOIN subject USING(subject_id)
WHERE name_subject IN ('Математика', 'Информатика')
GROUP BY name_program
HAVING count(name_subject) = 2
ORDER BY name_program;


SELECT name_program, name_enrollee, sum(result) itog
FROM enrollee JOIN program_enrollee USING(enrollee_id)
JOIN program USING(program_id)
JOIN program_subject USING(program_id)
JOIN subject USING(subject_id)
JOIN enrollee_subject USING(enrollee_id, subject_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC
;
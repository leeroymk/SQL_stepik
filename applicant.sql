CREATE TABLE applicant AS
SELECT program_id, enrollee_id, sum(result) itog
FROM enrollee JOIN program_enrollee USING(enrollee_id)
JOIN program USING(program_id)
JOIN program_subject USING(program_id)
JOIN subject USING(subject_id)
JOIN enrollee_subject USING(enrollee_id, subject_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC
;

DELETE FROM applicant
WHERE (program_id, enrollee_id) IN (SELECT program_id, enrollee_id
FROM enrollee JOIN program_enrollee USING(enrollee_id)
JOIN program USING(program_id)
JOIN program_subject USING(program_id)
JOIN subject USING(subject_id)
JOIN enrollee_subject USING(enrollee_id, subject_id)
WHERE result < min_result);


UPDATE applicant
JOIN (SELECT enrollee_id, IFNULL(sum(bonus), 0) Бонус
FROM achievement JOIN enrollee_achievement USING(achievement_id)
RIGHT JOIN enrollee USING(enrollee_id)
GROUP BY enrollee_id) t USING(enrollee_id)
SET itog = itog + Бонус;


CREATE TABLE applicant_order AS
SELECT * FROM applicant
ORDER BY program_id, itog DESC;

DROP TABLE applicant;


ALTER TABLE applicant_order ADD str_id INT FIRST;

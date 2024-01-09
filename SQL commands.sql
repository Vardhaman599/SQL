#1. Show first name, last name, and gender of patients whose gender is 'M'
select first_name ,last_name,gender from patients where gender='M';
#2. Show first name and last name of patients who do not have allergies.
select first_name ,last_name from patients where allergies is null;
#3. Show first name of patients that start with the letter 'C'
select first_name from patients where first_name LIKE 'C%';
#4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name,last_name from patients where weight between 100 AND 120;
#5 Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
SELECT patient_id,first_name,last_name,CASE WHEN allergies IS NULL THEN 'NKA'ELSE allergies END AS allergies FROM patients;
#6. Show first name and last name concatenated into one column to show their full name.
select CONCAT(first_name,'',last_name)AS full_name from patients;
#7. Show first name, last name, and the full province name of each patient
SELECT patients.first_name, patients.last_name,province_names.province_name
FROM patients
JOIN province_names ON patients.province_id = province_names.province_id;
#8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS patient_count FROM patients WHERE YEAR(birth_date) = 2010;
#9. Show the first_name, last_name, and height of the patient with the greatest height
SELECT first_name, last_name, height FROM patients ORDER BY height DESC LIMIT 1;
#10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT * FROM patients WHERE patient_id IN (1, 45, 534, 879, 1000);
#11. Show the total number of admissions
SELECT COUNT(*) AS total_admissions FROM admissions;
#SELECT COUNT(DISTINCT patient_id) AS total_admissions FROM admissions;
#12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT * FROM admissions WHERE DATE(admission_date) = DATE(discharge_date);
#13. Show the total number of admissions for patient_id 579.
SELECT COUNT(*) AS total_admissions FROM admissions WHERE patient_id = 579;
#14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT city FROM patients WHERE province_id = 'NS';
#15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
SELECT first_name, last_name, birth_date FROM patients WHERE height > 160 AND weight > 70;
#16. Show unique birth years from patients and order them by ascending
SELECT DISTINCT YEAR(birth_date) AS birth_year FROM patients ORDER BY birth_year ASC;
#17 Show unique first names from the patients table which only occurs once in the list.
SELECT first_name FROM patients GROUP BY first_name HAVING COUNT(first_name) = 1;
#18. Show patient_id and first_name from patients where their first_name starts and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name FROM patients WHERE LENGTH(first_name) >= 6 AND LEFT(first_name, 1) = 's' AND RIGHT(first_name, 1) = 's';
#19. Show patient_id, first_name, last_name from patients whose diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
SELECT p.patient_id, p.first_name, p.last_name FROM patients p JOIN admissions a ON p.patient_id = a.patient_id WHERE a.diagnosis = 'Dementia';
#20. Display every patient's first_name. Order the list by the length of each name and then by alphabetically
SELECT first_name FROM patients ORDER BY LENGTH(first_name), first_name;
#21. Show the total number of male patients and the total number of female patients in the patients table. Display the two results in the same row.
SELECT
    (SELECT COUNT(*) FROM patients WHERE gender = 'M') AS Male_count,
    (SELECT COUNT(*) FROM patients WHERE gender = 'F') AS Female_count;
#22. Show the total number of male patients and the total number of female patients in the patients table. Display the two results in the same row.
SELECT
    (SELECT COUNT(*) FROM patients WHERE gender = 'M') AS Male_count,
    (SELECT COUNT(*) FROM patients WHERE gender = 'F') AS Female_count;
#23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis, COUNT(*) AS admission_count FROM admissions GROUP BY patient_id, diagnosis HAVING COUNT(*) > 1;
#24 Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending
SELECT city, COUNT(*) AS total_patients FROM patients GROUP BY city ORDER BY total_patients DESC, city ASC;
#25. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;
#26. Show all allergies ordered by popularity. Remove NULL values from the query.
SELECT allergies, COUNT(*) AS diagnosis FROM patients WHERE allergies IS NOT NULL GROUP BY allergies ORDER BY diagnosis DESC;
#27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date FROM patients WHERE year(birth_date) BETWEEN 1970 AND 1979 ORDER BY birth_date ASC;
#28. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order thelist by the first_name in descending order
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format FROM patients ORDER BY first_name DESC;
#29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT pr.province_id, SUM(pa.height) AS height FROM province_names pr JOIN patients pa ON pr.province_id = pa.province_id GROUP BY pr.province_id HAVING SUM(pa.height) >= 7000;
#30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT (MAX(weight) - MIN(weight)) AS weight_delta FROM patients WHERE last_name = 'Maroni';
#31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT day(admission_date) AS day_No,COUNT(patient_id)   AS No_of_admissions FROM admissions GROUP BY day_No ORDER BY No_of_admissions DESC;
#32. Show all of the patients grouped into weight groups. Show the total number of patients in each weight group. Order the list by the weight group descending. e.g. if they weigh 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT (weight / 10) * 10 AS weight_group, COUNT(*) AS patients_weight_group FROM patients GROUP BY weight_group ORDER BY weight_group DESC;
#33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
SELECT patient_id,weight,height,
       CASE
           WHEN weight / POWER(height / 100.00, 2) >= 30
               THEN 1
           ELSE 0
           END AS Isobese
FROM patients;
#34. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';
#35.All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.The password must be the following, in order:patient_id the numerical length of patient's last_name year of patient's birth_date
SELECT DISTINCT p.patient_id, CONCAT(a.patient_id, LENGTH(p.last_name), year(p.birth_date)) AS temp_password FROM patients p JOIN admissions a ON p.patient_id = a.patient_id;
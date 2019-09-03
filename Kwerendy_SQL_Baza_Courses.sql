SELECT * FROM module WHERE hours = 28;
SELECT * FROM course WHERE price>6000;
SELECT * FROM location WHERE postal_code LIKE '8%';
SELECT * FROM attendee WHERE PESEL LIKE '_5%6_';
SELECT * FROM course_status JOIN course ON course_status.id = course.course_status_id AND VALUE = 'W trakcie';
SELECT * FROM course
JOIN course_attendee ON course.id = course_attendee.course_id 
JOIN attendee ON course_attendee.attendee_id = attendee.id AND first_name = 'Anna';
SELECT DISTINCT name FROM module JOIN course ON module.course_id = course.id AND price > 5000;
SELECT * FROM city JOIN location ON city.id = location.city_id AND value = 'Łódź' AND street LIKE 'Prusa%';
SELECT * FROM module JOIN trainer ON trainer.id=module.trainer_id AND name='Projekt końcowy' and last_name NOT LIKE 'm%';
SELECT * FROM course_name, course, course_attendee, attendee WHERE course_name.id=course.course_name_id 
AND course.id=course_attendee.course_id AND course_attendee.attendee_id=attendee.id AND value = 'Tester Oprogramowania PRO';
SELECT * FROM course_name, course, module, trainer WHERE course_name.id = course.course_name_id = module.course_id 
AND module.trainer_id=trainer.id AND first_name = 'Sławomir';
SELECT * FROM city, location, course, course_name, course_status WHERE city.id=location.city_id=course.location_id 
AND course.course_name_id=course_name.id AND course_status.id=course.course_status_id and city.value= 'Gdańsk';
SELECT city.value as miasto, COUNT(course_name.value) as 'liczba kursów' FROM city
JOIN location ON city.id=location.city_id
JOIN course ON location.id=course.location_id
JOIN course_name ON course_name.id=course.course_name_id group by miasto;
SELECT * FROM attendee, course_attendee, course, city, location, course_name 
WHERE attendee.id=course_attendee.attendee_id AND course.location_id = location.id
AND course_attendee.course_id=course.id AND city.id=location.city_id AND course_name.id=course.course_name_id 
AND city.value='Gdańsk' GROUP BY course.code HAVING COUNT(attendee_id)>3;
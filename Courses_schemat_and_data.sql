
-- -----------------------------------------------------
-- Schema courses
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS courses;
CREATE SCHEMA IF NOT EXISTS courses;
USE courses;

-- -----------------------------------------------------
-- Table attendee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS attendee (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  pesel VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table city
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS city (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  value VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table location
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS location (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL UNIQUE,
  postal_code VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (city_id) REFERENCES city (id)
);



-- -----------------------------------------------------
-- Table course_status
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS course_status (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  value VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table course_name
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS course_name (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  value VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

-- -----------------------------------------------------
-- Table course
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS course (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL UNIQUE,
  price DECIMAL(8,2) NOT NULL,
  course_name_id BIGINT(20) NOT NULL,
  course_status_id BIGINT(20) NOT NULL,
  location_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (location_id) REFERENCES location (id),
  FOREIGN KEY (course_status_id) REFERENCES course_status (id),
  FOREIGN KEY (course_name_id) REFERENCES course_name (id)
  );


-- -----------------------------------------------------
-- Table trainer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trainer (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  pesel VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table module
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS module (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  hours INT(11) NOT NULL,
  name VARCHAR(255) NOT NULL,
  course_id BIGINT(20) NOT NULL,
  trainer_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (course_id) REFERENCES course (id),
  FOREIGN KEY (trainer_id) REFERENCES trainer (id)
);


-- -----------------------------------------------------
-- Table classes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS classes (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  end DATETIME(6) NOT NULL,
  start DATETIME(6) NOT NULL,
  module_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (module_id) REFERENCES module (id)
);


-- -----------------------------------------------------
-- Table course_attendee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS course_attendee (
  course_id BIGINT(20) NOT NULL,
  attendee_id BIGINT(20) NOT NULL,
  FOREIGN KEY (course_id) REFERENCES course (id),
  FOREIGN KEY (attendee_id)  REFERENCES attendee (id)
);



-- -----------------------------------------------------
-- Table questionnaire
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS questionnaire (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  date DATE NOT NULL,
  attendee_id BIGINT(20) NOT NULL,
  module_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (module_id) REFERENCES module (id),
  FOREIGN KEY (attendee_id) REFERENCES attendee (id)
);


-- -----------------------------------------------------
-- Table open_question
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS open_question (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  answer VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  questionnaire_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (id)
);


-- -----------------------------------------------------
-- Table presence
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS presence (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  date DATE NOT NULL,
  type VARCHAR(255) NOT NULL,
  attendee_id BIGINT(20) NOT NULL,
  classes_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (attendee_id) REFERENCES attendee (id),
  FOREIGN KEY (classes_id) REFERENCES classes (id)
);


-- -----------------------------------------------------
-- Table rating_question
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS rating_question (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) NOT NULL,
  value INT(11) NOT NULL,
  questionnaire_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (id)
);


INSERT INTO city (id, value) VALUES (1, 'Gdańsk');
INSERT INTO city (id, value) VALUES (2, 'Łódź');
INSERT INTO city (id, value) VALUES (3, 'Poznań');
INSERT INTO city (id, value) VALUES (4, 'Warszawa');

INSERT INTO course_status (id, value) VALUES (1, 'Utworzony');
INSERT INTO course_status (id, value) VALUES (2, 'W trakcie');
INSERT INTO course_status (id, value) VALUES (3, 'Zakończony');

INSERT INTO course_name (id, value) VALUES (1, 'Tester Oprogramowania PRO');
INSERT INTO course_name (id, value) VALUES (2, 'Tester Automatyzujący');
INSERT INTO course_name (id, value) VALUES (3, 'Programista Java Back-End');

INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (1, 'Jan', 'Nowak', '24080498366');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (2, 'Marian', 'Kowalski', '09271590144');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (3, 'Monika', 'Janczewska', '47030201713');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (4, 'Maria', 'Czesieczkowska', '59031810795');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (5, 'Ewelina', 'Czernik', '68081780154');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (6, 'Tomasz', 'Rychlik', '05040955767');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (7, 'Jakub', 'Grabowicz', '65081642163');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (8, 'Przemysław', 'Jelonek', '73052959363');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (9, 'Justyna', 'Kilikowski', '82102705087');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (10, 'Katarzyna', 'Rogala', '66101198475');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (11, 'Jacek', 'Budkiewicz', '48010802889');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (12, 'Robert', 'Mickiewicz', '91011655000');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (13, 'Cezary', 'Maciak', '78062149704');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (14, 'Anna', 'Dudek', '35062138499');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (15, 'Agata', 'Konopka', '87122785590');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (16, 'Jakub', 'Koper', '10100370684');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (17, 'Łukasz', 'Sochacki', '07210372888');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (18, 'Stefan', 'Nizołek', '01100288082');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (19, 'Joanna', 'Piasek', '08281069778');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (20, 'Jan', 'Micek', '28121190286');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (21, 'Michał', 'Kaźmierczak', '91120838440');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (22, 'Sylwester', 'Kołaczek', '81092380162');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (23, 'Sylwia', 'Banasiak', '12081660352');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (24, 'Tomasz', 'Nawrocki', '14071748583');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (25, 'Monika', 'Loewnau', '11031883704');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (26, 'Bolek', 'Palik', '04290144709');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (27, 'Maciej', 'Baton', '94040267705');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (28, 'Kamil', 'Banasiak', '21062383465');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (29, 'Iwona', 'Koter', '12041085388');
INSERT INTO attendee (id, first_name, last_name, pesel) VALUES (30, 'Anna', 'Kania', '01311515702');
              


INSERT INTO location (id, name, postal_code, street, city_id) VALUES (1, 'Prestige Lingua', '53-400', 'Grażyny 10/2', 1); 
INSERT INTO location (id, name, postal_code, street, city_id) VALUES (2, 'Budynek Netz', '53-400', 'Nad Stawem 7', 1); 
INSERT INTO location (id, name, postal_code, street, city_id) VALUES (3, 'Biurowiec XYZ', '88-000', 'Piłsudskiego 12', 2);
INSERT INTO location (id, name, postal_code, street, city_id) VALUES (4, 'Space for YOU', '89-200', 'Prusa 1/5', 2);
INSERT INTO location (id, name, postal_code, street, city_id) VALUES (5, 'CodeMasters', '33-888', 'Norwida 11/4', 4);
INSERT INTO location (id, name, postal_code, street, city_id) VALUES (6, 'Westin Space', '00-690', 'Wilcza 33', 4);

INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (1, 'TOPGDA01', 4990, 1, 2, 1);
INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (2, 'TOPGDA02', 4990, 1, 1, 2);
INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (3, 'TAGDA01', 8990, 2, 1, 2);
INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (4, 'PJBPGDA01', 10490, 3, 2, 2);
INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (5, 'PJBPGDA02', 10490, 3, 1, 2);
INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (6, 'TOPLDZ01', 4990, 1, 2, 3);
INSERT INTO course (id, code, price, course_name_id, course_status_id, location_id) VALUES (7, 'TOPWAW01', 4990, 1, 1, 5);


INSERT INTO course_attendee (course_id, attendee_id) VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8);
INSERT INTO course_attendee (course_id, attendee_id) VALUES (2,9),(2,10),(2,11),(2,12),(2,12);
INSERT INTO course_attendee (course_id, attendee_id) VALUES (3,12),(3,13),(3,14);
INSERT INTO course_attendee (course_id, attendee_id) VALUES (4,15),(4,16),(4,17),(4,18),(4,19),(4,20),(4,21),(4,22);
INSERT INTO course_attendee (course_id, attendee_id) VALUES (6,23),(6,24),(6,25),(6,26);
INSERT INTO course_attendee (course_id, attendee_id) VALUES (7,27),(7,28),(7,29);

INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (1, 'Michał', 'Michalski', '11111111111');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (2, 'Szymon', 'Kowalski', '22222222222');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (3, 'Jeremiasz', 'Cebula', '33333333333');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (4, 'Stefan', 'Telefan', '44444444444'); 
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (5, 'Jolanta', 'Kulig', '55555555555'); 
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (6, 'Zofia', 'Macocha', '66666666666'); 

INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (7, 'Jan', 'Przebiegły', '11111111188');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (8, 'Monika', 'Szczypior', '22222222288');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (9, 'Czesław', 'Miłosz', '33333333388');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (10, 'Adam', 'Sienkiewicz', '44444444488'); 
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (11, 'Anna', 'Jantar', '55555555588'); 
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (12, 'Klaudiusz', 'Żmuda', '66666666688'); 

INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (13, 'Sławomir', 'Kołaczek', '11111119999');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (14, 'Bożena', 'Migdal', '22222229999');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (15, 'Bolesław', 'Czażasty', '33333339999');
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (16, 'Leszek', 'Kwaśniewski', '44444449999'); 
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (17, 'Józef', 'Marszałek', '55555559999'); 
INSERT INTO trainer (id, first_name, last_name, pesel) VALUES (18, 'Irena', 'Potęga', '66666669999'); 

INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (1, 14, 'Podstawy testowania', 1, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (2, 14, 'Techniki projektowania testów', 1, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (3, 14, 'Dobre praktyki testowania', 1, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (4, 14, 'Bazy danych dla testerów', 1, 2);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (5, 14, 'Web API', 1, 3);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (6, 28, 'Projekt końcowy', 1, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (7, 10, 'Drzwi do kariery', 1, 6);

INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (8, 14, 'Podstawy testowania', 2, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (9, 14, 'Techniki projektowania testów', 2, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (10, 14, 'Dobre praktyki testowania', 2, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (11, 14, 'Bazy danych dla testerów', 2, 2);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (12, 14, 'Web API', 2, 3);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (13, 28, 'Projekt końcowy', 2, 1);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (14, 10, 'Drzwi do kariery', 2, 6);

INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (15, 14, 'Podstawy testowania', 6, 7);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (16, 14, 'Techniki projektowania testów', 6, 7);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (17, 14, 'Dobre praktyki testowania', 6, 9);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (18, 14, 'Bazy danych dla testerów', 6, 10);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (19, 14, 'Web API', 6, 10);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (20, 28, 'Projekt końcowy', 6, 11);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (21, 10, 'Drzwi do kariery', 6, 12);

INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (22, 14, 'Podstawy testowania', 7, 14);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (23, 14, 'Techniki projektowania testów', 7, 13);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (24, 14, 'Dobre praktyki testowania', 7, 14);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (25, 14, 'Bazy danych dla testerów', 7, 17);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (26, 14, 'Web API', 7, 17);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (27, 28, 'Projekt końcowy', 7, 14);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (28, 10, 'Drzwi do kariery', 7, 18);


INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (29, 7, 'Narzędzia rozwoju oprogramowania', 3, 2);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (30, 42, 'Programowanie Java', 3, 3);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (31, 28, 'Automatyzacja Web API', 3, 4);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (32, 28, 'Atomatyzacja UI', 3, 3);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (33, 14, 'Automatyzacja integracji', 3, 4);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (34, 14, 'Ciągła integracja', 3, 5);
INSERT INTO module (id, hours, name, course_id, trainer_id) VALUES (35, 10, 'Drzwi do kariery', 3, 6);

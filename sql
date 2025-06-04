CREATE DATABASE EVALUATION;

CREATE TABLE company (
AFM CHAR(9) DEFAULT 'unknown' NOT NULL,
DOY VARCHAR(15) DEFAULT 'unknown' NOT NULL,
name VARCHAR(35) DEFAULT 'unknown' NOT NULL,
phone BIGINT(16) NOT NULL,
street VARCHAR(15) DEFAULT 'unknown' NOT NULL,
num TINYINT(4) NOT NULL,
city VARCHAR(15) DEFAULT 'unknown' NOT NULL,
country VARCHAR(15) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY(AFM)
);

CREATE TABLE user (
username VARCHAR(12) DEFAULT 'unknown' NOT NULL,
password VARCHAR(10) NOT NULL,
name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
surname VARCHAR(35) DEFAULT 'unknown' NOT NULL,
reg_date DATETIME NOT NULL,
email VARCHAR(30) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY(username)
);

CREATE TABLE manager (
managerUsername VARCHAR(12) DEFAULT 'unknown' NOT NULL,
exp_years TINYINT(4) NOT NULL,
firm CHAR(9) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY(managerUsername),
CONSTRAINT a1
FOREIGN KEY(managerUsername) REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT a2
FOREIGN KEY(firm) REFERENCES company(AFM)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE evaluator (
username VARCHAR(12) NOT NULL,
ev_id INT NOT NULL,
exp_years TINYINT(4) NOT NULL,
firm CHAR(9) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY (username,ev_id),
CONSTRAINT EVALUATES
FOREIGN KEY(username) REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT EVALUATES2
FOREIGN KEY(firm) REFERENCES company(AFM)
);

CREATE TABLE employee(
username VARCHAR(12) NOT NULL,
bio TEXT NOT NULL,
sistatikes VARCHAR(35) DEFAULT 'unknown',
certificates VARCHAR(35) DEFAULT 'unknown' ,
awards VARCHAR(35) DEFAULT 'unknown' ,
PRIMARY KEY(username),
CONSTRAINT h1
FOREIGN KEY (username) REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE languages(
employee VARCHAR(12) NOT NULL,
lang SET('EN','FR','SP','GR') NOT NULL,
PRIMARY KEY (employee,lang),
CONSTRAINT e1
FOREIGN KEY (employee) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE project(
empl VARCHAR(12) NOT NULL,
num TINYINT(4) NOT NULL AUTO_INCREMENT,
descr TEXT NOT NULL,
url VARCHAR(60) NOT NULL,
PRIMARY KEY(num, empl), 
CONSTRAINT fk4
FOREIGN KEY (empl) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE degree(
titlos VARCHAR(50) NOT NULL,
idryma VARCHAR(40) NOT NULL,
bathmida ENUM('LYKEIO','UNIV','MASTER','PHD'),
PRIMARY KEY(titlos,idryma)
);


CREATE TABLE has_degree (
degr_title VARCHAR(50) NOT NULL,
degr_idryma VARCHAR(40) NOT NULL,
empl_usrname VARCHAR(12) NOT NULL,
etos year(4) ,
grade float (3,1) NOT NULL,
PRIMARY KEY (degr_title, degr_idryma, empl_usrname),
CONSTRAINT d1
FOREIGN KEY(degr_title,degr_idryma) REFERENCES degree(titlos,idryma)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT d2
FOREIGN KEY(empl_usrname) REFERENCES employee(username) 
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE job (
id int(4) NOT NULL,
start_date DATE  NOT NULL,
salary float(6,1) NOT NULL, 
position VARCHAR(40) NOT NULL,
edra VARCHAR(45) NOT NULL,
evaluator VARCHAR(12) NOT NULL,
announce_date DATETIME NOT NULL,
submission_date DATE NOT NULL ,
PRIMARY KEY(id),
CONSTRAINT j1 
FOREIGN KEY(evaluator) REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE request_evaluation(
emp_username VARCHAR (12) NOT NULL,
job_id INT(4) NOT NULL,
CONSTRAINT k1
PRIMARY KEY(emp_username,job_id),
FOREIGN KEY (emp_username) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT k2
FOREIGN KEY (job_id) REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE antikeim(
title VARCHAR(36) NOT NULL,
descr TINYTEXT NOT NULL,
belongs_to VARCHAR(36) ,
PRIMARY KEY (title),
CONSTRAINT q1 
FOREIGN KEY (belongs_to) REFERENCES antikeim(title)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE needs (
job_int int(4) NOT NULL,
antikeim_title VARCHAR(36) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY (job_int, antikeim_title),
CONSTRAINT b1
FOREIGN KEY(job_int) REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT b2
FOREIGN KEY(antikeim_title) REFERENCES antikeim(title)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE interview(
eval_name VARCHAR(12) NOT NULL,
emp_name VARCHAR(12) NOT NULL,
int_grade ENUM('0','1','2','3','4') ,
job_id INT(4) NOT NULL,
PRIMARY KEY(eval_name,int_grade),
CONSTRAINT l1
FOREIGN KEY (eval_name) REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT l2
FOREIGN KEY (emp_name) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT l3
FOREIGN KEY(job_id) REFERENCES job(id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE general_eval(
ev_username VARCHAR(12) NOT NULL,
em_username VARCHAR(12) NOT NULL,
job_id INT(4) NOT NULL,
vathmos ENUM('0','1','2'),
PRIMARY KEY (vathmos, em_username),
CONSTRAINT o1
FOREIGN KEY (ev_username) REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT o2
FOREIGN KEY (em_username) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT o3
FOREIGN KEY (job_id) REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE evaluationresult(
EvId int NOT NULL,
empl_username VARCHAR(12) NOT NULL,
job_id int(4) NOT NULL, 
grade int(4) NOT NULL, 
comments VARCHAR(255) DEFAULT 'unknown' ,
evusername VARCHAR(12) NOT NULL,
PRIMARY KEY(evid,empl_username),
CONSTRAINT c1
FOREIGN KEY(empl_username) REFERENCES employee(username) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT c2
FOREIGN KEY(job_id) REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT c3
FOREIGN KEY(evusername) REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE log (
praksi SET('eisagogi','diagrafi','enimerosi') ,
id_pr INT UNSIGNED NOT NULL AUTO_INCREMENT,
imerominia DATETIME,
username VARCHAR (12) NOT NULL,
PRIMARY KEY (id_pr),
CONSTRAINT w1
FOREIGN KEY (username) REFERENCES user(username)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE manager_report(
man_usrname VARCHAR(12) NOT NULL,
em_usr VARCHAR(12)NOT NULL,
report TEXT,
eval_us VARCHAR(12),
jobid INT(4),
report_score ENUM('0','1','2','3','4'),
PRIMARY KEY(em_usr,report_score),
CONSTRAINT p1
FOREIGN KEY (man_usrname) REFERENCES manager(managerUsername)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT p2
FOREIGN KEY (em_usr) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT p3 
FOREIGN KEY (eval_us) REFERENCES evaluator(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT p4
FOREIGN KEY (jobid) REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE evaluation_process(
mpl_us VARCHAR(12) NOT NULL,
j_id INT(4) NOT NULL,
evltr_us VARCHAR(12) NOT NULL,
evltr_id INT NOT NULL,
i_grade ENUM('0','1','2','3','4'),
em_report ENUM('0','1','2','3','4'),
g_vathmos ENUM('0','1','2'),
PRIMARY KEY(mpl_us,evltr_id),
CONSTRAINT z1 
FOREIGN KEY (mpl_us) REFERENCES employee(username)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT z2
FOREIGN KEY (j_id) REFERENCES job(id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT z3
FOREIGN KEY (evltr_us,evltr_id) REFERENCES evaluator(username,ev_id)
ON DELETE CASCADE ON UPDATE CASCADE
);


//////////PROCEDURES////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DELIMITER $
CREATE PROCEDURE telikos_bathmos(IN jb_ID INT(4), IN evl_ID INT(4))
BEGIN
DECLARE grade1 INT;
DECLARE grade2 INT;
DECLARE grade3 INT;
DECLARE f_grade INT;
DECLARE sum INT;
SELECT i_grade,em_report,g_vathmos 
INTO grade1,grade2,grade3
FROM evaluation_process
WHERE j_id=jb_ID AND evltr_id=evl_ID;
SELECT grade INTO f_grade FROM evaluationresult;
SET sum=grade1+grade2+grade3;
IF (grade1 IS NULL OR grade2 IS NULL OR grade3 IS NULL )
THEN
SELECT ‘This evaluation is not finished.’;
ELSE
INSERT INTO evaluationresult(grade) values (@sum);
END IF;
END $
DELIMITER ;



DELIMITER $

CREATE PROCEDURE eleghos_aksiologisis(IN idjob INT(4))
BEGIN
SET @evaluations=(SELECT COUNT(*) FROM evaluationresult);
SELECT @evaluations WHERE job_id=idjob;
SET @requests=(SELECT COUNT(*) FROM request_evaluation);
SELECT @requests WHERE job_id=idjob;
IF (@evaluations=@requests)
THEN
SELECT empl_username,grade FROM evaluationresult AS Teliki_Aksiologisi WHERE job_id=idjob
ORDER BY grade DESC;
ELSEIF (@evaluations < @requests)
THEN
SELECT empl_username,grade FROM evaluationresult WHERE job_id=idjob
ORDER BY grade DESC;
SET @evaluations_in_proc=@requests-@evaluations;
SELECT ‘Apomenoun:’, @evaluations_in_proc, ‘aksiologiseis.’;
ELSE 
SELECT ‘Den iparxoun ipopsifioi.’;
END IF;
END$
DELIMITER ;

DELIMITER $
CREATE PROCEDURE aithsh(IN u_name VARCHAR(25),IN u_surname VARCHAR(25))
BEGIN
DECLARE ev_name VARCHAR(12);
DECLARE ev_surname VARCHAR(12);
DECLARE ait_username VARCHAR(12);
DECLARE finidhedFlag1 INT;
DECLARE finishedFlag2 INT;
DECLARE grade INT;
SELECT username INTO ait_username
FROM user
WHERE u_name=name AND u_surname=surname;
SELECT job_id,grade FROM requestevaluation
WHERE empl_usname=ait_username;
IF (evaluationresult.grade IS NULL)
THEN
SELECT ‘Evaluation in progress’;
SELECT grade,comments,EvId FROM evaluationresult
WHERE empl_username=ait_username;
DECLARE obi_wan_kenobi CURSOR FOR
SELECT evusername FROM evaluationresult  WHERE ait_username=empl_usname;
DECLARE CONTINUE FOR NOT FOUND SET finishedFlag=1;
OPEN obi_wan_kenobi;
SET finishedFlag=0;
FETCH obi_wan_kenobi INTO new.evusername;
WHILE (finishedFlag1=0) DO
SELECT new.evaluator AS ’Aksiologitis’;
FETCH obi-wan_kenobi new.evusername;
BEGIN
DECLARE kylo_ren CURSOR FOR
SELECT name ,surname FROM user WHERE new.evusername=username;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag2=1;
OPEN kylo_ren;
SET finishedFlag2=0;
FETCH kylo_ren INTO ev_name,ev_surname;
WHILE (finishedFlag2=0) DO
SELECT ev_name AS ‘Onoma Aksiologiti’,ev_surname AS ‘Eponimo Aksiologiti’;
FETCH kylo_ren INTO ev_name,ev_surname;
END WHILE;
CLOSE kylo_ren;
END;
END WHILE;
CLOSE obi_wan_kenobi;
END;
ELSE
SELECT grade,comments,EvId FROM evaluationresult
WHERE ait_username=empl_username;
BEGIN
DECLARE obi_wan_kenobi CURSOR FOR
SELECT evusername FROM evaluationresult
WHERE ait_username=empl_username;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag1=1;
OPEN obi_wan_kenobi;
SET finishedFlag1=0;
FETCH obi_wan_kenobi INTO new.evaluator;
WHILE (finisheFlag1=0) DO
SELECT new.evusername AS ‘Aksiologitis’;
FETCH obi_wan_kenobi INTO new.evusername;
BEGIN
DECLARE kylo_ren CURSOR FOR
SELECT name,surname FROM user
WHERE new.evusername=username;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlaf2=1;
OPEN kylo_ren;
SET finishedFlag2=0;
FETCH kylo_ren INTO ev_name,ev_surname;
WHILE (finishedFlag2=0) DO
SELECT ev_name AS ‘Onoma Aksiologiti’,ev_surname AS ‘Eponimo Aksiologiti’;
FETCH kylo_ren INTO ev_name,ev_surname;
END WHILE;
CLOSE kylo_ren;
END;
END WHILE;
CLOSE obi_wan_kenobi;
END;
END$
DELIMITER;




//////////TRIGGER/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DELIMITER $
CREATE TRIGGER eisagogi_igrd
AFTER INSERT ON interview
FOR EACH ROW
BEGIN
INSERT INTO evaluation_process(i_grade) SELECT int_grade FROM interview;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER eisagogi_gengrd
AFTER INSERT ON general_eval
FOR EACH ROW
BEGIN
INSERT INTO evaluation_proces(g_vathmos) SELECT vathmos FROM general_eval;
END $
DELIMITER ;


DELIMITER $
CREATE TRIGGER eisagogi_rgrd
AFTER INSERT ON manager_report
FOR EACH ROW
BEGIN
INSERT INTO evaluation_process(em_report) SELECT report_score FROM manager_report;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER epeksergasia_profil
BEFORE UPDATE ON manager
FOR EACH ROW
BEGIN
IF (manager.managerUsername <> administrators.username_admin)
THEN
SIGNAL SQLSTATE VALUE ‘45000’
SET MESSAGE_TEXT= ‘Attempted change is not allowed due to authorization protocol.’;
END IF;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER epeksergasia_profil1
BEFORE UPDATE ON evaluator
FOR EACH ROW
BEGIN
IF (evaluator.evaluator.username <> administrators.username_admin)
THEN
SIGNAL SQLSTATE VALUE ‘45000’
SET MESSAGE_TEXT= ‘Attempted change is not allowed due to authorization protocol.’;
END IF;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER epeksergasia_profil2
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
IF (employee.username <> administrators.username_admin)
THEN
SIGNAL SQLSTATE VALUE ‘45000’
SET MESSAGE_TEXT= ‘Attempted change is not allowed due to authorization protocol.’;
END IF;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER epeksergasia_profil3
BEFORE UPDATE ON user
FOR EACH ROW
BEGIN
IF (user.username <> administrators.username_admin)
THEN
SIGNAL SQLSTATE VALUE ‘45000’
SET MESSAGE_TEXT= ‘Attempted change is not allowed due to authorization protocol.’;
END IF;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER  request_counter
AFTER INSERT ON request_evaluation
FOR EACH ROW 
BEGIN
SET @requests =@requests +1;
END$
DELIMITER ;


DELIMITER $
CREATE TRIGGER  evaluation_counter
AFTER INSERT ON evaluationresult
FOR EACH ROW 
BEGIN
SET @evaluations =@evaluations +1;
END$
DELIMITER ;

DELIMITER $
CREATE TRIGGER job_eisagogi
AFTER INSERT ON job
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘eisagogi’,NEW.id_pr,NOW(),NEW.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER job_enimerosi
AFTER UPDATE ON job
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘enimerosi’,NEW.id_pr,NOW(),NEW.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER job_diagrafi
AFTER DELETE ON job
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘diagrafi’,OLD.id_pr,NOW(),OLD.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER employee_eisagogi
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘eisagogi’,NEW.id_pr,NOW(),NEW.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER employee_enimerosi
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘enimerosi’,NEW.id_pr,NOW(),NEW.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER employee_diagrafi
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘diagrafi’,OLD.id_pr,NOW(),OLD.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER req_eval_eisagogi
AFTER INSERT ON requestevaluation
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘eisagogi’,NEW.id_pr,NOW(),NEW.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER req_eval_enimerosi
AFTER UPDATE ON requestevaluationi
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘enimerosi’,NEW.id_pr,NOW(),NEW.username);
END$

DELIMITER ;

DELIMITER $
CREATE TRIGGER req_eval_diagrafi
AFTER DELETE ON requestevaluation
FOR EACH ROW
BEGIN
INSERT INTO log (praksi,id_pr,imerominia,username) VALUES(‘diagrafi’,OLD.id_pr,NOW(),OLD.username);
END$

DELIMITER ;



///////////INSERT///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


INSERT INTO company VALUES
('123456789', 'A_Patrwn', 'Papadopoulos', 6912345678, 'Maizonos', 23, 'Patra', 'Greece')
('234567890', 'G_Patrwn', 'Grigoriou', 6923456789, 'Korinthou', 25, 'Patra', 'Greece')
('345678901', 'A_Patrwn', 'Dematoglou', 6934567890, 'Kanakari', 122, 'Patra', 'Greece')
('456789012', 'A_Patrwn', 'Karaiskakis', 6945678901, 'Gounari', 1, 'Patra', 'Greece')
('567890123', 'G_Patrwn', 'Basilopoulos', 6956789012, 'Roufou', 99, 'Patra', 'Greece')
('678901234', 'A_Patrwn', 'Alexandraki', 6967890123, 'Germanou', 57, 'Patra', 'Greece')
INSERT INTO manager VALUES               	
('PanGeor67', 7,'234567890')
('KatArg48', 6,'345678901')
('AlexKais867', 4,'567890123')
('ChrisKal77', 8,'567890123')
('PetAnag33', 6,'678901234')
('LoykTsip74', 5,'123456789')
('NikEyag939', 11,'678901234')
('KosLek11', 6,'678901234')
('GiorAnas66',7,'678901234')
('VasPreg34', 6,'234567890')
('SpyrKar57', 9,'456789012')
('GianChris832','6,123456789')
('DavArs345', 7,'345678901')


INSERT INTO evaluator VALUES
('GriBas45','4567',9,'678901234')
('BasGri54','5678',11,'567890123')
('EleBla99','6789',7,'456789012')

INSERT INTO employee VALUES
('AnasPet77','text','sistatikes',DEFAULT ,DEFAULT )
('LorPan80','text','sistatikes',DEFAULT ,DEFAULT )
('GiorKir83','text','sistatikes',DEFAULT ,DEFAULT )
('ProkIoan11','text','sistatikes','1st in Panel. Diag. Plirof. 2010')
('PanKar92','text','sistatike',DEFAULT ,DEFAULT )
('AntKan83','text','sistatikes',DEFAULT ,DEFAULT )
('StaKre442','text','sistatikes',DEFAULT ,DEFAULT )
('DimMar21','text','sistatikes','7th in ERL Prof. Maj. Tournam. 2017')
('MarKout12','text','sistatikes',DEFAULT ,DEFAULT )
('GiorAnas34','text','sistatikes','3th in ERL Prof. Maj. Tournam. 2018')


INSERT INTO degree VALUES
('apofoitos', '7o gel Patras', 'LYKEIO')
('apofoitos', '7o gel Patras', 'LYKEIO')
('apofoitos', '3o  gel Patras', 'LYKEIO')
('apofoitos', '1o gel Patras', 'LYKEIO')
('apofoitos', 'Athens College', 'LYKEIO')
('apofoitos', 'gel amfikleias', 'LYKEIO')
('apofoitos', '3o gel Chalandriou', 'LYKEIO')
('apofoitos', '4o gel Kalitheas', 'LYKEIO')
('apofoitos', '3o gel Alimou', 'LYKEIO')
('apofoitos', '1o gel Patras', 'LYKEIO')
('Elektrologon Michanikon kai Michanikon H/Y','Polytechnio Kritis','UNIV')
('Michanikon H/Y kai Pliroforikis','Panepistimio Patron','UNIV')
('Michanikon_H/Y kai Pliroforikis','Panepistimio Patron','UNIV')
('Michanikon_H/Y kai Pliroforikis','Panepistimio Ioanninon','UNIV')
('Michanikon_H/Y kai Pliroforikis','Panepistimio Patron','UNIV')
('Elektrologon_Michanikon_kai_Pliroforikis','Ethniko Metsobeio Polytechnio','UNIV')
('Chimiko', 'Aristoteleio','UNIV')
('Oikonomiko','Panepistimio Patron','UNIV')
('Oikonomiko','Panepistimio Peloponnisou','UNIV')
('Oikonomiko','Panepistimio Ioanninon','UNIV')
('MSc in Artificial Intelligence','University of Groningen','MASTER')
('MSc in Artificial Intelligence','University of Groningen','MASTER')
('MSc in Accounting and Financial Management','University of London','MASTER')
('MSc Diacheirisi anthropinou dinamikou','Manchester Metropolitan University','MASTER')
('MSc in Dioikisi anthropinou dinamikou','Nova Southeastern University','MASTER')
('Doctor of Management’,‘University of Warsaw','PHD')
('Ph.D. in Business & Management', 'ICN Business School','PHD')
('Master of Science in Robotics Engineering (EMARO+)','University Of Genoa','MASTER')
('Master of Science in Data Science','University Of London','MASTER')

INSERT INTO needs VALUES 
(1234, 'administrative secretary')
(2345, 'supervise hiring process')
(3456, 'data manager')


INSERT INTO antikeim VALUES
('data analyst','A data analyst is someone who scrutinises information using data analysis tools. The meaningful results they pull from the raw data help their employers or clients make important decisions by 
identifying various facts and trends.',)
('hr manage', 'Human resources managers supervise a company or organizations hiring process, from recruiting, interviewing, and hiring new staff.','executive manager' )
('sectretary', 'A Secretary, is responsible for facilitating communications within an office and fielding interactions with the public.','data analyst')
('executive manager','An executive manager is responsible for overseeing the operations and activities of a department',)

INSERT INTO project VALUES
('ProkIoan11', 1000,'description','url')
('DimMar21', 1010,'description','url')
('GiorAnas34', 1100,'description','url')

INSERT INTO languages VALUES
('AnasPet77', 'EN')
('AnasPet77', 'SP')
('LorPan80', 'EN')
('LorPan80', 'GR')
('GiorKir83','EN')
('ProkIoan11','EN')
('ProkIoan11','FR')
('ProkIoan11','GR')
('PanKar92','EN')
('PanKar92','FR')
('AntKan83','EN')
('StaKre442','EN')
('StaKre442','GR')
('DimMar21','EN')
('DimMar21','SP')
('DimMar21','GR')
('MarKout12','EN')
('GiorAnas34','EN')
('GiorAnas34','FR')

INSERT INTO user VALUES
('PanGeor67', '0000', 'Panagiotis', 'Georgiou', '2016-02-22 10:10:10.0', 'PanGeor67@yahoo.com')
('KatArg48', '010101', 'Katerina', 'Arguropoulou', '2017-05-22 10:10:10', 'KatArg48@hotmail.com')
('AlexKais867', '101010', 'Alexis', 'Kaisopoulos', '2017-12-21 10:10:10', 'AlexKais867@hotmail.com')
('ChrisKal77', '11001100', 'Chrstos', 'Kallidis', '2015-12-01 10:10:10', 'ChrisKal77@gmail.com')
('PetAnag33', '000111', 'Petros', 'Anagnostopoulos', '2018-05-14 10:10:10', 'PetAnag33@yahoo.com')
('LoykTsip74', '0101011', 'Loykas', 'Tsipianitis', '2016-12-03 10:10:10', 'LoykTsip74@yahoo.com')
('NikEyag939', '01010111', 'Niki','Eyaggelou', '2019-08-21 10:10:10', 'NikEyag939@hotmail.com')
('KosLek11'’, '1111110', 'Kostantinos', 'Lekkas', '2017-10-05 10:10:10', 'KosLek11@gmail.com')
('GiorAnas66', '0000001', 'Giorgos', 'Anastasopoulou', '2014-12-09 10:10:10', 'GiorAnas66@gmail.com')
('VasPreg34', '10101111', 'Vasilis', 'Pregas', '2016-12-23 10:10:10', 'VasPreg34@hotmail.com')
('SpyrKar57', '11100011', 'Spyridoula', 'Kara', '2013-05-21 10:10:10'), 'SpyrKar57@hotmail.com')
('GianChris832', '11001111','Giannis', 'Christoforou', '2016-06-21 10:10:10', 'GianChris832@gmail.com')
('DavArs345', '001', 'David', 'Arseniou', '2020-10-21 10:10:10', 'DavArs345@yahoo.com')
('GriBas45', '1111110', 'Grigoris', 'Basileiou', '2016-03-21 10:10:10', 'GriBas45@gmail.com')
('BasGri54', '11110', 'Basilis', 'Grigoriou', '2011-04-21 10:10:10', 'BasGri54@yahoo.com')
('EleBla99', '1110', 'Eleni', 'Blaxaki', '2016-05-21 10:10:10', 'EleBla99@yahoo.com')
('AnasPet77', '010', 'Anastasia', 'Petridou', '2012-06-21 10:10:10', 'AnasPet77@yahoo.com')
('LorPan80', '10101','Loredana' ,'Panteli', '2014-07-21 10:10:10', 'LorPan80@yahoo.com')
('GiorKir83', '1100010','Giorgos', 'Kiritsis', '2020-08-21 10:10:10', 'GiorKir83@hotmail.com')
('ProkIoan11', '101100111','Prokopis', 'Ioannou', '2018-11-21 10:10:10', 'ProkIoan11@hotmail.com')
('PanKar92', '00011110', 'Panagiota', 'Karadima', '2016-10-21 10:10:10', 'PanKar92@gmail.com')
('AntKan83', '110110', 'Antonis', 'Kanakidis', '2019-10-15 10:10:10', 'AntKan83@hotmail.com')
('StaKre442', '001100', 'Stamatia', 'Kremastinou', '2021-02-27 10:10:10', 'StaKre442@gmail.com')
('DimMar21', '1011110', 'Dimitris', 'Maragos', '2014-12-04 10:10:10', 'DimMar21@yahoo.com')
('MarKout12', '10101000', 'Maria', 'Kouti', '2019-12-11 10:10:10', 'MarKout12@gmail.com')
('GiorAnas34', '101011', 'Giorgos', 'Ansastasiou','2018-11-25 10:10:10', 'GiorAnas34@yahoo.com')

INSERT INTO has_degree VALUES
('apofoitos', '3o  gel Patras', 'AnasPet77',2003,18.3)
('Michanikon H/Y kai Pliroforikis', 'Panepistimio Patron','AnasPet77',2010,7.9)
('apofoitos', '7o gel Patras','LorPan80',2005,17.6)
('Chimiko', 'Aristoteleio','LorPan80', 2010,7.8)
('apofoitos', '3o gel Alimou','GiorKir83',2013,19.0)
('Oikonomiko', 'Panepistimio Patron','GiorKir83',2017,8.4)
('Ph.D. in Business & Management', 'ICN Business School','GiorKir83',2019,7.5)
('apofoitos', 'Athens College','ProkIoan11',2011,19.9)
('Michanikon_H/Y kai Pliroforikis', 'Panepistimio Patron','ProkIoan11',2016,8.4)
('Master of Science in Data Science','University Of London','ProkIoan11',2018,7.6)
('apofoitos', '1o gel Patras’,‘PanKar92',2007,17.9)
('Oikonomiko', 'Panepistimio Peloponnisou','UNIV','PanKar92',2013,7.8)
('Master of science Dioikisi anthropinou dinamikou','Nova Southeastern University','PanKar92',2015,8.7)
('apofoitos', '7o gel Patras’,’AntKan83',2006,18.7)
('Oikonomiko', 'Panepistimio Ioanninon','AntKan83',2011,7.5)
('MSc in Accounting and Financial Management','University of London','AntKan83',2013,7.8)
('Doctor of Management’,‘University of Warsaw','AntKan83',2019,8.8)
('apofoitos','gel amfikleias’,’StaKre442',2014,19.8)
('Elektrologon Michanikon kai Michanikon H/Y','Polytechnio Kritis','StaKre442',2020,8.5)
('apofoitos', '3o gel Chalandriou','DimMar21',2006,19.3)
('Michanikon_H/Y kai Pliroforikis', 'Panepistimio Patron','DimPar21',2012,8.8)
('MSc in Artificial Intelligence','University of Groningen','DimPar21',2014,8.6)
('Master of Science in Robotics Engineering (EMARO+)','University Of Genoa','DimPar21',2016,8.0)
('apofoitos', '4o gel Kalitheas','MarKout12',2014,18.8)
('Michanikon_H/Y kai Pliroforikis', 'Panepistimio Ioanninon', 'MarKout12',2020,7.5)
('apofoitos', '1o gel Patras','GiorAnas34',2006,19.7)
('Elektrologon_Michanikon_kai_Pliroforikis','Ethniko Metsobeio Polytechnio’,’GiorAnas34',2012,8.7)
('MSc in Artificial Intelligence','University of Groningen','GiorAnas34',2014,8.5)

INSERT INTO interview VALUES
('GriBas45', 'LorPan80','3')
('EleBla99', 'AnasPet77','2')
('EleBla99', 'ProkIoan11','4')
('BasGri54','PanKar92','1')

INSERT INTO request_evaluation VALUES
('LorPan80',1234)
('PanKar92',2345)
('Anaspet77',3456)
('ProkIoan11',3456)


INSERT INTO manager_report VALUES
('PetAnag','LorPan80','Text','GriBas45',1234,4)
('AlexKais867','PanKar92','Text','BasGri54',2345,2)
('SpyrKar57','AnasPet77','Text','EleBla99'',3456,2)
('SpyrKar57','ProkIoan11''Text','EleBla99',3456,3)

INSERT INTO general_eval VALUES
('GriBas45', 'LorPan80',1234 ,'1')
('EleBla99', 'AnasPet77',3456 ,'1')
('EleBla99', 'ProkIoan11',3456 ,'2')
('BasGri54','PanKar92',2345 ,'0')

INSERT INTO evaluationresult VALUES
(9876,'LorPan80',1234,8,DEFAULT,'GriBas')
(8765,'AnasPet77',3456,5,DEFAULT,'EleBla99')
(7654,'ProkIoan11',3456,9,DEFAULT,'EleBla99' )
(6543,'PanKar92',2345,3,DEFAULT,'BasGri54')

INSERT INTO needs VALUES 
(1234, 'administrative secretary')
(2345, 'supervise hiring process')
(3456, 'data manager')

INSERT INTO job VALUES 
(1234, ‘1999-05-17’, 950.5, 'secretary', 'Patra', 'GriBas45', '2021-02-22 10:10:10', '2021-05-11 10:12:30')
(2345, ‘2001-12-12’, 1200, 'hr manager', 'Korinthos', 'BasGri54', '2021-01-23 01:01:01', '2021-04-01 02:10:23')
(3456, ‘2003-03-10’, 1300, 'data_analyst', 'Athina', 'EleBla99', '2020-09-19 05:04:15', '2021-02-18 08:02:05')

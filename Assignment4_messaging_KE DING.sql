/* assignment 4 
question 1
ke ding
CSC 455
Aastha Gupta
Due Tuesday, November 7th
*/

DROP TABLE person CASCADE CONSTRAINTS;
DROP TABLE contact_list CASCADE CONSTRAINTS;
DROP TABLE message CASCADE CONSTRAINTS;

/* =========================
Create the Person table. 
Table Name: person
Primary Key: person_id
========================= */
CREATE TABLE person ( 
    person_id NUMBER NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
);

/* =========================
Create the Contact List table. 
Table Name: contact_list
Primary Key: connection_id
========================= */
CREATE TABLE contact_list ( 
    connection_id NUMBER NOT NULL,
    person_id NUMBER NOT NULL,
    contact_id NUMBER NOT NULL,
    PRIMARY KEY (connection_id)
);

/* =========================
Create the Messages table. 
Table Name: message
Primary Key: message_id
========================= */
CREATE TABLE message ( 
    message_id NUMBER NOT NULL,
    sender_id NUMBER NOT NULL,
    receiver_id NUMBER NOT NULL,
    message VARCHAR(255) NOT NULL,
    send_datetime DATE NOT NULL,
    PRIMARY KEY (message_id)
);

/* =========================
Populate the Person table. 
========================= */
INSERT INTO person (person_id,first_name, last_name) VALUES (1, 'Michael', 'Phelps');
INSERT INTO person (person_id,first_name, last_name) VALUES (2, 'Katie', 'Ledecky');
INSERT INTO person (person_id,first_name, last_name) VALUES (3, 'Usain', 'Bolt');
INSERT INTO person (person_id,first_name, last_name) VALUES (4, 'Allyson', 'Felix');
INSERT INTO person (person_id,first_name, last_name) VALUES (5, 'Kevin', 'Durant');
INSERT INTO person (person_id,first_name, last_name) VALUES (6, 'Diana', 'Taurasi');

/* =========================
Populate the Contact List table. 
========================= */
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (1, 1, 2);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (2, 1, 3);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (3, 1, 4);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (4, 1, 5);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (5, 1, 6);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (6, 2, 1);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (7, 2, 3);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (8, 2, 4);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (9, 3, 1);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (10, 3, 4);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (11, 4, 5);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (12, 4, 6);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (13, 5, 1);
INSERT INTO contact_list (connection_id, person_id, contact_id) VALUES (14, 5, 6);

/* =========================
Populate the Message table. 
========================= */
INSERT INTO message (message_id, sender_id, receiver_id, message, send_datetime) VALUES (1, 1, 2, 'Congrats on winning the 800m Freestyle!', TO_DATE('2016-12-25 09:00:00','YYYY-MM-DD HH:MI:SS'));
INSERT INTO message (message_id, sender_id, receiver_id, message, send_datetime) VALUES (2, 2, 1, 'Congrats on winning 23 gold medals!', TO_DATE('2016-12-25 09:01:00','YYYY-MM-DD HH:MI:SS'));
INSERT INTO message (message_id, sender_id, receiver_id, message, send_datetime) VALUES (3, 3, 1, 'You're the greatest swimmer ever', TO_DATE('2016-12-25 09:02:00','YYYY-MM-DD HH:MI:SS'));
INSERT INTO message (message_id, sender_id, receiver_id, message, send_datetime) VALUES (4, 1, 3, 'Thanks!  You're the greatest sprinter ever', TO_DATE('2016-12-25 09:04:00','YYYY-MM-DD HH:MI:SS'));
INSERT INTO message (message_id, sender_id, receiver_id, message, send_datetime) VALUES (5, 1, 4, 'Good luck on your race', TO_DATE('2016-12-25 09:05:00','YYYY-MM-DD HH:MI:SS'));

/* ========================= Verify Results ========================= */

/* =========================
Show the details for each of the tables created. 
DESCRIBE and SHOW COLUMNS FROM will do the same thing.
i.e. DESCRIBE table_name;
     SHOW COLUMNS FROM table_name;
========================= */
select * from person;
select * from contact_list;
select * from message;
select * from image;
select * from message_image;


/* hw4.1 */
INSERT INTO person (person_id,first_name, last_name) VALUES (7, 'Dolores', 'Ding');

ALTER TABLE PERSON
ADD sex VARCHAR2(1);

UPDATE PERSON
SET sex='F'
WHERE person_id=7;

DELETE FROM PERSON
WHERE first_name='Diana'
AND last_name='Taurasi';

ALTER TABLE CONTACT_LIST
ADD favorite VARCHAR2(3);

UPDATE CONTACT_LIST
SET favorite='y'
WHERE contact_id=1;

UPDATE CONTACT_LIST
SET favorite='n'
WHERE contact_id<>1;

INSERT INTO contact_list VALUES (15, 6, 4, 'n');
INSERT INTO contact_list VALUES (16, 7, 3, 'n');
INSERT INTO contact_list VALUES (17, 7, 5, 'n');

CREATE TABLE IMAGE
(
 image_id NUMBER NOT NULL,
 image_name VARCHAR(25) NOT NULL,
 image_location VARCHAR(30) NOT NULL,
 PRIMARY KEY (image_id)
);

CREATE TABLE MESSAGE_IMAGE
(
 image_id NUMBER NOT NULL,
 message_id NUMBER NOT NULL,
 
 PRIMARY KEY (image_id, message_id),
 
 FOREIGN KEY (image_id)
    REFERENCES IMAGE (image_id),
    
 FOREIGN KEY (message_id)
    REFERENCES MESSAGE (message_id)
);

INSERT INTO IMAGE VALUES (1, 'swimming 2017', 'new york');
INSERT INTO IMAGE VALUES (2, 'swimming 2016', 'chicago');
INSERT INTO IMAGE VALUES (3, 'swimming 2015', 'LA');
INSERT INTO IMAGE VALUES (4, 'swimming 2014', 'miami');
INSERT INTO IMAGE VALUES (5, 'swimming 2013', 'boulder');

SELECT * FROM IMAGE;

INSERT INTO MESSAGE_IMAGE VALUES (1, 1);
INSERT INTO MESSAGE_IMAGE VALUES (2, 1);
INSERT INTO MESSAGE_IMAGE VALUES (3, 2);
INSERT INTO MESSAGE_IMAGE VALUES (4, 5);
INSERT INTO MESSAGE_IMAGE VALUES (5, 5);

SELECT * FROM MESSAGE_IMAGE;


CREATE OR REPLACE VIEW mp_send
(sender_fname, sender_lname, message_id)
AS SELECT p.first_name, p.last_name, m.message_id
FROM MESSAGE m JOIN PERSON p
ON m.sender_id=p.person_id
AND m.sender_id=1;

select * from mp_send;

CREATE OR REPLACE VIEW mp_receive
(receiver_fname, receiver_lname, message_id, message, message_timestamp)
AS SELECT p.first_name, p.last_name, m.message_id, m.message, m.send_datetime
FROM MESSAGE m JOIN PERSON p
ON m.receiver_id=p.person_id
AND m.sender_id=1;

select * from mp_receive;

CREATE OR REPLACE VIEW mp
(sender_fname, sender_lname, receiver_fname, receiver_lname, message_id,
 message, message_timestamp)
AS SELECT s.sender_fname, s.sender_lname, r.receiver_fname, r.receiver_lname,
r.message_id, r.message, r.message_timestamp
FROM mp_send s JOIN mp_receive r
ON s.message_id=r.message_id;

select * from mp;

SELECT COUNT(message) as count_of_msg, person_id, first_name, last_name
FROM MESSAGE JOIN PERSON
ON receiver_id=person_id
GROUP BY person_id, first_name, last_name;


CREATE OR REPLACE VIEW IMG_MSG
(message_id, message, msg_timestamp, first_image_name, first_image_location)
AS SELECT DISTINCT mi.message_id, m.message, m.send_datetime, 
i.image_name, i.image_location
FROM IMAGE i INNER JOIN MESSAGE_IMAGE mi
ON i.image_id=mi.image_id
INNER JOIN MESSAGE m
ON m.message_id=mi.message_id
GROUP BY mi.message_id, m.message, m.send_datetime, i.image_name, i.image_location
HAVING COUNT(m.message_id)>=1;

CREATE VIEW rank_index
(rank, message_id, message, msg_timestamp, first_image_name, first_image_location)
AS SELECT RANK() OVER (PARTITION BY message_id order by FIRST_IMAGE_NAME), 
message_id, message, msg_timestamp, first_image_name, first_image_location
FROM IMG_MSG;

SELECT * FROM RANK_INDEX
WHERE RANK=1;
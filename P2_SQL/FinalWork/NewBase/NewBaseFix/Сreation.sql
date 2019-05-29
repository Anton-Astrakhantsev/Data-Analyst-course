create table department (
id integer primary key,
name varchar
);

insert into department values
('1', 'Therapy'),
('2', 'Neurology'),
('3', 'Cardiology'),
('4', 'Gastroenterology'),
('5', 'Hematology'),
('6', 'Oncology'),
('7', 'Cleaning');

create table employee (
id integer primary key,
name varchar,
num_public integer
);

insert into employee values
('1', 'Kate', 4),
('2', 'Lidia', 2),
('3', 'Alexey', 1),
('4', 'Pier', 7),
('5', 'Aurel', 6),
('6', 'Klaudia', 1),
('7', 'Klaus', 12),
('8', 'Maria', 11),
('9', 'Kate', 10),
('10', 'Peter', 8),
('11', 'Sergey', 9),
('12', 'Olga', 12),
('13', 'Maria', 14),
('14', 'Irina', 2),
('15', 'Grit', 10),
('16', 'Vanessa', 16),
('17', 'Sascha', 21),
('18', 'Ben', 22),
('19', 'Jessy', 19),
('20', 'Ann', 18);

create table chief (
id integer primary key,
name varchar,
experience integer);

insert into chief values
(1, 'John "J.D." Dorian', 9),
(2, 'Christopher Turk', 9),
(3, 'Elliot Reid', 8),
(4, 'Carla Espinosa-Turk', 8),
(5, 'Percival "Perry" Cox', 9),
(6, 'Robert "Bob" Kelso', 8),
(7, 'Denise Mahoney', 1),
(8, 'Lucy Bennett', 1),
(9, 'Drew Suffin', 1),
(10, '"Janitor"', 7);

create table mark (
student_id integer primary key,
average_mark numeric
);

(1, 3.1),
(2, 3.7),
(3, 3.1),
(4, 5),
(5, 4.2),
(6, 4),
(7, 4),
(8, 4),
(9, 3.1),
(10, 3.3),
(11, 5),
(12, 3.4),
(13, 4.8),
(14, 3.6),
(15, 3.1),
(16, 5),
(17, 4.3),
(18, 3.3),
(19, 5),
(20, 5);

create table employee_department (
employee_id integer,
department_id integer
);

insert into employee_department values
('1', '1'),
('2', '1'),
('3', '1'),
('4', '1'),
('5', '1'),
('6', '1'),
('7', '2'),
('8', '2'),
('9', '2'),
('10', '3'),
('11', '3'),
('12', '3'),
('13', '3'),
('14', '4'),
('15', '4'),
('16', '4'),
('17', '5'),
('18', '5'),
('19', '6'),
('20', '6');

create table employee_chief (
employee_id integer,
chief_id integer
);

insert into employee_chief values
('1', '1'),
('2', '1'),
('3', '1'),
('4', '2'),
('5', '2'),
('6', '2'),
('7', '3'),
('8', '3'),
('9', '4'),
('10', '5'),
('11', '5'),
('12', '6'),
('13', '6'),
('14', '7'),
('15', '7'),
('16', '7'),
('17', '8'),
('18', '8'),
('19', '9'),
('20', '9');

create table chief_department (
chief_id integer,
department_id integer
);

insert into chief_department values
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 5),
(9, 6),
(10, 7);

create table employee_mark (
employee_id integer,
student_id integer
);

insert into employee_mark values
(1, 6),
(2, 18),
(3, 3),
(4, 16),
(5, 13),
(6, 17),
(7, 8),
(8, 20),
(9, 14),
(10, 2),
(11, 19),
(12, 1),
(13, 15),
(14, 5),
(15, 11),
(16, 12),
(17, 4),
(18, 10),
(19, 7),
(20, 9);

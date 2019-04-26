create table language (
  id integer primary key,
  name varchar (255)
);

create table nation (
  id integer primary key,
  name varchar (255),
  alignment varchar (6)
);

create table country (
  id integer primary key,
  name varchar (255)
);

create table country_nation (
  id_country integer,
  id_nation integer
);

create table nation_language (
  id_nation integer,
  id_language integer
);

insert into language values
(1, 'Quenya'),
(2, 'Sindarin'),
(3, 'Westron'),
(4, 'Rohirric'),
(5, 'Khuzdul'),
(6, 'Black Speech'),
(7, 'Entish');

insert into nation values
(1, 'Elves', 'Good'),
(2, 'Men', 'Good'),
(3, 'Dwarves', 'Good'),
(4, 'Hobbits', 'Good'),
(5, 'Ents', 'Good'),
(6, 'Orcs', 'Evil'),
(7, 'Trolls', 'Evil');

insert into country values
(1, 'Gondor'),
(2, 'Rohan'),
(3, 'Shire'),
(4, 'Mirkwood'),
(5, 'Rivendell'),
(6, 'Moria'),
(7, 'Erebor'),
(8, 'Mordor'),
(9, 'Isengard');

insert into country_nation values
(1, 2),
(2, 2),
(3, 4),
(4, 1),
(5, 1),
(6, 3),
(6, 6),
(6, 7),
(7, 6),
(8, 6),
(8, 7),
(9, 5),
(9, 6);

insert into nation_language values
(1, 1),
(1, 2),
(1, 3),
(2, 3),
(2, 4),
(3, 3),
(3, 5),
(4, 3),
(5, 7),
(6, 6),
(7, 6);

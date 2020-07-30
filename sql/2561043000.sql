ALTER TABLE degrees ADD file int NOT NULL;
ALTER TABLE degrees
  MODIFY COLUMN visible tinyint(4) NOT NULL AFTER file;
create table module_courses
(
  id     int auto_increment
    primary key,
  module int not null,
  course int not null
)
  engine = MyISAM;
create table degree_modules
(
  id              int auto_increment
    primary key,
  degree          int          not null,
  name_th         varchar(500) not null,
  name_en         varchar(500) not null,
  minimum_credits int          not null
)
  engine = MyISAM;

create index degree_modules_degree_index
  on degree_modules (degree);
ALTER TABLE courses ADD code int NOT NULL;
CREATE UNIQUE INDEX courses_code_uindex ON courses (code);
ALTER TABLE courses
  MODIFY COLUMN code int NOT NULL AFTER id;
ALTER TABLE courses MODIFY id int(11) NOT NULL auto_increment;
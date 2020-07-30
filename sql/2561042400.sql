ALTER TABLE slide_shows ADD url varchar(500) NOT NULL;
ALTER TABLE slide_shows
  MODIFY COLUMN visible tinyint(4) NOT NULL AFTER url;
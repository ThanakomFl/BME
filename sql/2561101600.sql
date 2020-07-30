ALTER TABLE files
  ADD COLUMN access_key   VARCHAR(16)   NULL    DEFAULT NULL;

CREATE TABLE documents (
  id      INT   NOT NULL    KEY   AUTO_INCREMENT,
  file    INT   NOT NULL,
  preview INT   NOT NULL
);
CREATE INDEX documents_file_idx ON documents(file);
CREATE INDEX documents_preview_idx ON documents(preview);

ALTER TABLE documents
    ADD COLUMN uploaded_dt  INT   NOT NULL    DEFAULT 0;

UPDATE documents
  SET documents.uploaded_dt = (SELECT uploaded_dt FROM files WHERE id = documents.file);

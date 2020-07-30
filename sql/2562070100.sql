ALTER TABLE staffs ADD sequence int NOT NULL;
CREATE INDEX staffs_sequence_index ON staffs (sequence);

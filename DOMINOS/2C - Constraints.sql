
-- OPDRACHT 2C --

-- CONFIG CONSTRAINTS --
CREATE UNIQUE INDEX INDEX_pk_unique ON CONFIG(pk_col);

ALTER TABLE CONFIG
  ADD CONSTRAINT one_record_limit CHECK (pk_col = 1);
  
ALTER TABLE CONFIG
  ADD CONSTRAINT record_not_null CHECK (pk_col IS NOT NULL);
  
CREATE OR REPLACE TRIGGER TRIG_NoRecordDelete 
  BEFORE DELETE ON CONFIG
  DECLARE
    v_number NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_number FROM CONFIG;
    
    IF (v_number = 1)
    THEN
      RAISE_APPLICATION_ERROR(-20011, 'NOT ALLOWED TO DELETE ONLY RECORD');
    END IF;
  END;
  
-- OPENINGSTIJD PROCEDURE --

--NIET AF GEKREGEN!!!--

--CREATE OR REPLACE PROCEDURE Create_Openingstijd_Record
--(
  --v_WinkelID OPENINGSTIJD.winkel_id%TYPE,
  --v_Dag OPENINGSTIJD.dag%TYPE,
  --v_Open OPENINGSTIJD.open%TYPE,
  --v_Gesloten OPENINGSTIJD.gesloten%TYPE
--)
--AS
  --CURSOR CUR_OPENINGSTIJD IS
    --SELECT winkel_id, dag, open, gesloten
    --FROM OPENINGSTIJD;
--BEGIN
  --FOR i IN CUR_OPENINGSTIJD LOOP
    --IF(v_WinkelID = winkel_id)
    --THEN
    --END IF;
  --END LOOP;  
--END Create_Openingstijd_Record;
--/
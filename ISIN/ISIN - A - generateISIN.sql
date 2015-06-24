SET SERVEROUTPUT ON;

-- Een functie om een International Student Identification Number (ISIN) te genereren
CREATE OR REPLACE FUNCTION DBS2_generateISIN
(
  countryCode DBS2_Country.Code%TYPE,
  universityCode DBS2_University.Code%TYPE,
  studentNumber VARCHAR2
)
RETURN VARCHAR2
AS
  ISIN VARCHAR2(200);
  ISIN2 VARCHAR2(200);
  checksum VARCHAR2(200);
  checksum2 VARCHAR2(200);
  v_array DBMS_SQL.VARCHAR2_TABLE;
  v_array2 DBMS_SQL.VARCHAR2_TABLE;
  v_count NUMBER(3) := 1;
  v_position NUMBER(3) := 0;
  v_temp NUMBER(3) := 0;
BEGIN
  --BEGIN ISIN--
  --BEGIN CHECKSUM--
  checksum := universityCode || countryCode || studentNumber;
  
  -- 2, Zet elke letter om naar een getal, waarbij('A' = 16, 'B' = 17,...)
  FOR i IN 0..LENGTH(checksum)
  LOOP
    IF ASCII(SUBSTR(checksum,i, 1)) >= 65 AND ASCII(SUBSTR(checksum, i, 1)) <= 90 THEN
      checksum2 := checksum2 || (ASCII(SUBSTR(checksum, i, 1)) - 49);
    ELSE
      checksum2 := checksum2 || SUBSTR(checksum, i, 1);
    END IF;  
    DBMS_OUTPUT.PUT_LINE(checksum2);
  END LOOP;
  
  -- 3, Groepeer elke vier cijfers in groepjes, beginnend bij het meest linker getal 
  WHILE v_count > LENGTH(checksum2)
  LOOP
    v_array(v_temp) := SUBSTR(checksum2, v_count, 4);
    v_count := v_count + 4;
    v_temp := v_temp + 1;
  END LOOP;
  
  --FOR i IN  1..LENGTH(checksum2)
  --LOOP
    --v_array(i) := SUBSTR(checksum2, i, 4);
  --END LOOP;
 
 checksum:= '';
 
  FOR i IN REVERSE 1..v_array.COUNT
  LOOP
    checksum := checksum || v_array(i);
  END LOOP;
   
  -- 6, bereken over dit getal de rest bij de geheeltallige deling met 62.
  --ISIN := checksum;
  DBMS_OUTPUT.PUT_LINE(checksum);
  --checksum := MOD(TO_NUMBER(checksum), 62);
  checksum := MOD(62, TO_NUMBER(checksum));
  
  -- 8, Voeg eventueel een 0 toe aan het getal als het maar 1 karakter groot is (bij de getallen 0tot en met 9)
  IF LENGTH(checksum) = 1 THEN
    checksum := 0 || checksum;
  END IF;
  --END CHECKSUM--
  
  ISIN := studentNumber || checksum;
  
  WHILE v_count > LENGTH(ISIN)
  LOOP
    v_array2(v_position) := SUBSTR(ISIN, v_count, 4);
    v_count := v_count + 4;
    v_position := v_position + 1;
  END LOOP;
      
  ISIN := '';
  
  FOR i IN 1..v_array2.COUNT
  LOOP
    ISIN := ISIN || ' ' || v_array2(i);
  END LOOP;
  
  ISIN := countryCode || ' ' || ISIN || ' ' || universityCode;
  RETURN ISIN;
END DBS2_generateISIN;
/
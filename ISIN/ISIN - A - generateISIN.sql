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
  v_array dbms_sql.varchar2_table;
  --group1 VARCHAR2(4);
  --group2 VARCHAR2(4);
  --group3 VARCHAR2(4);
  --group4 VARCHAR2(4);
  --group5 VARCHAR2(4);
  --group6 VARCHAR2(4);
  --group7 VARCHAR2(4);
  --group8 VARCHAR2(4);
  --group9 VARCHAR2(4);
  --group10 VARCHAR2(4);  
BEGIN
  --BEGIN ISIN--
  --BEGIN CHECKSUM--
  checksum := universityCode || countryCode || studentNumber;
  
  -- 2, Zet elke letter om naar een getal, waarbij('A' = 16, 'B' = 17,...)
  FOR i IN 0..LENGTH(checksum)
  LOOP
    checksum2 := checksum2 || (ASCII(SUBSTR(checksum, i, 1)) - 49);
  END LOOP;
  
  -- 3, Groepeer elke vier cijfers in groepjes, beginnend bij het meest linker getal 
  FOR i IN  1..LENGTH(checksum2)
  LOOP
    v_array(i) := SUBSTR(checksum2, i, 4);
  END LOOP;
 
  FOR j IN REVERSE 1..v_array.COUNT
  LOOP
    checksum := checksum || v_array(i);
  END LOOP;
   
  -- 6, bereken over dit getal de rest bij de geheeltallige deling met 62.
  checksum := MOD(62, checksum);
  
  -- 8, Voeg eventueel een 0 toe aan het getal als het maar 1 karakter groot is (bij de getallen 0tot en met 9)
  IF LENGTH(checksum) = 1 THEN
    checksum := 0 || checksum;
  END IF;
  --END CHECKSUM--
  
  ISIN := studentNumber || checksum;
  
  group1 := SUBSTR(ISIN, 0, 4);
  group2 := SUBSTR(ISIN, 5, 4);
  group3 := SUBSTR(ISIN, 9, 4);
  group4 := SUBSTR(ISIN, 13, 4);
  
  ISIN := group1 || ' ' || group2 || ' ' || group3 || ' ' || group4;
  
  ISIN := countryCode || ' ' || ISIN || ' ' || universityCode;
  
  --dbms_output.put_line(ISIN);
  RETURN ISIN;
END DBS2_generateISIN;
/
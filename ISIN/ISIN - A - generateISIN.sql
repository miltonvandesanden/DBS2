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
  group1 VARCHAR2(4);
  group2 VARCHAR2(4);
  group3 VARCHAR2(4);
  group4 VARCHAR2(4);
  group5 VARCHAR2(4);
  group6 VARCHAR2(4);
  group7 VARCHAR2(4);
  group8 VARCHAR2(4);
  group9 VARCHAR2(4);
  group10 VARCHAR2(4);
BEGIN
  --BEGIN ISIN--
  ISIN := universityCode || countryCode || studentNumber;
  
  --BEGIN CHECKSUM--
  checksum := ISIN;
  
  -- 2, Zet elke letter om naar een getal, waarbij('A' = 16, 'B' = 17,...)
  FOR i IN 0..LENGTH(checksum)
  LOOP
    checksum2 := checksum2 || ASCII(SUBSTR(checksum, i, 1));
  END LOOP;
  
  -- 3, Groepeer elke vier cijfers in groepjes, beginnend bij het meest linker getal
  group1 := SUBSTR(checksum2, 0, 4);
  group2 := SUBSTR(checksum2, 5, 4);
  group3 := SUBSTR(checksum2, 9, 4);
  group4 := SUBSTR(checksum2, 13, 4);
  group5 := SUBSTR(checksum2, 17, 4);
  group6 := SUBSTR(checksum2, 21, 4);
  group7 := SUBSTR(checksum2, 25, 4);
  group8 := SUBSTR(checksum2, 29, 4);
  group9 := SUBSTR(checksum2, 33, 4);
  group10 := SUBSTR(checksum2, 37, 4);
  
  DBMS_OUTPUT.PUT_LINE('group1: ' || group1);
  DBMS_OUTPUT.PUT_LINE('group2: ' || group2);
  DBMS_OUTPUT.PUT_LINE('group3: ' || group3);
  DBMS_OUTPUT.PUT_LINE('group4: ' || group4);
  DBMS_OUTPUT.PUT_LINE('group5: ' || group5);
  DBMS_OUTPUT.PUT_LINE('group6: ' || group6);
  DBMS_OUTPUT.PUT_LINE('group7: ' || group7);
  DBMS_OUTPUT.PUT_LINE('group8: ' || group8);
  DBMS_OUTPUT.PUT_LINE('group9: ' || group9);
  DBMS_OUTPUT.PUT_LINE('group10: ' || group10);
  
  -- 5, Rangschik de groepjes om in tegengestelde volgorde, waarbij (groep 1, groep 2, ... groep n) nu (groep n, ..., groep 2, groep 1)
  checksum := group5 || group4 || group3 || group2 || group1;
  
  -- 6, bereken over dit getal de rest bij de geheeltallige deling met 62.
  checksum := MOD(62, checksum);
  DBMS_OUTPUT.PUT_LINE('checksum: ' || checksum);
  
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
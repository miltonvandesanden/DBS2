-- Een functie die controleert of een gegeven ISIN voldoet aan de eisen
CREATE OR REPLACE FUNCTION DBS2_checkForCorrectness (
  ISIN VARCHAR2
)
RETURN INTEGER
AS
  isCorrect INTEGER := 0;
  studentCode VARCHAR2(12);
BEGIN
  IF ASCII(SUBSTR(ISIN, 1, 1)) >= 65 AND ASCII(SUBSTR(ISIN, 1, 1)) <= 90 THEN
    isCorrect := 0;
  END IF;
  RETURN isCorrect;
END DBS2_checkForCorrectness;
/
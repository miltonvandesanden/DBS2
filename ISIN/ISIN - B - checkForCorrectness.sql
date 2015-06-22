-- Een functie die controleert of een gegeven ISIN voldoet aan de eisen
CREATE OR REPLACE FUNCTION DBS2_checkForCorrectness (
  ISIN VARCHAR2
)
RETURN INTEGER
AS
  isCorrect INTEGER := 0;
BEGIN

  dbms_output.put_line('implementeer deze functie verder...');

  RETURN isCorrect;
END DBS2_checkForCorrectness;
/
-- Een functie om een International Student Identification Number (ISIN) te genereren
CREATE OR REPLACE FUNCTION DBS2_generateISIN
(
  countryCode DBS2_Country.Code%TYPE,
  universityCode DBS2_University.Code%TYPE,
  studentNumber VARCHAR2
)
RETURN VARCHAR2
AS
BEGIN
END DBS2_generateISISN;
/
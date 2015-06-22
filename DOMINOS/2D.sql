CREATE OR REPLACE DIRECTORY User_Folder AS '/home/oracle';
GRANT READ ON DIRECTORY User_Folder TO PUBLIC;

CREATE OR REPLACE PROCEDURE proc_InsertWinkelFromTextfile
AS
  f_File UTL_FILE.FILE_TYPE;
  f_Folder VARCHAR2(250);
  f_FileName VARCHAR2(50);
  v_NoData NUMBER(1,0) := 0;
  
  v_Name WINKEL.naam%TYPE;
  v_Postalcode WINKEL.postcode%TYPE;
  v_Housenumber WINKEL.huisnr%TYPE;
  v_HousenumberExtra WINKEL.toevoeging%TYPE;
  v_Phone WINKEL.telNr%TYPE;
  v_Opgeheven WINKEL.opgeheven%TYPE;
  v_Street POSTCODE.street%TYPE;
  v_City POSTCODE.city%TYPE;
  v_Country VARCHAR2(6);
BEGIN
  f_Folder := 'Bureaublad';
  f_FileName := 'PLACEHOLDER.txt';
  
  UTL_FILE.FOPEN('UTL_FILE_DIR', f_FileName, 'r');
  
  UTL_FILE.GET_LINE(f_File, v_TextLine);
  
  FOR i IN 1..7 LOOP
    UTL_FILE.GET_LINE(f_File, v.TextLine);
    
    IF i = 1 THEN
      v_Name := v_TextLine;
      dbms_output.put_lin(v_Name);
    ELSIF i = 2 THEN
      v_Street := v_TextLine;
      dbms_output.put_lin(v_Street);
    ELSIF i = 3 THEN
      v_Housenumber := v_TextLine;
      dbms_output.put_lin(v_Housenumber);
    ELSIF i = 4 THEN
      v_City := v_TextLine;
      dbms_output.put_lin(v_City);
    ELSIF i = 5 THEN
      v_Country := v_TextLine;
      dbms_output.put_lin(v_Country);
    ELSIF i = 6 THEN
      v_Postalcode := v_TextLine;
      dbms_output.put_lin(v_Postalcode);
    ELSIF i = 7 THEN
      v_Phone := v_TextLine;
      dbms_output.put_lin(v_Phone);
      
      UTL_FILE.GET_LINE(f_File, v_TextLine);
      i := 0;
    END IF;
  END LOOP;
END proc_InsertWinkelFromTextfile;
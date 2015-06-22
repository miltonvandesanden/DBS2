CREATE OR REPLACE PROCEDURE updateWinkelPostcodeID
AS
  v_Winkel_postcode WINKEL.postcode%TYPE;
  v_Winkel_postcode_id WINKEL.postcode_id%TYPE;
  v_Postcode_postcode POSTCODE.postcode%TYPE;
  v_Postcode_postcode_id POSTCODE.postcode_id%TYPE;
  v_POSTCODE_id POSTCODE.id%TYPE;

  CURSOR CUR_WINKEL IS
    SELECT postcode, postcode_id
    FROM WINKEL;
        
  CURSOR CUR_POSTCODE IS
    SELECT postcode, postcode_id
    FROM POSTCODE;
    
  CURSOR CUR_POSTCODE_id
  (
    v_temp_postcode IN POSTCODE.postcode%TYPE,
    v_temp_postcode_id IN POSTCODE.postcode_id%TYPE
  )
  IS
    SELECT id
    FROM POSTCODE
    WHERE postcode = v_temp_postcode AND postcode_id = v_temp_postcode_id;
    
BEGIN
  FOR i IN CUR_WINKEL LOOP
    FOR j IN CUR_POSTCODE LOOP
      IF(i.postcode = j.postcode AND i.postcode_id = j.postcode_id) 
      THEN
        OPEN CUR_POSTCODE_id(j.postcode, j.postcode_id);
        FETCH CUR_POSTCODE_id INTO v_POSTCODE_id;
        CLOSE CUR_POSTCODE_id;
          
        INSERT INTO WINKEL
        (postcode_id_fk)
        VALUES
        (v_POSTCODE_id);        
      END IF;
    END LOOP;
  END LOOP;
END updateWinkelPostcodeID;  
/
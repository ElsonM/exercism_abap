CLASS zcl_scrabble_score DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_scrabble_score IMPLEMENTATION.

  METHOD score. 
    DATA(upper_case_input) = to_upper( input ).

    DO strlen( upper_case_input ) TIMES.
      DATA(index) = sy-index - 1.
      DATA(char) = upper_case_input+index(1).

      CASE char.
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U'
          OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
          result += 1.
        WHEN 'D' OR 'G'.
          result += 2.
        WHEN 'B' OR 'C' OR 'M' OR 'P'.
          result += 3.
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
          result += 4.
        WHEN 'K'.
          result += 5.
        WHEN 'J' OR 'X'.
          result += 8.
        WHEN 'Q' OR 'Z'.
          result += 10.
      ENDCASE.
    ENDDO.   
  ENDMETHOD.

ENDCLASS.

CLASS zcl_line_up DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS format
      IMPORTING
        name          TYPE string
        number        TYPE i
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS: th_ending(2) TYPE c VALUE 'th',
               st_ending(2) TYPE c VALUE 'st',
               nd_ending(2) TYPE c VALUE 'nd',
               rd_ending(2) TYPE c VALUE 'rd'.

ENDCLASS.

CLASS zcl_line_up IMPLEMENTATION.

  METHOD format.
    DATA(suffix) = th_ending.
    DATA(last_two_digits) = number MOD 100.

    IF last_two_digits <> 11 AND
       last_two_digits <> 12 AND
       last_two_digits <> 13.

      DATA(last_digit) = number MOD 10.

      CASE last_digit.
        WHEN 1.
          suffix = st_ending.
        WHEN 2.
          suffix = nd_ending.
        WHEN 3.
          suffix = rd_ending.
      ENDCASE.

    ENDIF.

    result = |{ name }, you are the { number }{ suffix } customer we serve today. Thank you!|.
  ENDMETHOD.
  
  
ENDCLASS.
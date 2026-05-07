CLASS zcl_reverse_string DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
        
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    DATA(number_char) = strlen( input ) - 1.

    WHILE number_char >= 0.
      result = |{ result }{ input+number_char(1) }|.
      number_char = number_char - 1.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.

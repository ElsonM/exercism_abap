CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
  
ENDCLASS.

CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    DATA list_of_letters TYPE TABLE OF c.

    DATA(length) = strlen( phrase ).

    DO length TIMES.
      DATA(offset) = sy-index - 1.
      DATA(letter) = to_upper( phrase+offset(1) ).

      IF letter = space OR letter = '-'.
        CONTINUE.
      ENDIF.

      IF line_exists( list_of_letters[ table_line = letter ] ).
        result = abap_false.
        RETURN.
      ELSE.
        APPEND letter TO list_of_letters.
      ENDIF.    
    ENDDO.

    result = abap_true.
  ENDMETHOD.

ENDCLASS.
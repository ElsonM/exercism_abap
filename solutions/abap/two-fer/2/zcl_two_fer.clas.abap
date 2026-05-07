CLASS zcl_two_fer DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.

  PRIVATE SECTION.
    CONSTANTS no_name TYPE string VALUE 'you'.
        
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
    DATA other_person TYPE string.
  
    IF input IS INITIAL.
      other_person = no_name.   
    ELSE.
      other_person = input.
    ENDIF.

    result = |One for { other_person }, one for me.|.
  ENDMETHOD.

ENDCLASS.

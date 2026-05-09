CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    DATA(first_strand_length) = strlen( first_strand ).
    DATA(second_strand_length) = strlen( second_strand ).

    IF first_strand_length <> second_strand_length.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSE.
      DO first_strand_length TIMES.
        DATA(offset) = sy-index - 1.

        DATA(first_letter) = first_strand+offset(1).
        DATA(second_letter) = second_strand+offset(1).

        IF first_letter <> second_letter.
          result += 1.
        ENDIF.
      ENDDO.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

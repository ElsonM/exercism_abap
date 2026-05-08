CLASS zcl_darts DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.

CLASS zcl_darts IMPLEMENTATION.

  METHOD score.
    DATA distance TYPE f.

    distance = sqrt( x * x + y * y ).

    result = COND i(
      WHEN distance <= 1  THEN 10
      WHEN distance <= 5  THEN 5
      WHEN distance <= 10 THEN 1
      ELSE 0
    ).
  ENDMETHOD.
  
ENDCLASS.
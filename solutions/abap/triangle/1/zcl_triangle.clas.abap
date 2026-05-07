CLASS zcl_triangle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      is_equilateral
        IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool
        RAISING
          cx_parameter_invalid,
      is_isosceles
        IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool
        RAISING
          cx_parameter_invalid,
      is_scalene
        IMPORTING
          side_a             TYPE f
          side_b             TYPE f
          side_c             TYPE f
        RETURNING
          VALUE(result)      TYPE abap_bool
        RAISING
          cx_parameter_invalid.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS validate_triangle
      IMPORTING
        side_a TYPE f
        side_b TYPE f
        side_c TYPE f
      RAISING
        cx_parameter_invalid.

ENDCLASS.


CLASS zcl_triangle IMPLEMENTATION.

  METHOD is_equilateral.
    "Implement solution
  ENDMETHOD.

  METHOD is_isosceles.
    "Implement solution
  ENDMETHOD.

  METHOD is_scalene.
    "Implement solution
  ENDMETHOD.

  METHOD validate_triangle.

    IF side_a <= 0
    OR side_b <= 0
    OR side_c <= 0
    OR side_a + side_b < side_c
    OR side_a + side_c < side_b
    OR side_b + side_c < side_a.

      RAISE EXCEPTION TYPE cx_parameter_invalid.

    ENDIF.

  ENDMETHOD.

   METHOD is_equilateral.

    validate_triangle(
      side_a = side_a
      side_b = side_b
      side_c = side_c ).

    result = xsdbool(
      side_a = side_b
      AND side_b = side_c ).

  ENDMETHOD.


  METHOD is_isosceles.

    validate_triangle(
      side_a = side_a
      side_b = side_b
      side_c = side_c ).

    result = xsdbool(
      side_a = side_b
      OR side_a = side_c
      OR side_b = side_c ).

  ENDMETHOD.


  METHOD is_scalene.

    validate_triangle(
      side_a = side_a
      side_b = side_b
      side_c = side_c ).

    result = xsdbool(
      side_a <> side_b
      AND side_a <> side_c
      AND side_b <> side_c ).

  ENDMETHOD.

ENDCLASS.

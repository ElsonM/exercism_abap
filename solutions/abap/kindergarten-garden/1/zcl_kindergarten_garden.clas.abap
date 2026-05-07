CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PRIVATE SECTION.

    DATA students TYPE string_table.

ENDCLASS.



CLASS zcl_kindergarten_garden IMPLEMENTATION.

  METHOD plants.

    DATA clean_diagram TYPE string.
    DATA row_length    TYPE i.
    DATA student_index TYPE i.
    DATA start_pos     TYPE i.

    DATA pos_1 TYPE i.
    DATA pos_2 TYPE i.
    DATA pos_3 TYPE i.
    DATA pos_4 TYPE i.

    DATA code       TYPE c LENGTH 1.
    DATA plant_name TYPE string.

    students = VALUE string_table(
      ( `Alice` )   ( `Bob` )    ( `Charlie` ) ( `David` )
      ( `Eve` )     ( `Fred` )   ( `Ginny` )   ( `Harriet` )
      ( `Ileana` )  ( `Joseph` ) ( `Kincaid` ) ( `Larry` )
    ).

    LOOP AT students INTO DATA(current_student).

      IF current_student = student.
        student_index = sy-tabix.
        EXIT.
      ENDIF.

    ENDLOOP.

    start_pos = ( student_index - 1 ) * 2.

    clean_diagram = diagram.

    REPLACE ALL OCCURRENCES OF '\n' IN clean_diagram WITH ``.

    row_length = strlen( clean_diagram ) / 2.

    pos_1 = start_pos.
    pos_2 = start_pos + 1.
    pos_3 = row_length + start_pos.
    pos_4 = row_length + start_pos + 1.

    DO 4 TIMES.

      CASE sy-index.

        WHEN 1.
          code = clean_diagram+pos_1(1).

        WHEN 2.
          code = clean_diagram+pos_2(1).

        WHEN 3.
          code = clean_diagram+pos_3(1).

        WHEN 4.
          code = clean_diagram+pos_4(1).

      ENDCASE.

      CASE code.

        WHEN 'G'.
          plant_name = 'grass'.

        WHEN 'C'.
          plant_name = 'clover'.

        WHEN 'R'.
          plant_name = 'radishes'.

        WHEN 'V'.
          plant_name = 'violets'.

      ENDCASE.

      APPEND plant_name TO results.

      CLEAR code.
      CLEAR plant_name.

    ENDDO.

  ENDMETHOD.

ENDCLASS.
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
    CONSTANTS: number_of_cups TYPE i VALUE 4,
               cups_for_a_child TYPE i VALUE 2.

    students = VALUE string_table(
      ( `Alice`  ) ( `Bob`    ) ( `Charlie` ) ( `David`   )
      ( `Eve`    ) ( `Fred`   ) ( `Ginny`   ) ( `Harriet` )
      ( `Ileana` ) ( `Joseph` ) ( `Kincaid` ) ( `Larry`   )
    ).

    DATA(student_index) = line_index( students[ table_line = student ] ).

    DATA(start_pos) = ( student_index - 1 ) * cups_for_a_child.

    DATA(clean_diagram) = diagram.

    REPLACE ALL OCCURRENCES OF '\n' IN clean_diagram WITH ``.

    DATA(row_length) = strlen( clean_diagram ) / cups_for_a_child.

    DATA(pos_1) = start_pos.
    DATA(pos_2) = start_pos + 1.
    DATA(pos_3) = row_length + start_pos.
    DATA(pos_4) = row_length + start_pos + 1.

    DO number_of_cups TIMES.
      DATA(code) = SWITCH #( sy-index
        WHEN 1 THEN clean_diagram+pos_1(1)
        WHEN 2 THEN clean_diagram+pos_2(1)
        WHEN 3 THEN clean_diagram+pos_3(1)
        WHEN 4 THEN clean_diagram+pos_4(1) ).

      DATA(plant_name) = SWITCH string( code
        WHEN 'G' THEN 'grass'
        WHEN 'C' THEN 'clover'
        WHEN 'R' THEN 'radishes'
        WHEN 'V' THEN 'violets' ).

      APPEND plant_name TO results.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
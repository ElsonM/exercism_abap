CLASS zcl_minesweeper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS annotate
      IMPORTING
        !input        TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.
      
ENDCLASS.

CLASS zcl_minesweeper IMPLEMENTATION.

  METHOD annotate.
    result = input.

    LOOP AT result ASSIGNING FIELD-SYMBOL(<row>).
      DATA(row_index) = sy-tabix.
      DATA(row_length) = strlen( <row> ).

      DO row_length TIMES.
        DATA(col_index) = sy-index.
      
        DATA(cell) = substring( val = <row> off = col_index - 1 len = 1 ).
        
        IF cell = '*'.
          CONTINUE.
        ENDIF.
      
        DATA(mine_count) = 0.

        DO 3 TIMES.
          DATA(check_row) = row_index + sy-index - 2.

          IF ( check_row < 1 OR check_row > lines( input ) ).
            CONTINUE.
          ENDIF.

          READ TABLE input INDEX check_row INTO DATA(input_row).

          DO 3 TIMES.
            DATA(check_col) = col_index + sy-index - 2.

            IF ( check_col < 1 OR check_col > strlen( input_row ) ).
              CONTINUE.
            ENDIF.

            DATA(check_offset) = check_col - 1.
            DATA(neighbour) = input_row+check_offset(1).

            IF neighbour = '*'.
              mine_count = mine_count + 1.
            ENDIF.
          ENDDO.
        ENDDO.

        IF mine_count > 0.
          REPLACE SECTION OFFSET col_index - 1
            LENGTH 1 OF <row>
            WITH mine_count.
        ENDIF.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.
  
ENDCLASS.
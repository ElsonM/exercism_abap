class ZCL_MINESWEEPER definition
  public
  final
  create public .

public section.

  methods ANNOTATE
    importing
      !INPUT type STRING_TABLE
    returning
      value(RESULT) type STRING_TABLE .
ENDCLASS.



CLASS ZCL_MINESWEEPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MINESWEEPER->ANNOTATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] INPUT                          TYPE        STRING_TABLE
* | [<-()] RESULT                         TYPE        STRING_TABLE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD annotate.

    DATA check_row TYPE i.
    DATA check_col TYPE i.

    DATA check_offset TYPE i.

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
          check_row = row_index + sy-index - 2.

          IF ( check_row < 1 OR check_row > lines( input ) ).
            CONTINUE.
          ENDIF.

          READ TABLE input INDEX check_row INTO DATA(input_row).

          DO 3 TIMES.
            check_col = col_index + sy-index - 2. "Test

            IF ( check_col < 1 OR check_col > strlen( input_row ) ).
              CONTINUE.
            ENDIF.

            check_offset = check_col - 1.

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
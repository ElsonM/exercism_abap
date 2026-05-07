CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.
        
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.

  METHOD resistor_color.

    DATA(lt_values) =
      VALUE string_table( ( `black`  ) ( `brown`  )
                          ( `red`    ) ( `orange` )
                          ( `yellow` ) ( `green`  )
                          ( `blue`   ) ( `violet` )
                          ( `grey`   ) ( `white`  ) ).

    READ TABLE lt_values
      WITH KEY table_line = color_code TRANSPORTING NO FIELDS.
    value = sy-tabix - 1.

  ENDMETHOD.

ENDCLASS.

CLASS zcl_resistor_color_trio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS label
      IMPORTING
        colors        TYPE string_table
      RETURNING
        VALUE(result) TYPE string.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_resistor_color_trio IMPLEMENTATION.

  METHOD label. 
    DATA resistor_value TYPE int8.

    DATA(values) = VALUE string_table( ( `black`  ) ( `brown`  )
                                       ( `red`    ) ( `orange` )
                                       ( `yellow` ) ( `green`  )
                                       ( `blue`   ) ( `violet` )
                                       ( `grey`   ) ( `white`  ) ).
         
    READ TABLE colors INDEX 1 INTO DATA(first_color).
    READ TABLE values 
      WITH KEY table_line = first_color TRANSPORTING NO FIELDS.
    DATA(first_value) = sy-tabix - 1.

    READ TABLE colors INDEX 2 INTO DATA(second_color).
    READ TABLE values 
      WITH KEY table_line = second_color TRANSPORTING NO FIELDS.
    DATA(second_value) = sy-tabix - 1.

    READ TABLE colors INDEX 3 INTO DATA(third_color).
    READ TABLE values 
      WITH KEY table_line = third_color TRANSPORTING NO FIELDS.
    DATA(multiplier) = sy-tabix - 1.
  
    resistor_value = ( first_value * 10 + second_value ) * ( 10 ** multiplier ).

    IF resistor_value >= 1000000000.
      result =
        |{ resistor_value / 1000000000 } gigaohms|.
    ELSEIF resistor_value >= 1000000.
      result =
        |{ resistor_value / 1000000 } megaohms|.
    ELSEIF resistor_value >= 1000.
      result =
        |{ resistor_value / 1000 } kiloohms|.
    ELSE.
      result =
        |{ resistor_value } ohms|.
    ENDIF.
  ENDMETHOD.
    
ENDCLASS.
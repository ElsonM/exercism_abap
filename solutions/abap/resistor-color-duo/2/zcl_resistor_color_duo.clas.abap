CLASS zcl_resistor_color_duo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS value
      IMPORTING
        colors        TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
  
ENDCLASS.

CLASS zcl_resistor_color_duo IMPLEMENTATION.

  METHOD value.

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
  
    result = first_value * 10 + second_value.

  ENDMETHOD.
  
ENDCLASS.
CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.

    METHODS get
      RETURNING
        VALUE(result) TYPE string.

    METHODS add
      IMPORTING
        !minutes TYPE i.

    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    DATA total_minutes TYPE i.

    METHODS normalize.

ENDCLASS.

CLASS zcl_clock IMPLEMENTATION.

  METHOD constructor.
    total_minutes = ( hours * 60 ) + minutes.

    normalize( ).
  ENDMETHOD.

  METHOD add.
    total_minutes = total_minutes + minutes.

    normalize( ).
  ENDMETHOD.

  METHOD sub.
    total_minutes = total_minutes - minutes.

    normalize( ).
  ENDMETHOD.

  METHOD normalize.
    CONSTANTS minutes_per_day TYPE i VALUE 1440.

    total_minutes = total_minutes MOD minutes_per_day.

    IF total_minutes < 0.
      total_minutes = total_minutes + minutes_per_day.
    ENDIF.  
  ENDMETHOD.

  METHOD get.
    DATA display_hours TYPE i.
    DATA display_minutes TYPE i.

    display_hours = total_minutes DIV 60.
    display_minutes = total_minutes MOD 60.

    result = |{ display_hours   WIDTH = 2 PAD = '0' ALIGN = RIGHT }:{
                display_minutes WIDTH = 2 PAD = '0' ALIGN = RIGHT }|.
  ENDMETHOD.

ENDCLASS.
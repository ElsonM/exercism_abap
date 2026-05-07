CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.

    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_itab_aggregation IMPLEMENTATION.

  METHOD perform_aggregation.

    DATA: group TYPE group,     
          count TYPE i,
          sum TYPE i,
          min TYPE i,
          max TYPE i.

    CHECK initial_numbers IS NOT INITIAL.

    SORT initial_numbers BY group number.

    group = initial_numbers[ 1 ]-group.
    min = initial_numbers[ 1 ]-number.
    
    LOOP AT initial_numbers INTO DATA(line_numbers).
        IF line_numbers-group <> group.
          aggregated_data = VALUE #( BASE aggregated_data
            ( group   = group
              count   = count
              sum     = sum
              min     = min
              max     = max
              average = sum / count ) ).

          CLEAR: sum, count.
          group = line_numbers-group.
          min = line_numbers-number.
        ENDIF.

        count = count + 1.
        sum = sum + line_numbers-number.
        max = line_numbers-number.
    ENDLOOP.

    aggregated_data = VALUE #( BASE aggregated_data
      ( group   = group
        count   = count
        sum     = sum
        min     = min
        max     = max
        average = sum / count ) ).
  ENDMETHOD.

ENDCLASS.

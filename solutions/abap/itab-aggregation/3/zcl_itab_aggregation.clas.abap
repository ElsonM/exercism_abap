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
    LOOP AT initial_numbers REFERENCE INTO DATA(initial_number)
      GROUP BY ( key = initial_number->group count = GROUP SIZE )
      ASCENDING REFERENCE INTO DATA(group).

      APPEND INITIAL LINE TO aggregated_data REFERENCE INTO DATA(aggregated_line).
      aggregated_line->group = group->key.
      aggregated_line->count = group->count.
      aggregated_line->min   = 999999999.

      LOOP AT GROUP group REFERENCE INTO DATA(group_line).
        aggregated_line->sum = aggregated_line->sum + group_line->number.
        aggregated_line->min = nmin( val1 = aggregated_line->min
                                     val2 = group_line->number ).
        aggregated_line->max = nmax( val1 = aggregated_line->max
                                     val2 = group_line->number ).
      ENDLOOP.

      aggregated_line->average = aggregated_line->sum / aggregated_line->count.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
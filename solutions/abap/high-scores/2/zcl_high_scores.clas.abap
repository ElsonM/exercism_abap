CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.

CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = me->scores_list.
  ENDMETHOD.

  METHOD latest.
    READ TABLE me->scores_list INTO result INDEX lines( me->scores_list ).
  ENDMETHOD.

  METHOD personalbest.
    result = REDUCE i(
      INIT max_score = 0
      FOR score IN me->scores_list
      NEXT max_score = COND i(
        WHEN score > max_score 
        THEN score
        ELSE max_score ) ).
  ENDMETHOD.

  METHOD personaltopthree.
    result = me->scores_list.

    SORT result DESCENDING.
    DELETE result FROM 4.
  ENDMETHOD.

ENDCLASS.
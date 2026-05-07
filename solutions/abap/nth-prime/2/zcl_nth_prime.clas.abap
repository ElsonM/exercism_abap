CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.

ENDCLASS.

CLASS zcl_nth_prime IMPLEMENTATION.

  METHOD prime.
    IF input <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA(prime_count) = 0.
    DATA(candidate) = 1.

    WHILE prime_count < input.
      candidate += 1.

      DATA(is_prime) = abap_true.

      IF candidate = 2.
        is_prime = abap_true.
      ELSEIF candidate MOD 2 = 0.
        is_prime = abap_false.
      ELSE.
        DATA(divisor) = 3.

        WHILE divisor * divisor <= candidate.
          IF candidate MOD divisor = 0.
            is_prime = abap_false.
            EXIT.
          ENDIF.

          divisor += 2.
        ENDWHILE.
      ENDIF.

      IF is_prime = abap_true.
        prime_count += 1.
      ENDIF.
    ENDWHILE.

    result = candidate.
  ENDMETHOD.

ENDCLASS.
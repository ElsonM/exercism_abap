CLASS zcl_rna_transcription DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS
      transcribe
        IMPORTING
          strand             TYPE string
        RETURNING
          VALUE(result)      TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_rna_transcription IMPLEMENTATION.

  METHOD transcribe.

    result = strand.

    REPLACE ALL OCCURRENCES OF 'G' IN result WITH 'X'.
    REPLACE ALL OCCURRENCES OF 'C' IN result WITH 'G'.
    REPLACE ALL OCCURRENCES OF 'X' IN result WITH 'C'.

    REPLACE ALL OCCURRENCES OF 'T' IN result WITH 'X'.
    REPLACE ALL OCCURRENCES OF 'A' IN result WITH 'U'.
    REPLACE ALL OCCURRENCES OF 'X' IN result WITH 'A'.

  ENDMETHOD.

ENDCLASS.

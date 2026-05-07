CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type,
           
           artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.

    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type,
           
           albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.

    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type,
           
           songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.

    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type,
           
           BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type,
           
           BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type,
           
           nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

  METHOD perform_nesting.

    DATA album_index TYPE i.
    DATA song_index  TYPE i.

    DATA line_nested_data TYPE artist_album_nested_type.
    DATA line_album_songs TYPE album_song_nested_type.
    DATA table_album_songs TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id.
    DATA table_songs TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id.

    SORT artists BY artist_id.
    SORT albums  BY artist_id album_id.
    SORT songs   BY artist_id album_id song_id.

    LOOP AT artists INTO DATA(artist).

      CLEAR line_nested_data.
      CLEAR table_album_songs.

      line_nested_data-artist_id   = artist-artist_id.
      line_nested_data-artist_name = artist-artist_name.

      album_index = line_index( albums[ artist_id = artist-artist_id ] ).

      LOOP AT albums INTO DATA(album) FROM album_index.

        IF album-artist_id <> artist-artist_id.
          EXIT.
        ENDIF.

        CLEAR line_album_songs.
        CLEAR table_songs.

        line_album_songs-album_id   = album-album_id.
        line_album_songs-album_name = album-album_name.

        song_index = line_index( songs[
          artist_id = artist-artist_id
          album_id  = album-album_id ] ).

        LOOP AT songs INTO DATA(song) FROM song_index.

          IF song-artist_id <> artist-artist_id OR 
             song-album_id  <> album-album_id.
            EXIT.
          ENDIF.

          APPEND VALUE #(
            song_id   = song-song_id
            song_name = song-song_name
          ) TO table_songs.

        ENDLOOP.

        line_album_songs-songs = table_songs.
        APPEND line_album_songs TO table_album_songs.

      ENDLOOP.

      line_nested_data-albums = table_album_songs.
      APPEND line_nested_data TO nested_data.

    ENDLOOP.
    
  ENDMETHOD.

ENDCLASS.
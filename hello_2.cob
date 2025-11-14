       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 VAR-TEXT    PIC X(30) VALUE "HELLO med variabel".


       PROCEDURE DIVISION.
      *Test
       DISPLAY VAR-TEXT
       STOP RUN.

       
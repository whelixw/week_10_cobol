       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello.
       *> Variation on hello.cob that sources the greeting from WORKING-STORAGE.
       *> Shows how DISPLAY can emit the contents of a PIC X field.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 VAR-TEXT    PIC X(30) VALUE "HELLO med variabel".


       PROCEDURE DIVISION.
      *Test
       DISPLAY VAR-TEXT
       STOP RUN.

       
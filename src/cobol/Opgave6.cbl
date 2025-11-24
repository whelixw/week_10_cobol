       Identification Division.
       Program-Id. Opgave4.
      *> Streams customer rows from data/input/kunder_2.txt and prints
      *> each name with its street address to illustrate file I/O.

       environment division.
       input-output section.
       file-control.
           select input-file assign to "data/input/kunder_2.txt"
               organization is line sequential.

       Data Division.

       File Section.
       FD  input-file.
       01 input-record.
           copy "KUNDER.cpy".


       Working-Storage Section.
       01 END-OF-FILE  PIC X VALUE "N".


       Procedure Division.
       MAIN-PROCEDURE.
           OPEN INPUT INPUT-FILE

              PERFORM UNTIL END-OF-FILE = "Y"
                     READ INPUT-FILE INTO INPUT-RECORD
                      AT END   
                          MOVE "Y" TO END-OF-FILE
                     NOT AT END
                          DISPLAY "Name: " first-name in input-record 
                          ", vej: " vejnavn in input-record
                  END-READ
              END-PERFORM
       CLOSE INPUT-FILE

           GoBack.
       End Program Opgave4.


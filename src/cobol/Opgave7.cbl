       Identification Division.
       Program-Id. Opgave4.

       environment division.
       input-output section.
       file-control.
           select input-file assign to "kunder_2.txt"
               organization is line sequential.
           select output-file assign to "output.txt"
               organization is line sequential.

       Data Division.

       File Section.
       FD  input-file.
       01 input-record.
           copy "KUNDER.cpy".

       FD output-file.
       01 output-record.
           copy "KUNDER.cpy".

       Working-Storage Section.
       01 END-OF-FILE  PIC X VALUE "N".


       Procedure Division.
       MAIN-PROCEDURE.
           OPEN INPUT INPUT-FILE
           OPEN OUTPUT OUTPUT-FILE

              PERFORM UNTIL END-OF-FILE = "Y"
                     READ INPUT-FILE INTO INPUT-RECORD
                      AT END   
                          MOVE "Y" TO END-OF-FILE
                     NOT AT END
                          MOVE INPUT-RECORD TO OUTPUT-RECORD
                          WRITE OUTPUT-RECORD
                          DISPLAY "Name: " first-name in input-record 
                          ", Age: " vejnavn in output-record
                  END-READ
              END-PERFORM
       CLOSE INPUT-FILE
       CLOSE output-file

           GoBack.
       End Program Opgave4.


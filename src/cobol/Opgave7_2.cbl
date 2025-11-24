       Identification Division.
       Program-Id. Opgave4.
      *> Reformats each customer from data/input/kunder_2.txt into a simple
      *> four-line address block written to data/output/output_2.txt.

       environment division.
       input-output section.
       file-control.
           select input-file assign to "data/input/kunder_2.txt"
               organization is line sequential.
           select output-file assign to "data/output/output_2.txt"
               organization is line sequential.

       Data Division.

       File Section.
       FD  input-file.
       01 input-record.
           copy "KUNDER.cpy".

       FD output-file.
       01 KUNDE-ADR.
           02 NAVN-ADR PIC X(100).

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
                       move customer-id to NAVN-ADR
                       write NAVN-ADR
                       move spaces to NAVN-ADR
                       

                       move first-name to NAVN-ADR
                       move last-name to NAVN-ADR
                       write NAVN-ADR
                       move spaces to NAVN-ADR

                       move vejnavn to NAVN-ADR
                       move husnr to NAVN-ADR
                       move etage to NAVN-ADR
                       move side to NAVN-ADR
                       write NAVN-ADR
                       move spaces to NAVN-ADR

                       move postnr to NAVN-ADR
                       move bynavn to NAVN-ADR
                       write NAVN-ADR
                       move spaces to NAVN-ADR
                           
                       DISPLAY "Name: " first-name in input-record 
                       ", Age: " vejnavn in input-record
                  END-READ
              END-PERFORM
       CLOSE INPUT-FILE
       CLOSE output-file

           GoBack.
       End Program Opgave4.


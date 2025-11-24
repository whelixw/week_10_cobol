       Identification Division.
       Program-Id. Opgave4.
      *> Similar to Opgave7_2 but extracts reusable FORMAT-* paragraphs to
      *> build each address block before writing to data/output/output_2.txt.

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
                       
                       write KUNDE-ADR
                       move spaces to NAVN-ADR
                       
                       perform format-navn
                       display "Formateret Navn:" NAVN-ADR
                       write KUNDE-ADR
                       move spaces to NAVN-ADR

                       perform format-vej
                       display "Formateret Vej:" NAVN-ADR
                       write KUNDE-ADR
                       move spaces to NAVN-ADR

                       perform format-by
                       display "Formateret By:" NAVN-ADR
                       write KUNDE-ADR
                       move spaces to NAVN-ADR
                           


   

                           

                  END-READ
              END-PERFORM
       CLOSE INPUT-FILE
       CLOSE output-file

           GoBack.


                       format-navn.
                           string first-name delimited by space
                               " " delimited by size
                               last-name delimited by size
                               into NAVN-ADR
                           end-string
                       exit.
                       
                       format-vej.
                           string vejnavn delimited by space
                               " " delimited by size
                               husnr delimited by space
                               " " delimited by size
                               etage delimited by space
                               " " delimited by size
                               bynavn delimited by space
                               " " delimited by size
                               into NAVN-ADR
                           end-string
                       exit.

                       format-by.
                       string bynavn delimited by space
                               " " delimited by size
                               postnr delimited by size
                               into NAVN-ADR
                           end-string
                       exit.
       End Program Opgave4.


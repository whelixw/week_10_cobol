       Identification Division.
       Program-Id. Opgave4.
      *> For each entry in data/input/kunder_2.txt, emit customer info plus
      *> a matching account pulled from data/input/KUNDEKONTO.txt into
      *> data/output/kundeoplysninger.txt.

       environment division.
       input-output section.
       file-control.
           select customer-file assign to "data/input/kunder_2.txt"
               organization is line sequential.

           select customer-account assign to "data/input/KUNDEKONTO.txt"
               organization is line sequential
               file status is FS-ACCOUNT.
           select customer-out-file assign to "data/output/kundeoplysninger.txt"
               organization is line sequential.

       Data Division.

       File Section.
       FD  customer-file.
       01 input-record.
           copy "KUNDER.cpy".

       FD  customer-account.
       01 account-record.
           copy "KONTOOPL.cpy".

       FD customer-out-file.
       01 CUSTOMER-ACCOUNT-RECORD.
           02 OUTPUT-TEXT PIC X(100).

       Working-Storage Section.
       01 WS-END-OF-CUSTOMER-FILE PIC X VALUE "N". *> For customer-file
       01 WS-END-OF-ACCOUNT-FILE  PIC X VALUE "N".  *> For customer-acco
       01 WS-ACCOUNT-FOUND-FLAG   PIC X VALUE "N".  *> To track if an ac

       01 FS-ACCOUNT           PIC XX VALUE SPACES.
       01 WS-ID-AC-DISP        PIC X(40).   *> for safe DISPLAY


       Procedure Division.
       MAIN-PROCEDURE.
           OPEN INPUT customer-file
           OPEN OUTPUT customer-out-file

              PERFORM UNTIL WS-END-OF-CUSTOMER-FILE = "Y"
                     READ customer-file INTO INPUT-RECORD
                      AT END   
                          MOVE "Y" TO WS-END-OF-CUSTOMER-FILE
                     NOT AT END
                       move customer-id to OUTPUT-TEXT
                       
                       write CUSTOMER-ACCOUNT-RECORD
                       move spaces to OUTPUT-TEXT
                       
                       perform format-navn
                       display "Formateret Navn:" OUTPUT-TEXT
                       write CUSTOMER-ACCOUNT-RECORD
                       move spaces to OUTPUT-TEXT

                       perform format-vej
                       display "Formateret Vej:" OUTPUT-TEXT
                       write CUSTOMER-ACCOUNT-RECORD
                       move spaces to OUTPUT-TEXT

                       perform format-by
                       display "Formateret By:" OUTPUT-TEXT
                       write CUSTOMER-ACCOUNT-RECORD
                       move spaces to OUTPUT-TEXT

                       perform format-account
                       display "Account INFO:" OUTPUT-TEXT
                       write CUSTOMER-ACCOUNT-RECORD
                       move spaces to OUTPUT-TEXT
                           


   

                           

                  END-READ
              END-PERFORM
       CLOSE customer-file
       CLOSE customer-out-file

           GoBack.


                       format-navn.
                           string first-name delimited by space
                               " " delimited by size
                               last-name delimited by size
                               into OUTPUT-TEXT
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
                               into OUTPUT-TEXT
                           end-string
                       exit.

                       format-by.
                       string bynavn delimited by space
                               " " delimited by size
                               postnr delimited by size
                               into OUTPUT-TEXT
                           end-string
                       exit.

      
       
       format-account.
           DISPLAY ">> Entering format-account for customer-id=[" 
                    customer-id "]"

           MOVE "N" TO WS-ACCOUNT-FOUND-FLAG
           MOVE "N" TO WS-END-OF-ACCOUNT-FILE

           STRING "No account info found for " customer-id
                INTO OUTPUT-TEXT
           END-STRING

           OPEN INPUT customer-account
           IF FS-ACCOUNT NOT = "00"
              DISPLAY "!! customer-account failed. STATUS=" FS-ACCOUNT
              EXIT PARAGRAPH
           END-IF

           PERFORM UNTIL WS-END-OF-ACCOUNT-FILE = "Y"
                      OR WS-ACCOUNT-FOUND-FLAG = "Y"
              READ customer-account INTO account-record
                 AT END
                    MOVE "Y" TO WS-END-OF-ACCOUNT-FILE
                 NOT AT END
                    *> Safe DISPLAY regardless of USAGE/COMP by moving to X
                    MOVE customer-id-ac TO WS-ID-AC-DISP
                    DISPLAY "Reading account id-ac=[" 
                            FUNCTION TRIM(WS-ID-AC-DISP) "]"

                    IF customer-id-ac = customer-id
                       STRING account-id DELIMITED BY SPACE
                              " " DELIMITED BY SIZE
                              account-type DELIMITED BY SPACE
                              " " DELIMITED BY SIZE
                              balance-ac DELIMITED BY SPACE
                              " " DELIMITED BY SIZE
                              currency-id DELIMITED BY SPACE
                              INTO OUTPUT-TEXT
                       END-STRING
                       MOVE "Y" TO WS-ACCOUNT-FOUND-FLAG
                    END-IF
              END-READ

              *> Optional: show read status codes other than success or EOF
              IF FS-ACCOUNT NOT = "00" AND FS-ACCOUNT NOT = "10"
                 DISPLAY "READ STATUS=" FS-ACCOUNT
              END-IF
           END-PERFORM

           CLOSE customer-account
       EXIT.
       End Program Opgave4.

Identification Division.
       Program-Id. Opgave4.

       environment division.
       input-output section.
       file-control.
           *> Removed: select customer-file assign to "kunder_2.txt"
           *> Removed: select customer-account assign to "KUNDEKONTO.txt"

           select bank-file assign to "Banker.txt"
               organization is line sequential
               file status is FS-BANK.

           select transaction-file assign to "Transaktioner_gen.txt"
               organization is line sequential
               file status is FS-TRANSACTION.


           select report-file assign to "rapport.txt"
               organization is line sequential
               file status is FS-REPORT.

           *> Removed: select customer-out-file assign to "kundeoplysninger.txt"

       Data Division.

       File Section.
       *> Removed: FD  customer-file and its copybook
       *> Removed: FD  customer-account and its copybook

       FD  bank-file.
       01 BANK-RECORD.
           copy "banker.cpy".

       FD  transaction-file.
       01 TRANSACTION-RECORD.
           copy "transaktioner.cpy".

       FD  report-file.
       01  REPORT-RECORD          PIC X(220).

       *> Removed: FD customer-out-file and its 01 CUSTOMER-ACCOUNT-RECORD

       Working-Storage Section.
       *> Removed: WS-END-OF-CUSTOMER-FILE
       *> Removed: WS-END-OF-ACCOUNT-FILE
       01 WS-END-OF-BANK-FILE     PIC X VALUE "N".
       01 WS-END-OF-TRANSACTION-FILE PIC X VALUE "N".

       *> Removed: WS-ACCOUNT-FOUND-FLAG

       *> Removed: FS-ACCOUNT
       01 FS-BANK              PIC XX VALUE SPACES.
       01 FS-TRANSACTION       PIC XX VALUE SPACES.

       *> Removed: WS-ID-AC-DISP

       *> Removed: customer-array and related WS-MAX-ACCOUNT-RECORDS, WS-ACCOUNT-COUNT
       01  WS-BELOEB-NUM  PIC S9(16)V99.

       *> --- Array for Banker.txt ---
       01 WS-MAX-BANK-RECORDS     PIC 9(4) VALUE 100. *> Adjust as needed
       01 WS-BANK-COUNT           PIC 9(4) VALUE 0.
       01 BANK-ARRAY-TABLE occurs 100 times.
           copy "banker.cpy". *> Use the copybook directly for array elements

       *> --- Array for Transaktioner.txt ---
       01 WS-MAX-TRANSACTION-RECORDS PIC 9(4) VALUE 1000. *> Adjust as needed
       01 WS-TRANSACTION-COUNT     PIC 9(4) VALUE 0.
       01 TRANSACTION-ARRAY-TABLE occurs 1000 times.
           copy "transaktioner.cpy". *> Use the copybook directly for array elements

       01  IX pic 9(4) value 1.
       01  IX2 pic 9(4) value 1.


       01  C-T-REG-NR PIC X(4).

       01  LAST-CPR PIC X(15).

       01  CNV-BELOEB        PIC S9(13)V99.
       01  CNV-BELOEB-EDIT   PIC -ZZZZZZZZZZ9.99.
       01  CNV-BELOEB-PRINT    PIC -ZZZZZZZZZZ9.99 VALUE ZERO.
       01  ORIG-BELOEB-PRINT   PIC -ZZZZZZZZZZ9.99 VALUE ZERO.
       01  PRINTED-BANK-INFO PIC X VALUE "N".
       01  FS-REPORT            PIC XX VALUE SPACES.
       *> Layout for one transaction line in the report
       01  REPORT-LINE.
           05 RL-DATO-TID           PIC X(26).        *> T-TIDSPUNKT
           05 RL-SPACE1             PIC X.
           05 RL-TTYPE              PIC X(20).        *> Transaktionstype
           05 RL-SPACE2             PIC X.
           05 RL-DKK-AMOUNT         PIC -ZZZZZZZZZZ9.99.
           05 RL-SPACE3             PIC X.
           05 RL-FOREIGN-AMOUNT     PIC -ZZZZZZZZZZ9.99.
           05 RL-SPACE4             PIC X.
           05 RL-VALUTA             PIC X(4).
           05 RL-SPACE5             PIC X.
           05 RL-BUTIK              PIC X(20).


       *> We keep output-text as the raw X(220) buffer used for WRITE
       01  output-text REDEFINES REPORT-LINE PIC X(220).

       Procedure Division.
       MAIN-PROCEDURE.
           *> Removed: OPEN INPUT customer-file
           *> Removed: OPEN OUTPUT customer-out-file

           *> --- Load Banker.txt into BANK-ARRAY-TABLE once ---
           OPEN INPUT bank-file
           IF FS-BANK NOT = "00"
               DISPLAY "!! Error opening Banker.txt. STATUS=" FS-BANK
               STOP RUN
           END-IF
           MOVE "N" TO WS-END-OF-BANK-FILE
           MOVE 0 TO WS-BANK-COUNT
           PERFORM UNTIL WS-END-OF-BANK-FILE = "Y"
                     READ bank-file INTO BANK-RECORD
                      AT END
                          MOVE "Y" TO WS-END-OF-BANK-FILE
                     NOT AT END
                          IF WS-BANK-COUNT < WS-MAX-BANK-RECORDS
                              ADD 1 TO WS-BANK-COUNT
                              MOVE BANK-RECORD 
                              TO BANK-ARRAY-TABLE(WS-BANK-COUNT)
                          ELSE
                              DISPLAY "Warning: Bank array full. Max "
                                      WS-MAX-BANK-RECORDS
                                      " records loaded. Stopping read."
                              MOVE "Y" TO WS-END-OF-BANK-FILE
                          END-IF
                  END-READ
           END-PERFORM
           CLOSE bank-file
           DISPLAY "Successfully loaded " WS-BANK-COUNT " bank records."

           *> --- Load Transaktioner.txt into TRANSACTION-ARRAY-TABLE once ---
           OPEN INPUT transaction-file
           IF FS-TRANSACTION NOT = "00"
               DISPLAY "!! Error opening Transaktioner.txt. STATUS="
                FS-TRANSACTION
               STOP RUN
           END-IF
           MOVE "N" TO WS-END-OF-TRANSACTION-FILE
           MOVE 0 TO WS-TRANSACTION-COUNT
           PERFORM UNTIL WS-END-OF-TRANSACTION-FILE = "Y"
                     READ transaction-file INTO TRANSACTION-RECORD
                      AT END
                          MOVE "Y" TO WS-END-OF-TRANSACTION-FILE
                     NOT AT END
                          IF WS-TRANSACTION-COUNT
                          < WS-MAX-TRANSACTION-RECORDS
                              ADD 1 TO WS-TRANSACTION-COUNT
                              MOVE TRANSACTION-RECORD
                      TO TRANSACTION-ARRAY-TABLE(WS-TRANSACTION-COUNT)
                          ELSE
                              DISPLAY
                              "Warning: Transaction array full. Max "
                                      WS-MAX-TRANSACTION-RECORDS
                                      " records loaded. Stopping read."
                              MOVE "Y" TO WS-END-OF-TRANSACTION-FILE
                          END-IF
                  END-READ
           END-PERFORM
           CLOSE transaction-file
           DISPLAY "Successfully loaded " WS-TRANSACTION-COUNT 
               " transaction records."

           OPEN OUTPUT report-file
           IF FS-REPORT NOT = "00"
               DISPLAY "!! Error opening rapport.txt. STATUS="
                   FS-REPORT
               STOP RUN
           END-IF

           PERFORM format-transactions

           CLOSE report-file

           GoBack.
           

           *> Removed the entire customer processing loop

           *> Removed: CLOSE customer-file
           *> Removed: CLOSE customer-out-file

           GoBack.

           format-transactions.
           MOVE SPACES TO LAST-CPR
           PERFORM VARYING IX FROM 1 BY 1
               UNTIL IX > WS-TRANSACTION-COUNT

               MOVE T-REG-NR IN TRANSACTION-ARRAY-TABLE(IX)
                   TO C-T-REG-NR

               IF LAST-CPR NOT = T-CPR OF
                   TRANSACTION-ARRAY-TABLE(IX)
                   MOVE "N" TO PRINTED-BANK-INFO

                   *> "Kunde: <navn>"
                   MOVE SPACES TO output-text
                   STRING
                       "Kunde: " DELIMITED BY SIZE
                       T-NAVN OF TRANSACTION-ARRAY-TABLE(IX)
                           DELIMITED BY SIZE
                       INTO output-text
                   END-STRING
                   PERFORM write-output

                   *> "Adresse: <adresse>"
                   MOVE SPACES TO output-text
                   STRING
                       "Adresse: " DELIMITED BY SIZE
                       T-ADRESSE OF TRANSACTION-ARRAY-TABLE(IX)
                           DELIMITED BY SIZE
                       INTO output-text
                   END-STRING
                   PERFORM write-output
               ELSE
                   PERFORM FORMAT-PRINT
               END-IF

               PERFORM VARYING IX2 FROM 1 BY 1
                   UNTIL IX2 > WS-BANK-COUNT
                   IF C-T-REG-NR =
                       B-REG-NR IN BANK-ARRAY-TABLE(IX2)
                       IF PRINTED-BANK-INFO = "N"
                           MOVE "Y" TO PRINTED-BANK-INFO

                           *> Registreringsnummer
                           MOVE SPACES TO output-text
                           STRING
                               "Registreringsnummer: "
                                   DELIMITED BY SIZE
                               FUNCTION TRIM(C-T-REG-NR)
                                   DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           *> Bank
                           MOVE SPACES TO output-text
                           STRING
                               "Bank: " DELIMITED BY SIZE
                               FUNCTION TRIM(
                                   B-BANKNAVN OF BANK-ARRAY-TABLE(IX2)
                               )
                                   DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           *> Bankadresse
                           MOVE SPACES TO output-text
                           STRING
                               "Bankadresse: " DELIMITED BY SIZE
                               FUNCTION TRIM(
                                   B-BANKADRESSE OF
                                       BANK-ARRAY-TABLE(IX2)
                               )
                                   DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           *> Telefon
                           MOVE SPACES TO output-text
                           STRING
                               "Telefon: " DELIMITED BY SIZE
                               FUNCTION TRIM(
                                   B-TELEFON OF BANK-ARRAY-TABLE(IX2)
                               )
                                   DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           *> E-mail
                           MOVE SPACES TO output-text
                           STRING
                               "E-mail: " DELIMITED BY SIZE
                               FUNCTION TRIM(
                                   B-EMAIL OF BANK-ARRAY-TABLE(IX2)
                               )
                                   DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           *> Header for transactions
                           MOVE SPACES TO output-text
                           STRING
                               "--- TRANSACTION RECORD (ACCOUNT ID: "
                                   DELIMITED BY SIZE
                               FUNCTION TRIM(
                                   T-KONTO-ID OF
                                       TRANSACTION-ARRAY-TABLE(IX)
                               )
                                   DELIMITED BY SIZE
                               ") ---" DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           MOVE SPACES TO output-text
                           STRING

                          " ---Dato---|---Tidspunkt---|"
                          DELIMITED BY SIZE
                          "Transaktionstype|  +/-  |CurrencyDKK|"
                          DELIMITED BY SIZE
                          "+/-| CurrencyLocal | Butik"
                          DELIMITED BY SIZE
                               INTO output-text
                           END-STRING
                           PERFORM write-output

                           PERFORM FORMAT-PRINT
                       END-IF
                       EXIT PERFORM
                   END-IF
               END-PERFORM

               MOVE T-CPR OF TRANSACTION-ARRAY-TABLE(IX)
                   TO LAST-CPR
           END-PERFORM.
           EXIT.
               
           format-print.
               PERFORM format-valuta

               MOVE SPACES TO REPORT-LINE

               MOVE T-TIDSPUNKT OF TRANSACTION-ARRAY-TABLE(IX)
                   TO RL-DATO-TID

               MOVE T-TRANSACTIONSTYPE OF TRANSACTION-ARRAY-TABLE(IX)
                   TO RL-TTYPE

               *> Currency (DKK) - converted amount
               MOVE CNV-BELOEB-PRINT
                   TO RL-DKK-AMOUNT

               *> Currency (Foreign) - original amount
               MOVE ORIG-BELOEB-PRINT
                   TO RL-FOREIGN-AMOUNT

               MOVE T-VALUTA OF TRANSACTION-ARRAY-TABLE(IX)
                   TO RL-VALUTA

               MOVE T-BUTIK OF TRANSACTION-ARRAY-TABLE(IX)
                   TO RL-BUTIK

               PERFORM write-output
           EXIT.


           write-output.
           WRITE REPORT-RECORD FROM output-text.
           EXIT.
           format-valuta.
           *> Prepare original amount for printing
           MOVE T-BELOEB OF TRANSACTION-ARRAY-TABLE(IX)
               TO ORIG-BELOEB-PRINT

           EVALUATE FUNCTION TRIM(
                        T-VALUTA OF TRANSACTION-ARRAY-TABLE(IX))

               WHEN "EUR"
                   *> EUR -> DKK
                   
                   COMPUTE CNV-BELOEB ROUNDED =
                       T-BELOEB OF TRANSACTION-ARRAY-TABLE(IX) * 7

               WHEN "USD"
                   *> USD -> DKK
                   COMPUTE CNV-BELOEB ROUNDED =
                       T-BELOEB OF TRANSACTION-ARRAY-TABLE(IX) * 10

               WHEN OTHER
                   *> DKK or unknown: keep original amount as DKK
                   MOVE T-BELOEB OF TRANSACTION-ARRAY-TABLE(IX)
                       TO CNV-BELOEB
           END-EVALUATE

           *> Edited DKK value for printing
           MOVE CNV-BELOEB TO CNV-BELOEB-PRINT

           EXIT.
       *> Removed: format-navn, format-vej, format-by, format-account paragraphs
       End Program Opgave4.



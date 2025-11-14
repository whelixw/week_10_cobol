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

       01  output-text pic x(100).

       01  C-T-REG-NR PIC X(6).

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
           perform format-transactions
           

           *> Removed the entire customer processing loop

           *> Removed: CLOSE customer-file
           *> Removed: CLOSE customer-out-file

           GoBack.

           format-transactions.
               PERFORM VARYING IX FROM 1 BY 1
                   UNTIL IX > WS-TRANSACTION-COUNT
           
                   MOVE T-REG-NR IN TRANSACTION-ARRAY-TABLE(IX)
                        TO C-T-REG-NR
           
                   DISPLAY T-CPR OF TRANSACTION-ARRAY-TABLE(IX) "-"
                           T-NAVN OF TRANSACTION-ARRAY-TABLE(IX) "-"
                           T-REG-NR IN TRANSACTION-ARRAY-TABLE(IX) "-"
                           T-TIDSPUNKT OF TRANSACTION-ARRAY-TABLE(IX)
           
                   PERFORM VARYING IX2 FROM 1 BY 1
                        UNTIL IX2 > WS-BANK-COUNT
                            IF C-T-REG-NR = B-REG-NR
                               IN BANK-ARRAY-TABLE(IX2)
                                DISPLAY "testB"
                                 FUNCTION 
                                TRIM(BANK-ARRAY-TABLE(IX2))
                                EXIT PERFORM  *> stop scanning banks, one match only
                            END-IF
                   END-PERFORM
                   DISPLAY "---" C-T-REG-NR "---" 
                   B-REG-NR in BANK-ARRAY-TABLE(IX2) "---"
           END-PERFORM.
               


       exit.
       *> Removed: format-navn, format-vej, format-by, format-account paragraphs
       End Program Opgave4.
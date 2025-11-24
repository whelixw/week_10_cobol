       Identification Division.
       Program-Id. Opgave4.
    *> Demonstrates nested group fields for customer/account info and
    *> writes the entire structure in one DISPLAY.
       Data Division.
       Working-Storage Section.

       01 customer-info.
           02 customer-id pic x(10) value zeroes.
           02 first-name pic x(20) value spaces.
           02 last-name pic x(20) value spaces.
           02 account-info.
               03 account-number pic x(20) value zeroes.
               03 balance pic 9(7)V99 value zeroes.
               03 currency-code pic x(3) value spaces.
       
       Procedure Division.
           MOVE "1234567890" to CUSTOMER-ID
           MOVE "Lars" to FIRST-NAME
           MOVE "Hansen" to LAST-NAME
           MOVE "DK12345678912345" to ACCOUNT-NUMBER
           MOVE 2500.75 to balance
           MOVE "DKK" to currency-code
           display customer-info
           GoBack.
       End Program Opgave4.


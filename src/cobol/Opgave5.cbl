       Identification Division.
       Program-Id. Opgave4.
       Data Division.
       Working-Storage Section.
       01 customer-info.
           copy "KUNDER.cpy".


       Procedure Division.
           MOVE "1234567890" to CUSTOMER-ID
           MOVE "Lars" to FIRST-NAME
           MOVE "Hansen" to LAST-NAME
           MOVE "DK12345678912345" to ACCOUNT-NUMBER
           MOVE 2500.75 to balance
           MOVE "DKK" to currency-code
           MOVE "testvej" to VEJNAVN OF customer-info
           display customer-info
           GoBack.
       End Program Opgave4.


       Identification Division.
       Program-Id. Opgave2.
       Data Division.
       Working-Storage Section.
       01 customer-id pic x(10) value zeroes.
       01 first-name pic x(20) value spaces.
       01 last-name pic x(20) value spaces.
       01 account-number pic x(20) value zeroes.
       01 balance pic 9(7)V99 value zeroes.
       01 currency-code pic x(3) value spaces.
       
       Procedure Division.
           MOVE "1234567890" to CUSTOMER-ID
           MOVE "Lars" to FIRST-NAME
           MOVE "Hansen" to LAST-NAME
           MOVE "DK12345678912345" to ACCOUNT-NUMBER
           MOVE 2500.75 to balance
           MOVE "DKK" to currency-code
           display customer-id first-name last-name account-number
           display balance currency-code 
           GoBack.
       End Program Opgave2.

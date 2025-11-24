       Identification Division.
       Program-Id. Opgave3.
    *> Extends Opgave2 by concatenating names into FULL-NAME and then
    *> stripping duplicate spaces before displaying the cleaned result.
       Data Division.
       Working-Storage Section.
       01 customer-id pic x(10) value zeroes.
       01 first-name pic x(20) value spaces.
       01 last-name pic x(20) value spaces.
       01 account-number pic x(20) value zeroes.
       01 balance pic 9(7)V99 value zeroes.
       01 currency-code pic x(3) value spaces.
       01  full-name   pic x(40) value spaces.

       01  IX pic 9(2) value 1.
       01  IX2 pic 9(2) value 1.
       01  current-char pic x(1) value spaces.
       01  previous-char pic x(1) value spaces.
       01  pure-name pic x(40) value spaces.

  
       
       Procedure Division.
           MOVE "1234567890" to CUSTOMER-ID
           MOVE "Lars" to FIRST-NAME
           MOVE "Hansen" to LAST-NAME
           MOVE "DK12345678912345" to ACCOUNT-NUMBER
           MOVE 2500.75 to balance
           MOVE "DKK" to currency-code

           STRING first-name delimited by size " "
               delimited by size last-name
               delimited by size
               into full-name
           
           perform varying IX from 1 by 1 until IX > length of full-name
               move full-name(IX:1) to current-char
               if current-char not = space or previous-char not = space
                   move current-char to pure-name(IX2:1)
                   add 1 to IX2
               end-if
           end-perform 

           DISPLAY "----------------------------------------"
           DISPLAY "Kunde ID : " customer-id
           DISPLAY "Navn (renset) : " pure-name
           DISPLAY "Kontonummer : " account-number
           DISPLAY "Balance : " balance " " currency-code
           DISPLAY "----------------------------------------"

           GoBack.
       End Program Opgave3.

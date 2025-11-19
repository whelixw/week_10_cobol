       02 customer-id pic x(10) value zeroes.
       02 first-name pic x(20) value spaces.
       02 last-name pic x(20) value spaces.
       02 account-info.
           03 account-number pic x(20) value zeroes.
           03 balance pic 9(7)V99 value zeroes.
           03 currency-code pic x(3) value spaces.
       02 location.
           03 VEJNAVN PIC X(30) value spaces.
           03 HUSNR PIC X(5) value spaces.
           03 ETAGE PIC X(5) value spaces.
           03 SIDE PIC X(5) value spaces.
           03 BYNAVN PIC X(20) value spaces.
           03 POSTNR PIC X(4) value spaces.
           03 LANDE-KODE PIC X(2) value spaces.
       02 contact-info.
           03 TELEFON PIC X(8) value spaces.
           03 EMAIL PIC X(50) value spaces.
           
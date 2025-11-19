       identification division.
       program-id. Levenshtein.
 
       environment division.
       configuration section.
       repository.
           function all intrinsic.
       input-output section.
       file-control.
           copy "kunde-file-control.cpy".
           copy "sanction-file-control.cpy".

       data division.
       file section.
           copy "kunde-file-section.cpy".
           copy "sanction-file-section.cpy".
       working-storage section.
       77  string-a               pic x(255).
       77  string-b               pic x(255).
       77  length-a               pic 9(3).
       77  length-b               pic 9(3).
       77  distance               pic z(3).
       77  i                      pic 9(3).
       77  j                      pic 9(3).
       77  ws-kunde-eof           pic x value 'N'.
       77  ws-sanction-eof        pic x value 'N'.
       01  tab.
           05 filler              occurs 256.
              10 filler           occurs 256.
                 15 costs         pic 9(3).

       procedure division.
       main-section.
           perform read-kunde-fil
           perform read-sanction-fil
           stop run.

       read-kunde-fil section.
           open input kunde-file
           move 'N' to ws-kunde-eof
           perform until ws-kunde-eof = 'Y'
               read kunde-file
                   at end
                       move 'Y' to ws-kunde-eof
                   not at end
                       display 'KUNDE: ' kunde-id ' ' kunde-navn
               end-read
           end-perform
           close kunde-file
           exit section.

       read-sanction-fil section.
           open input sanction-file
           move 'N' to ws-sanction-eof
           perform until ws-sanction-eof = 'Y'
               read sanction-file
                   at end
                       move 'Y' to ws-sanction-eof
                   not at end
                       display 'SANCTION: ' sanction-id ' ' sanction-navn
                               ' alias ' sanction-alias-1
               end-read
           end-perform
           close sanction-file
           exit section.

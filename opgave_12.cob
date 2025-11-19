       identification division.
       program-id. Levenshtein.
 
       environment division.
       configuration section.
       repository.
           function all intrinsic.
 
       data division.
       working-storage section.
       77  string-a               pic x(255).
       77  string-b               pic x(255).
       77  length-a               pic 9(3).
       77  length-b               pic 9(3).
       77  distance               pic z(3).
       77  i                      pic 9(3).
       77  j                      pic 9(3).
       01  tab.
           05 filler              occurs 256.
              10 filler           occurs 256.
                 15 costs         pic 9(3).

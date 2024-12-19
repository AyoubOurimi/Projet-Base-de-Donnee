LOAD DATA
INFILE *
APPEND
INTO TABLE Label
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(nom, pays)
BEGINDATA
"Universal Music Group","USA"
"Warner Music Group","USA"
"Sony Music","Japon"
"EMI","UK"
"Capitol Records","USA"
"Virgin Records","UK"
"Columbia Records","USA"
"Island Records","UK"
"Atlantic Records","USA"
"Def Jam Recordings","USA"
"Motown","USA"

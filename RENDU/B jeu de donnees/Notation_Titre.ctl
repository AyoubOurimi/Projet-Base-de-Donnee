LOAD DATA
INFILE *
APPEND
INTO TABLE Notation_Titre
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, note, commentaire, notation_date DATE "YYYY-MM-DD", user_ID, Media_ID)
BEGINDATA
21,5,"Addictif","2010-03-15",1,301
22,4,"J'aime beaucoup","2011-01-12",4,302
23,3,"Pas mal","2012-08-20",8,303
24,2,"Decevant","2013-04-30",16,304
25,5,"Superbe !","2014-07-10",20,305
26,4,"Solide","2024-12-14",26,306
27,1,"A oublier","2024-12-08",26,307
28,3,"Interessant","2024-12-03",16,308
29,2,"Pas convaincu","2024-12-10",26,309
30,5,"Grandiose","2024-12-01",26,310

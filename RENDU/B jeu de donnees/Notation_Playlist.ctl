LOAD DATA
INFILE *
APPEND
INTO TABLE Notation_Playlist
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, note, commentaire, notation_date DATE "YYYY-MM-DD", user_ID, Media_ID)
BEGINDATA
31,5,"Une playlist parfaite","2010-01-01",3,401
32,4,"Bonne selection","2011-06-12",7,402
33,2,"Manque de variete","2012-03-25",12,403
34,1,"Tres ennuyeux","2013-08-30",21,404
35,3,"Pas mal","2014-02-18",9,405
36,4,"Belle decouverte","2015-05-05",6,406
37,5,"Inspirant","2016-07-20",15,407
38,2,"Peu d'interet","2017-09-10",18,408
39,1,"Mal organise","2018-12-22",2,409
40,4,"Correct mais peu mieux","2019-11-08",14,407

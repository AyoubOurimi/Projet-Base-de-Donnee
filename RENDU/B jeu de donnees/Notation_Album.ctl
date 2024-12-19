LOAD DATA
INFILE *
APPEND
INTO TABLE Notation_Album
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, note, commentaire, notation_date DATE "YYYY-MM-DD", user_ID, Media_ID)
BEGINDATA
1,3,"Moyen, sans plus","2010-02-10",5,201
2,1,"Nul","2010-05-15",10,202
3,5,"Excellent !","2011-03-20",15,203
4,4,"Tres bon album","2012-06-25",20,204
5,2,"Decevant","2013-07-10",25,205
6,5,"Un chef-d'œuvre","2014-11-01",30,206
7,3,"ecoute agreable","2015-01-22",3,207
8,4,"Solide performance","2016-04-30",7,208
9,5,"Indispensable","2017-09-14",12,209
10,2,"Manque de coherence","2018-12-10",18,210

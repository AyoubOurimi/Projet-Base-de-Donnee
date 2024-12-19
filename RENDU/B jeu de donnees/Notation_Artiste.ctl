LOAD DATA
INFILE *
APPEND
INTO TABLE Notation_Artiste
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, note, commentaire, notation_date DATE "YYYY-MM-DD", user_ID, Media_ID)
BEGINDATA
11,4,"Tres talentueux","2010-06-15",8,101
12,5,"Genie musical","2011-08-20",2,102
13,3,"Peut mieux faire","2012-11-10",14,103
14,2,"Pas a mon goût","2013-03-05",29,104
15,5,"Legendaire","2014-10-25",27,105
16,4,"Tres bon live","2015-07-30",9,106
17,3,"Correct","2016-02-19",19,107
18,5,"Un classique","2017-05-22",13,108
19,1,"Surestime","2018-09-09",11,109
20,2,"Bof...","2019-12-11",6,110

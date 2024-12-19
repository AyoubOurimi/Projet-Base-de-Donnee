LOAD DATA
INFILE *
APPEND
INTO TABLE Playlist
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, nom, date_creation DATE "YYYY-MM-DD", publique, user_id)
BEGINDATA
401,"Playlist1","2022-02-02",1,1
402,"Playlist2","2022-03-03",0,2
403,"Playlist3","2022-04-04",1,3
404,"Playlist4","2022-05-05",0,4
405,"Playlist5","2022-06-06",1,5
406,"Playlist6","2022-07-07",0,6
407,"Playlist7","2022-08-08",1,7
408,"Playlist8","2022-09-09",0,16
409,"Playlist9","2022-10-10",1,9
410,"Playlist10","2022-11-11",0,10
411,"Playlist11","2022-12-12",1,11
412,"Playlist12","2022-01-13",0,12
413,"Playlist13","2022-02-14",1,2
414,"Playlist14","2022-03-15",0,14
415,"Playlist15","2022-04-16",1,15
416,"Playlist16","2022-05-17",0,16
417,"Playlist17","2022-06-18",1,17
418,"Playlist18","2022-07-19",0,1
419,"Playlist19","2022-08-20",1,19
420,"Playlist20","2022-09-21",0,2
421,"Playlist21","2022-10-22",1,21
422,"Playlist22","2022-11-23",0,22
423,"Playlist23","2022-12-24",1,3
424,"Playlist24","2022-01-25",0,24
425,"Playlist25","2022-02-26",1,1
426,"Playlist26","2022-03-27",0,26
427,"Playlist27","2022-04-28",1,27
428,"Playlist28","2022-05-01",0,16
429,"Playlist29","2022-06-02",1,1
430,"Playlist30","2022-07-03",0,30

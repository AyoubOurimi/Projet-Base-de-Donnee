LOAD DATA
INFILE *
APPEND
INTO TABLE Album
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, nom, date_sortie DATE "YYYY-MM-DD", artiste_principal, label_nom)
BEGINDATA
201,"Album1","2010-02-02",101,"Sony Music"
202,"Album2","2010-03-03",102,"Capitol Records"
203,"Album3","2010-04-04",103,"Island Records"
204,"Album4","2010-05-05",104,"Motown"
205,"Album5","2010-06-06",105,"Universal Music Group"
206,"Album6","2010-07-07",106,"Sony Music"
207,"Album7","2010-08-08",107,"Capitol Records"
208,"Album8","2010-09-09",108,"Island Records"
209,"Album9","2010-10-10",109,"Motown"
210,"Album10","2010-11-11",110,"Universal Music Group"
211,"Album11","2010-12-12",111,"Sony Music"
212,"Album12","2010-01-13",112,"Capitol Records"
213,"Album13","2010-02-14",113,"Island Records"
214,"Album14","2010-03-15",114,"Motown"
215,"Album15","2010-04-16",115,"Universal Music Group"
216,"Album16","2010-05-17",116,"Sony Music"
217,"Album17","2010-06-18",117,"Capitol Records"
218,"Album18","2010-07-19",118,"Island Records"
219,"Album19","2010-08-20",119,"Motown"
220,"Album20","2010-09-21",120,"Universal Music Group"
221,"Album21","2010-10-22",121,"Sony Music"
222,"Album22","2010-11-23",122,"Capitol Records"
223,"Album23","2010-12-24",123,"Island Records"
224,"Album24","2010-01-25",124,"Motown"
225,"Album25","2010-02-26",125,"Universal Music Group"
226,"Album26","2010-03-27",126,"Sony Music"
227,"Album27","2010-04-28",127,"Capitol Records"
228,"Album28","2010-05-01",128,"Island Records"
229,"Album29","2010-06-02",129,"Motown"
230,"Album30","2010-07-03",130,"Universal Music Group"

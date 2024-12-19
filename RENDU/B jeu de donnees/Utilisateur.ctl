LOAD DATA
INFILE *
APPEND
INTO TABLE Utilisateur
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, nom, email, date_naissance DATE "YYYY-MM-DD", date_inscription DATE "YYYY-MM-DD", nationalite)
BEGINDATA
1,"User1","user1@mail.com","1990-02-02","2022-02-02","Americaine"
2,"User2","user2@mail.com","1990-03-03","2022-03-03","Anglaise"
3,"User3","user3@mail.com","1990-04-04","2022-04-04","Espagnole"
4,"User4","user4@mail.com","1990-05-05","2022-05-05","Allemande"
5,"User5","user5@mail.com","1990-06-06","2022-06-06","Francaise"
6,"User6","user6@mail.com","1990-07-07","2022-07-07","Americaine"
7,"User7","user7@mail.com","1990-08-08","2022-08-08","Anglaise"
8,"User8","user8@mail.com","1990-09-09","2022-09-09","Espagnole"
9,"User9","user9@mail.com","1990-10-10","2022-10-10","Allemande"
10,"User10","user10@mail.com","1990-11-11","2022-11-11","Francaise"
11,"User11","user11@mail.com","1990-12-12","2022-12-12","Americaine"
12,"User12","user12@mail.com","1990-01-13","2022-01-13","Anglaise"
13,"User13","user13@mail.com","1990-02-14","2022-02-14","Espagnole"
14,"User14","user14@mail.com","1990-03-15","2022-03-15","Allemande"
15,"User15","user15@mail.com","1990-04-16","2022-04-16","Francaise"
16,"User16","user16@mail.com","1990-05-17","2022-05-17","Americaine"
17,"User17","user17@mail.com","1990-06-18","2022-06-18","Anglaise"
18,"User18","user18@mail.com","1990-07-19","2022-07-19","Espagnole"
19,"User19","user19@mail.com","1990-08-20","2022-08-20","Allemande"
20,"User20","user20@mail.com","1990-09-21","2022-09-21","Francaise"
21,"User21","user21@mail.com","1990-10-22","2022-10-22","Americaine"
22,"User22","user22@mail.com","1990-11-23","2022-11-23","Anglaise"
23,"User23","user23@mail.com","1990-12-24","2022-12-24","Espagnole"
24,"User24","user24@mail.com","1990-01-25","2022-01-25","Allemande"
25,"User25","user25@mail.com","1990-02-26","2022-02-26","Francaise"
26,"User26","user26@mail.com","1990-03-27","2022-03-27","Americaine"
27,"User27","user27@mail.com","1990-04-28","2022-04-28","Anglaise"
28,"User28","user28@mail.com","1990-05-01","2022-05-01","Espagnole"
29,"User29","user29@mail.com","1990-06-02","2022-06-02","Allemande"
30,"User30","user30@mail.com","1990-07-03","2022-07-03","Francaise"

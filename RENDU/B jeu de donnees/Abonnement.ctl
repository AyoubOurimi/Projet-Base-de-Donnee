LOAD DATA
INFILE *
APPEND
INTO TABLE Abonnement
FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"'
(ID, abo_type, tarif, duree, description)
BEGINDATA
501,"Premium",9.99,30,"Acces Gratuit"
502,"Gratuit",0.00,30,"Acces Premium"
503,"Premium",9.99,30,"Acces Premium"
504,"Etudiant",4.99,30,"Acces Etudiant"
505,"Premium",9.99,30,"Acces Premium"
506,"Gratuit",0.00,30,"Acces Gratuit"
507,"Famille",14.99,30,"Acces Famille"
508,"Gratuit",0.00,30,"Acces Gratuit"
509,"Gratuit",0.00,30,"Acces Gratuit"
510,"Famille",14.99,30,"Acces Famille"
511,"Premium",9.99,30,"Acces Premium"
512,"Premium",9.99,30,"Acces Premium"
513,"Famille",14.99,30,"Acces Famille"
514,"Premium",9.99,30,"Acces Premium"
515,"Famille",14.99,30,"Acces Famille"
516,"Gratuit",0.00,30,"Acces Gratuit"
517,"Gratuit",0.00,30,"Acces Gratuit"
518,"Famille",14.99,30,"Acces Famille"
519,"Gratuit",0.00,30,"Acces Gratuit"
520,"Gratuit",0.00,30,"Acces Gratuit"
521,"Premium",9.99,30,"Acces Premium"
522,"Famille",14.99,30,"Acces Famille"
523,"Etudiant",4.99,30,"Acces Etudiant"
524,"Gratuit",0.00,30,"Acces Gratuit"
525,"Gratuit",0.00,30,"Acces Gratuit"
526,"Premium",9.99,30,"Acces Premium"
527,"Premium",9.99,30,"Acces Premium"
528,"Etudiant",4.99,30,"Acces Etudiant"
529,"Gratuit",0.00,30,"Acces Gratuit"
530,"Gratuit",0.00,30,"Acces Gratuit"

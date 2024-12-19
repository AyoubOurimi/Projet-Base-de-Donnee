-- 1. Albums les plus écoutés par genre au cours des 30 derniers jours

SELECT g.nom AS genre, a.nom AS album, COUNT(h.titre_ID) AS nb_lectures
FROM Historique h, Titre t, Album a, Est_du e, Genre g
WHERE h.titre_ID = t.ID
  AND t.album_id = a.ID
  AND a.ID = e.Album_ID
  AND e.nom = g.nom
  AND h.date_ecoute >= SYSDATE - 30
GROUP BY g.nom, a.nom
ORDER BY g.nom, nb_lectures DESC;

-- 2. Utilisateurs ayant écoutés plus de 1 heure de musique ce mois-ci

SELECT u.nom, SUM(h.duree_ecoute) AS duree_totale
FROM Historique h, Utilisateur u
WHERE h.user_ID = u.ID
  AND TRUNC(h.date_ecoute, 'MM') = TRUNC(SYSDATE, 'MM')
GROUP BY u.nom
HAVING SUM(h.duree_ecoute) > 60;

-- 3. Top 5 des albums les mieux notés de tous les temps

SELECT * 
FROM (SELECT a.nom AS album, AVG(n.note) AS note_moyenne
	FROM Notation_Album n, Album a
	WHERE n.media_ID = a.ID
	GROUP BY a.nom
	ORDER BY note_moyenne DESC)
WHERE ROWNUM <= 5;

-- 4. Durée totale des titres dans une playlist spécifique

SELECT p.nom AS playlist, SUM(t.duree) AS duree_totale
FROM Playlist p, Est_Dans ed, Titre t
WHERE p.ID = ed.Playlist_ID
  AND ed.Titre_ID = t.ID
  AND p.nom = 'Playlist5'
GROUP BY p.nom;

-- 5. Trouver les albums dont la note est égale à 5.

SELECT a.ID AS Album_ID, a.nom AS Album_Nom
FROM Album a, Notation_Album na
WHERE a.ID = na.Media_ID AND na.note = 5;

-- 6. Albums d'un artiste donné appartenant à plus d'un genre

SELECT a.nom AS album, COUNT(DISTINCT e.nom) AS nb_genres
FROM Album a, Est_du e, Artiste ar
WHERE a.ID = e.Album_ID
  AND a.artiste_principal = ar.ID
  AND ar.nom = 'Artiste18'
GROUP BY a.nom
HAVING COUNT(DISTINCT e.nom) > 1;

-- 7. Utilisateurs ayant créé au moins trois playlists publiques

SELECT u.nom, COUNT(p.ID) AS nb_playlists
FROM Playlist p, Utilisateur u
WHERE p.user_id = u.ID
  AND p.publique = 1
GROUP BY u.nom
HAVING COUNT(p.ID) >= 3;

-- 8. Titres écoutés par plus de 10 utilisateurs uniques cette semaine

SELECT t.nom AS titre, COUNT(DISTINCT h.user_ID) AS nb_utilisateurs
FROM Historique h, Titre t
WHERE h.titre_ID = t.ID
  AND h.date_ecoute >= TRUNC(SYSDATE, 'IW')
GROUP BY t.nom
HAVING COUNT(DISTINCT h.user_ID) > 10;

-- 9. Genres les plus populaires chez les utilisateurs ayant un abonnement Premium

SELECT g.nom AS genre, COUNT(h.titre_ID) AS nb_lectures
FROM Historique h, Titre t, Album a, Est_du e, Genre g, Souscrit s, Abonnement ab
WHERE h.titre_ID = t.ID
  AND t.album_id = a.ID
  AND a.ID = e.Album_ID
  AND e.nom = g.nom
  AND h.user_ID = s.User_ID
  AND s.Abo_ID = ab.ID
  AND ab.abo_type = 'Premium'
GROUP BY g.nom
ORDER BY nb_lectures DESC;

-- 10. Utilisateurs ayant écouté des titres d'un même artiste plus de 5 fois ce mois-ci

SELECT u.nom, ar.nom AS artiste, COUNT(h.titre_ID) AS nb_ecoutes
FROM Historique h, Titre t, Compose_Par cp, Artiste ar, Utilisateur u
WHERE h.titre_ID = t.ID
  AND t.ID = cp.Titre_ID
  AND cp.Artiste_ID = ar.ID
  AND h.user_ID = u.ID
  AND TRUNC(h.date_ecoute, 'MM') = TRUNC(SYSDATE, 'MM')
GROUP BY u.nom, ar.nom
HAVING COUNT(h.titre_ID) > 5;

-- 11. Répartition des abonnements (gratuit, etudiant, premium) parmi les utilisateurs

SELECT ab.abo_type AS Type_Abonnement, COUNT(s.user_id) AS Nombre_Utilisateurs
FROM Souscrit s, Abonnement ab
WHERE s.abo_id = ab.id
GROUP BY ab.abo_type;

-- 12. Les titres les plus commentés.

SELECT t.nom AS Titre, COUNT(n.ID) AS Nombre_Commentaires
FROM Titre t, Notation_Titre n
WHERE t.id = n.media_id
GROUP BY t.nom, t.id
ORDER BY Nombre_Commentaires DESC;

-- 13. Les utilisateurs qui ont écouté plus de 3 titres de rock cette année.

SELECT h.user_id
FROM Historique h, Titre t, Album a, Est_du ed
WHERE h.titre_id = t.id
    AND t.album_id = a.id
    AND a.id = ed.album_id
    AND ed.nom = 'Rock'
    AND EXTRACT(YEAR FROM h.date_ecoute) = EXTRACT(YEAR FROM SYSDATE)
GROUP BY h.user_id
HAVING COUNT(DISTINCT h.titre_id) > 3;

-- 14. Les albums qui n’ont pas encore été notés par un utilisateur.

SELECT al.id AS ID_Album, al.nom AS Nom_Album
FROM Album al
WHERE al.id NOT IN (SELECT na.media_id FROM Notation_Album na);

-- 15. La note moyenne des albums d’un genre musical donné.

SELECT al.nom AS Nom_Album, AVG(n.note) AS Moyenne
FROM Album al, Est_du ed, Notation_Album n
WHERE al.id = ed.album_id AND al.id = n.media_id AND ed.nom = 'Classique'
GROUP BY al.nom, al.id;

-- 16. Les utilisateurs qui ont laissé plus de 3 commentaires sur des titres au cours du dernier mois.

SELECT u.ID AS Utilisateur_ID, u.nom AS Utilisateur_Nom, COUNT(nt.ID) AS Nombre_Commentaires
FROM Utilisateur u, Notation_Titre nt
WHERE u.ID = nt.user_ID
  AND nt.notation_date >= ADD_MONTHS(SYSDATE, -1)
GROUP BY u.ID, u.nom
HAVING COUNT(nt.ID) > 3;

-- 17. Albums produits par un label spécifique

SELECT a.nom AS album
FROM Album a
WHERE a.label_nom = 'Sony Music';

-- 18. Labels ayant produit plus de 5 albums dans les 15 dernières années

SELECT l.nom AS label, COUNT(a.ID) AS nb_albums
FROM Label l, Album a
WHERE l.nom = a.label_nom
  AND a.date_sortie >= ADD_MONTHS(SYSDATE, -180)
GROUP BY l.nom
HAVING COUNT(a.ID) > 5;

-- 19. Labels ayant produit des albums dans plusieurs genres musicaux

SELECT l.nom AS label
FROM Label l, Album a, Est_du e, Genre g
WHERE l.nom = a.label_nom
  AND a.ID = e.Album_ID
  AND e.nom = g.nom
GROUP BY l.nom
HAVING COUNT(DISTINCT g.nom) > 1;

-- 20. Les labels qui ont produit des albums ayant reçu une note moyenne supérieure à 4 au cours des 15 dernières années.

SELECT l.nom AS Label_Nom, AVG(na.note) AS Note_Moyenne
FROM Label l, Album a, Notation_Album na
WHERE l.nom = a.label_nom
  AND a.ID = na.Media_ID
  AND na.notation_date >= ADD_MONTHS(SYSDATE, -180)
GROUP BY l.nom
HAVING AVG(na.note) > 4;

-- 21. Labels ayant le plus grand nombre d’artistes
SELECT * 
FROM (SELECT l.nom AS label, COUNT(ar.ID) AS nb_artistes
      	FROM Label l, Artiste ar
	WHERE l.nom = ar.label_nom
	GROUP BY l.nom
	ORDER BY nb_artistes DESC)
WHERE ROWNUM <= 1;

-- 22. Nationalité des utilisateurs qui écoutent le plus un artiste

SELECT ar.nom AS artiste, u.nationalite, COUNT(h.titre_ID) AS nb_ecoutes
FROM Artiste ar, Compose_Par cp, Titre t, Historique h, Utilisateur u
WHERE ar.ID = cp.Artiste_ID
  AND cp.Titre_ID = t.ID
  AND h.titre_ID = t.ID
  AND h.user_ID = u.ID
GROUP BY ar.nom, u.nationalite
ORDER BY nb_ecoutes DESC; 

-- 23 Albums les plus écoutés par genre au cours des 30 derniers jours

SELECT g.nom AS genre, a.nom AS album, COUNT(h.titre_ID) AS nb_lectures
FROM Historique h, Titre t, Album a, Est_du e, Genre g
WHERE h.titre_ID = t.ID
  AND t.album_id = a.ID
  AND a.ID = e.Album_ID
  AND e.nom = g.nom
  AND h.date_ecoute >= SYSDATE - 30
GROUP BY g.nom, a.nom
ORDER BY g.nom, nb_lectures DESC;

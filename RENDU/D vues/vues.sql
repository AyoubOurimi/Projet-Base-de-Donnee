-- Vue Media
CREATE OR REPLACE VIEW Media AS
    SELECT p.id AS Media_ID, p.nom AS nom
    FROM Playlist p
UNION
    SELECT a.id AS Media_ID, a.nom AS nom
    FROM Artiste a
UNION
    SELECT t.id AS Media_ID, t.nom AS nom
    FROM Titre t
UNION
    SELECT al.id AS Media_ID, al.nom AS nom
    FROM Album al; 
    
-- Vues Notation
CREATE OR REPLACE VIEW Notation AS
	SELECT 'Album' AS type_media, na.ID, na.note, na.commentaire, na.notation_date, na.user_ID, na.Media_ID
	FROM Notation_Album na
UNION ALL
	SELECT 'Titre' AS type_media, nt.ID, nt.note, nt.commentaire, nt.notation_date, nt.user_ID, nt.Media_ID
	FROM Notation_Titre nt
UNION ALL
	SELECT 'Playlist' AS type_media, np.ID, np.note, np.commentaire, np.notation_date, np.user_ID, np.Media_ID
	FROM Notation_Playlist np
UNION ALL
	SELECT 'Artiste' AS type_media, nar.ID, nar.note, nar.commentaire, nar.notation_date, nar.user_ID, nar.Media_ID
	FROM Notation_Artiste nar;

-- Vue Utilisateur

CREATE OR REPLACE VIEW Vue_Utilisateur AS
SELECT u.ID AS Utilisateur_ID, 
       u.nom AS Nom, 
       u.email AS Email, 
       u.date_naissance AS Date_Naissance, 
       u.date_inscription AS Date_Inscription, 
       u.nationalite AS Nationalite,
       h.date_ecoute AS Date_Ecoute, 
       h.duree_ecoute AS Duree_Ecoute, 
       h.titre_ID AS Titre_ID,
       p.ID AS Playlist_ID, 
       p.nom AS Playlist_Nom, 
       p.date_creation AS Date_Creation, 
       p.publique AS Est_Publique,
       n.type_media AS Type_Media, 
       n.ID AS Note_ID, 
       n.note AS Note, 
       n.commentaire AS Commentaire, 
       n.notation_date AS Date_Commentaire, 
       n.Media_ID AS Media_ID
FROM Utilisateur u
LEFT JOIN Historique h ON u.ID = h.user_ID
LEFT JOIN Playlist p ON u.ID = p.user_ID
LEFT JOIN Notation n ON u.ID = n.user_ID;

-- Vue Artiste

CREATE OR REPLACE VIEW Vue_Artiste AS
SELECT ar.ID AS Artiste_ID, ar.nom AS Artiste_Nom, ar.biographie, ar.nationalite,
       a.ID AS Album_ID, a.nom AS Album_Nom, a.date_sortie, a.label_nom,
       t.ID AS Titre_ID, t.nom AS Titre_Nom, t.duree, t.explicit,
       n.note, n.commentaire, n.notation_date
FROM Artiste ar
LEFT JOIN Album a ON ar.ID = a.artiste_principal
LEFT JOIN Titre t ON a.ID = t.album_id
LEFT JOIN Notation n ON n.Media_ID = t.ID
WHERE n.type_media = 'Titre' OR n.type_media = 'Album';

-- Vue Label

CREATE OR REPLACE VIEW Vue_Label AS
SELECT l.nom AS Label_Nom, l.pays AS Label_Pays,
       ar.ID AS Artiste_ID, ar.nom AS Artiste_Nom, ar.date_naissance, ar.nationalite,
       a.ID AS Album_ID, a.nom AS Album_Nom, a.date_sortie,
       COUNT(t.ID) AS Nombre_Titres, AVG(n.note) AS Note_Moyenne
FROM Label l
LEFT JOIN Artiste ar ON l.nom = ar.label_nom
LEFT JOIN Album a ON ar.ID = a.artiste_principal
LEFT JOIN Titre t ON a.ID = t.album_id
LEFT JOIN Notation n ON n.Media_ID = a.ID
WHERE n.type_media = 'Album'
GROUP BY l.nom, l.pays, ar.ID, ar.nom, ar.date_naissance, ar.nationalite, a.ID, a.nom, a.date_sortie;

-- 1. Un utilisateur ne peut avoir qu’un seul abonnement actif à un moment donné.

CREATE OR REPLACE TRIGGER VerifAbonnementActif
BEFORE INSERT OR UPDATE ON Souscrit
FOR EACH ROW
DECLARE
    nb_actifs INT;
BEGIN
    -- Vérifier si un abonnement actif existe déjà pour l'utilisateur
    SELECT COUNT(*)
    INTO nb_actifs
    FROM Souscrit
    WHERE User_ID = :NEW.User_ID
      AND :NEW.Date_Debut_Souscription <= Date_Fin_Souscription
      AND :NEW.Date_Fin_Souscription >= Date_Debut_Souscription;

    -- Si un chevauchement est détecté, lever une erreur
    IF nb_actifs > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'utilisateur a déjà un abonnement actif pendant cette période.');
    END IF;
END;
/


--2. Un album ne peut pas appartenir à plus de trois genres musicaux.

CREATE OR REPLACE TRIGGER VerifGenreAlbum
BEFORE INSERT OR UPDATE ON Est_du
FOR EACH ROW
DECLARE
    nb_genres INT;
BEGIN
    SELECT COUNT(*)
    INTO nb_genres
    FROM Est_du
    WHERE Album_ID = :NEW.Album_ID;

    IF nb_genres >= 3 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Un album ne peut pas appartenir à plus de trois genres musicaux.');
    END IF;
END;
/


--3. Un utilisateur ne peut noter qu’un média une seule fois.

- Pour les albums :
 
CREATE OR REPLACE TRIGGER VerifNoteAlbum
BEFORE INSERT OR UPDATE ON Notation_Album
FOR EACH ROW
DECLARE
    nb_notes INT;
BEGIN
    -- Vérifier si l'utilisateur a déjà noté cet album
    SELECT COUNT(*)
    INTO nb_notes
    FROM Notation_Album
    WHERE user_ID = :NEW.user_ID
      AND Media_ID = :NEW.Media_ID;

    -- Si une note existe déjà, lever une exception
    IF nb_notes > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Un utilisateur ne peut noter un album plusieurs fois.');
    END IF;
END;
/

- Pour les artistes :

CREATE OR REPLACE TRIGGER VerifNoteArtiste
BEFORE INSERT OR UPDATE ON Notation_Artiste
FOR EACH ROW
DECLARE
    nb_notes INT;
BEGIN
    SELECT COUNT(*)
    INTO nb_notes
    FROM Notation_Artiste
    WHERE user_ID = :NEW.user_ID
      AND Media_ID = :NEW.Media_ID;

    IF nb_notes > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Un utilisateur ne peut noter un artiste qu''une seule fois.');
    END IF;
END;
/


- Pour les titres : 

CREATE OR REPLACE TRIGGER VerifNoteTitre
BEFORE INSERT OR UPDATE ON Notation_Titre
FOR EACH ROW
DECLARE
    nb_notes INT;
BEGIN
    SELECT COUNT(*)
    INTO nb_notes
    FROM Notation_Titre
    WHERE user_ID = :NEW.user_ID
      AND Media_ID = :NEW.Media_ID;

    IF nb_notes > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Un utilisateur ne peut noter un titre qu''une seule fois.');
    END IF;
END;
/

- Pour les playlists :

CREATE OR REPLACE TRIGGER VerifNotePlaylist
BEFORE INSERT OR UPDATE ON Notation_Playlist
FOR EACH ROW
DECLARE
    nb_notes INT;
BEGIN
    SELECT COUNT(*)
    INTO nb_notes
    FROM Notation_Playlist
    WHERE user_ID = :NEW.user_ID
      AND Media_ID = :NEW.Media_ID;

    IF nb_notes > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Un utilisateur ne peut noter une playlist qu''une seule fois.');
    END IF;
END;
/


--4. La note attribuée à un média doit être comprise entre 1 et 5.

- Pour les albums : 

CREATE OR REPLACE TRIGGER VerifNoteAlbumValide
BEFORE INSERT OR UPDATE ON Notation_Album
FOR EACH ROW
BEGIN
    IF :NEW.note < 1 OR :NEW.note > 5 THEN
        RAISE_APPLICATION_ERROR(-20012, 'La note pour un album doit être comprise entre 1 et 5.');
    END IF;
END;
/


- Pour les artistes :

CREATE OR REPLACE TRIGGER VerifNoteArtisteValide
BEFORE INSERT OR UPDATE ON Notation_Artiste
FOR EACH ROW
BEGIN
    IF :NEW.note < 1 OR :NEW.note > 5 THEN
        RAISE_APPLICATION_ERROR(-20013, 'La note pour un artiste doit être comprise entre 1 et 5.');
    END IF;
END;
/

- Pour les titres :

CREATE OR REPLACE TRIGGER VerifNoteTitreValide
BEFORE INSERT OR UPDATE ON Notation_Titre
FOR EACH ROW
BEGIN
    -- Vérifie que la note est comprise entre 1 et 5
    IF :NEW.note < 1 OR :NEW.note > 5 THEN
        RAISE_APPLICATION_ERROR(-20014, 'La note pour un titre doit être comprise entre 1 et 5.');
    END IF;
END;
/

- pour les playlist : 

CREATE OR REPLACE TRIGGER VerifNotePlaylistValide
BEFORE INSERT OR UPDATE ON Notation_Playlist
FOR EACH ROW
BEGIN
    -- Vérifie que la note est comprise entre 1 et 5
    IF :NEW.note < 1 OR :NEW.note > 5 THEN
        RAISE_APPLICATION_ERROR(-20015, 'La note pour une playlist doit être comprise entre 1 et 5.');
    END IF;
END;
/


--5. Un album doit contenir au moins un titre.

- Sur album avant ajout ou modification (s'assurer qu'il y a au moins un titre) :

CREATE OR REPLACE TRIGGER AlbumDoitAvoirUnTitre
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
DECLARE
    nb_titres INT;
BEGIN
    SELECT COUNT(*)
    INTO nb_titres
    FROM Titre
    WHERE album_id = :NEW.ID;

    IF nb_titres = 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Un album doit contenir au moins un titre.');
    END IF;
END;
/

- Sur titre avant suppression (pour s'assurer que la suppression du titre ne rendrait pas l'album vide)

CREATE OR REPLACE TRIGGER AlbumDoitAvoirUnTitreSurTitre
BEFORE DELETE ON Titre
FOR EACH ROW
DECLARE
    nb_titres INT;
BEGIN
    SELECT COUNT(*)
    INTO nb_titres
    FROM Titre
    WHERE album_id = :OLD.album_id;

    IF nb_titres = 1 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Un album doit contenir au moins un titre.');
    END IF;
END;
/


--6. Un artiste ne peut être affilié qu’à un seul label à un moment donné.

CREATE OR REPLACE TRIGGER VerifUnSeulLabelParArtiste
BEFORE INSERT OR UPDATE ON Artiste
FOR EACH ROW
DECLARE
    nb_labels NUMBER;
BEGIN
    -- Vérifie si l'artiste est déjà affilié à un autre label
    SELECT COUNT(*) INTO nb_labels
    FROM Artiste
    WHERE ID = :NEW.ID
      AND label_nom IS NOT NULL
      AND label_nom != :NEW.label_nom;

    -- Si l'artiste est déjà affilié à un autre label, lève une erreur
    IF nb_labels > 0 THEN
        RAISE_APPLICATION_ERROR(-20022, 'Un artiste ne peut être affilié qu’à un seul label à un moment donné.');
    END IF;
END;
/

--7. Un label doit avoir au moins un artiste sous contrat.

CREATE OR REPLACE TRIGGER LabelDoitAvoirUnArtiste
BEFORE INSERT OR DELETE ON Label
FOR EACH ROW
DECLARE
    nb_artistes NUMBER;
BEGIN
    -- Si l'opération est une insertion
    IF INSERTING THEN
        -- Vérifie si le label a déjà au moins un artiste sous contrat
        SELECT COUNT(*) INTO nb_artistes
        FROM Artiste
        WHERE label_nom = :NEW.nom;

        -- Si aucun artiste n'est associé à ce label, lève une erreur
        IF nb_artistes = 0 THEN
            RAISE_APPLICATION_ERROR(-20024, 'Un label doit avoir au moins un artiste sous contrat avant son ajout.');
        END IF;
    END IF;

    -- Si l'opération est une suppression
    IF DELETING THEN
        -- Vérifie si le label a des artistes sous contrat
        SELECT COUNT(*) INTO nb_artistes
        FROM Artiste
        WHERE label_nom = :OLD.nom;

        -- Si aucun artiste n'est associé à ce label, lève une erreur
        IF nb_artistes = 0 THEN
            RAISE_APPLICATION_ERROR(-20025, 'Un label doit avoir au moins un artiste sous contrat avant sa suppression.');
        END IF;
    END IF;
END;
/

--8. Un album est obligatoirement produit par un label et associé à un artiste.

CREATE OR REPLACE TRIGGER AlbumDoitAvoirArtisteEtLabel
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
DECLARE
    artiste_exist NUMBER;
    label_exist NUMBER;
BEGIN
    -- Vérification si l'artiste principal existe
    SELECT COUNT(*) INTO artiste_exist
    FROM Artiste
    WHERE ID = :NEW.artiste_principal;

    -- Si l'artiste principal n'existe pas, lève une erreur
    IF artiste_exist = 0 THEN
        RAISE_APPLICATION_ERROR(-20026, 'L''album doit être associé à un artiste existant.');
    END IF;

    -- Vérification si le label existe
    SELECT COUNT(*) INTO label_exist
    FROM Label
    WHERE nom = :NEW.label_nom;

    -- Si le label n'existe pas, lève une erreur
    IF label_exist = 0 THEN
        RAISE_APPLICATION_ERROR(-20027, 'L''album doit être produit par un label existant.');
    END IF;
END;
/

--9. Un album ne peut pas appartenir à plus d’un label.

CREATE OR REPLACE TRIGGER VerifierUnSeulLabelParAlbum
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
DECLARE
    label_count NUMBER;
BEGIN
    -- Vérifie si cet album est déjà associé à un autre label
    SELECT COUNT(*)
    INTO label_count
    FROM Album
    WHERE ID = :NEW.ID
      AND label_nom != :NEW.label_nom;

    -- Si le label est différent, lève une erreur
    IF label_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20028, 'Un album ne peut pas appartenir à plus d’un label.');
    END IF;
END;
/


--10. Un artiste ne peut pas sortir un album sans être affilié à un label.

CREATE OR REPLACE TRIGGER VerifierArtisteAffilieLabel
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
DECLARE
    artiste_label_count NUMBER;
BEGIN
    -- Vérifie si l'artiste principal est affilié à un label
    SELECT COUNT(*)
    INTO artiste_label_count
    FROM Artiste
    WHERE ID = :NEW.artiste_principal
      AND label_nom IS NOT NULL;

    -- Si l'artiste n'est pas affilié à un label, lève une erreur
    IF artiste_label_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20029, 'Un artiste ne peut pas sortir un album sans être affilié à un label.');
    END IF;
END;
/


--11. Un titre doit appartenir à un album.

CREATE OR REPLACE TRIGGER VerifierTitreAvecAlbum
BEFORE INSERT OR UPDATE ON Titre
FOR EACH ROW
BEGIN
    -- Vérifie que le titre est associé à un album
    IF :NEW.album_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20030, 'Un titre doit appartenir à un album.');
    END IF;
END;
/


--12. Chaque identifiants doit être différents des uns des autres.

CREATE OR REPLACE TRIGGER VerifierIdentifiantsUniques
BEFORE INSERT OR UPDATE ON Utilisateur
FOR EACH ROW
DECLARE
    compteur INTEGER;
BEGIN
    -- Vérifie l'unicité de l'identifiant dans les tables Artiste, Album et autres
    SELECT COUNT(*)
    INTO compteur
    FROM (
        SELECT ID FROM Utilisateur
        UNION ALL
        SELECT ID FROM Artiste
        UNION ALL
        SELECT ID FROM Album
        UNION ALL
        SELECT ID FROM Titre
        UNION ALL
        SELECT ID FROM Playlist
        UNION ALL
        SELECT ID FROM Abonnement
    )
    WHERE ID = :NEW.ID;

    -- Si l'identifiant existe déjà dans une autre table, lève une erreur
    IF compteur > 0 THEN
        RAISE_APPLICATION_ERROR(-20031, 'L''identifiant doit être unique dans toutes les tables.');
    END IF;
END;
/


--13. La date de sortie d’un album ne peut pas être ultérieure à la date actuelle.

CREATE OR REPLACE TRIGGER VerifierDateSortieAlbum
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
BEGIN
    -- Vérifie si la date de sortie est ultérieure à la date actuelle
    IF :NEW.date_sortie > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20032, 'La date de sortie d’un album ne peut pas être ultérieure à la date actuelle.');
    END IF;
END;
/


--14. Un artiste ne peut avoir qu’un seul album publié par mois.

CREATE OR REPLACE TRIGGER LimiterAlbumsParMois
BEFORE INSERT OR UPDATE ON Album
FOR EACH ROW
DECLARE
    nb_albums INT;
BEGIN
    -- Compte le nombre d'albums publiés par le même artiste dans le même mois
    SELECT COUNT(*)
    INTO nb_albums
    FROM Album
    WHERE artiste_principal = :NEW.artiste_principal
      AND EXTRACT(YEAR FROM date_sortie) = EXTRACT(YEAR FROM :NEW.date_sortie)
      AND EXTRACT(MONTH FROM date_sortie) = EXTRACT(MONTH FROM :NEW.date_sortie);

    -- Vérifie si le nombre d'albums dépasse 0 (l'insertion ou la mise à jour causerait un doublon dans le mois)
    IF nb_albums > 0 THEN
        RAISE_APPLICATION_ERROR(-20033, 'Un artiste ne peut avoir qu’un seul album publié par mois.');
    END IF;
END;
/


--15. Un utilisateur ne peut créer plus de 100 playlists publiques.

CREATE OR REPLACE TRIGGER LimiterPlaylistsPubliques
BEFORE INSERT OR UPDATE ON Playlist
FOR EACH ROW
DECLARE
    nb_playlists_publiques INT;
BEGIN
    -- Compte le nombre de playlists publiques déjà créées par l'utilisateur
    SELECT COUNT(*)
    INTO nb_playlists_publiques
    FROM Playlist
    WHERE user_id = :NEW.user_id
      AND publique = 1;

    -- Vérifie si le nombre de playlists publiques dépasse 100
    IF :NEW.publique = 1 AND nb_playlists_publiques >= 100 THEN
        RAISE_APPLICATION_ERROR(-20034, 'Un utilisateur ne peut pas créer plus de 100 playlists publiques.');
    END IF;
END;
/




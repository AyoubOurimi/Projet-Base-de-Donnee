-- Table Utilisateur
CREATE TABLE Utilisateur (
    ID INT,
    nom VARCHAR(255),
    email VARCHAR(255),
    date_naissance DATE,
    date_inscription DATE,
    nationalite VARCHAR(100),
    PRIMARY KEY (ID)
);

-- Table Label
CREATE TABLE Label (
    nom VARCHAR(255),
    pays VARCHAR(100),
    PRIMARY KEY (nom)
);

-- Table Artiste
CREATE TABLE Artiste (
    ID INT,
    nom VARCHAR(255),
    biographie CLOB,
    nationalite VARCHAR(100),
    date_naissance DATE,
    label_nom VARCHAR(255),
    PRIMARY KEY (ID),
    FOREIGN KEY (label_nom) REFERENCES Label(nom)
);

-- Table Album
CREATE TABLE Album (
    ID INT,
    nom VARCHAR(255),
    date_sortie DATE,
    artiste_principal INT,
    label_nom VARCHAR(255),
    PRIMARY KEY (ID),
    FOREIGN KEY (artiste_principal) REFERENCES Artiste(ID),
    FOREIGN KEY (label_nom) REFERENCES Label(nom)
);

-- Table Titre
CREATE TABLE Titre (
    ID INT,
    nom VARCHAR(255),
    duree INT,
    date_sortie DATE,
    explicit NUMBER(1) CHECK (explicit IN (0, 1)),
    album_id INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (album_id) REFERENCES Album(ID)
);

-- Table Playlist
CREATE TABLE Playlist (
    ID INT,
    nom VARCHAR(255),
    date_creation DATE,
    publique NUMBER(1) CHECK (publique IN (0, 1)),
    user_id INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (user_id) REFERENCES Utilisateur(ID)
);

-- Table Abonnement
CREATE TABLE Abonnement (
    ID INT ,
    abo_type VARCHAR(50),
    tarif NUMBER(10,2),
    duree INT,
    description CLOB,
    PRIMARY KEY (ID)
);

-- Table Genre
CREATE TABLE Genre (
    nom VARCHAR(255),
    PRIMARY KEY (nom)
);

-- Table Historique 
CREATE TABLE Historique (
    user_ID INT,
    date_ecoute DATE,
    duree_ecoute INT,
    titre_ID INT,
    PRIMARY KEY (user_ID, date_ecoute, titre_ID),
    FOREIGN KEY (user_ID) REFERENCES Utilisateur(ID),
    FOREIGN KEY (titre_ID) REFERENCES Titre(ID)
);
    
-- Table Notation Album
CREATE TABLE Notation_Album (
    ID INT,
    note INT CHECK (note BETWEEN 0 AND 5),  
    commentaire VARCHAR2(100),
    notation_date DATE,  
    user_ID INT,  
    Media_ID INT,
    PRIMARY KEY (ID), 
    FOREIGN KEY (user_ID) REFERENCES Utilisateur (ID),
    FOREIGN KEY (Media_ID) REFERENCES Album (ID) 
);

-- Table Notation Artiste
CREATE TABLE Notation_Artiste (
    ID INT,
    note INT CHECK (note BETWEEN 0 AND 5),  
    commentaire VARCHAR2(100), 
    notation_date DATE,  
    user_ID INT,  
    Media_ID INT,
    PRIMARY KEY (ID), 
    FOREIGN KEY (user_ID) REFERENCES Utilisateur (ID),
    FOREIGN KEY (Media_ID) REFERENCES Artiste (ID)
);

-- Table Notation Titre
CREATE TABLE Notation_Titre (
    ID INT,
    note INT CHECK (note BETWEEN 0 AND 5),  
    commentaire VARCHAR2(300), 
    notation_date DATE,  
    user_ID INT,  
    Media_ID INT,
    PRIMARY KEY (ID), 
    FOREIGN KEY (user_ID) REFERENCES Utilisateur (ID),
    FOREIGN KEY (Media_ID) REFERENCES Titre (ID) 
);

-- Table Notation Playlist
CREATE TABLE Notation_Playlist (
    ID INT,
    note INT CHECK (note BETWEEN 0 AND 5),  
    commentaire VARCHAR2(300),
    notation_date DATE,  
    user_ID INT,  
    Media_ID INT,
    PRIMARY KEY (ID), 
    FOREIGN KEY (user_ID) REFERENCES Utilisateur (ID),
    FOREIGN KEY (Media_ID) REFERENCES Playlist (ID)
);

-- Table Est_du (Association entre Album et Genre)
CREATE TABLE Est_du (
    Album_ID INT,
    nom VARCHAR(255),
    PRIMARY KEY (Album_ID, nom),
    FOREIGN KEY (Album_ID) REFERENCES Album(ID),
    FOREIGN KEY (nom) REFERENCES Genre(nom)
);

-- Table Souscrit (Association entre Utilisateur et Abonnement)
CREATE TABLE Souscrit (
    User_ID INT,
    Abo_ID INT,
    Date_Debut_Souscription DATE,
    Date_Fin_Souscription DATE,
    PRIMARY KEY (User_ID, Abo_ID),
    FOREIGN KEY (User_ID) REFERENCES Utilisateur(ID),
    FOREIGN KEY (Abo_ID) REFERENCES Abonnement(id)
);

-- Table Compose_Par (Association entre Artiste et Titre)
CREATE TABLE Compose_Par (
    Artiste_ID INT,
    Titre_ID INT,
    PRIMARY KEY (Artiste_ID, Titre_ID),
    FOREIGN KEY (Artiste_ID) REFERENCES Artiste(ID),
    FOREIGN KEY (Titre_ID) REFERENCES Titre(ID)
);

-- Table Est_Dans (Association entre Titre et Playlist)
CREATE TABLE Est_Dans (
    Titre_ID INT,
    Playlist_ID INT,
    PRIMARY KEY (Titre_ID, Playlist_ID),
    FOREIGN KEY (Titre_ID) REFERENCES Titre(ID),
    FOREIGN KEY (Playlist_ID) REFERENCES Playlist(ID)
);

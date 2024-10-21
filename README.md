# Projet de Base de Données Oracle

## Membres du Groupe
- **Ilyan Lalmassi**
- **César Charbey**
- **Ourimi Ayoub**

## Description du Projet
Le but de ce projet est de construire une base de données relationnelle sous Oracle afin de mettre en pratique les concepts vus en cours et d'utiliser les fonctionnalités d'un SGBD.

Le projet est divisé en deux phases :
- **Phase 1 :** Analyse des besoins et modélisation de l'application.
- **Phase 2 :** Implémentation du schéma relationnel, gestion des données, contraintes d'intégrité, vues, requêtes, et triggers.

## Organisation du Projet

### Phase 1 : Analyse et Modélisation
- **Application choisie :** Base de donnée représentant une platforme multimedia du type Spotify
- **Cahier des charges :** Définition des besoins fonctionnels de l'application.
- **Modélisation :** Conception du schéma Entité/Association (E/A).
- **Contraintes d'intégrité :** Définition des contraintes complexes en langage naturel.
- **Droits et Vues :** Définition des utilisateurs, droits d'accès, et vues.
- **Requêtes :** Définition des requêtes complexes en langage naturel.
- **Traduction en relationnel :** Traduction du schéma E/A en modèle relationnel.

### Phase 2 : Implémentation
- **Création de la base de données :** Implémentation du schéma relationnel en SQL sous Oracle.
- **Jeux de données :** Création et chargement massif de données avec SQL*LOAD.
- **Manipulation des données :** Écriture des requêtes SQL basées sur les besoins définis en Phase 1.
- **Vues et Droits :** Création des vues avec agrégats et jointures, et définition des droits d’accès.
- **Intégrité des données :** Création de triggers en PL/SQL pour garantir l’intégrité des données.
- **Méta-données :** Scripts pour extraire et lister les contraintes et triggers.

## Structure des Dossiers
- `Phase1/`: Contient le rapport de la phase d'analyse et modélisation.
- `SQL/`: Scripts SQL pour la création et manipulation de la base de données.
- `Data/`: Fichiers de données pour le chargement massif avec SQL*LOAD.
- `Triggers/`: Scripts PL/SQL pour les triggers.
- `Views/`: Scripts de création des vues et des droits d’accès.

## Instructions
1. Installez la machine virtuelle Oracle si vous ne l'avez pas déjà fait.
2. Exécutez les scripts SQL fournis pour créer le schéma et charger les données.
3. Testez les requêtes SQL, les vues, et les triggers en suivant les fichiers fournis.


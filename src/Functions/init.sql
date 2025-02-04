Select drop_all_tables();

Select drop_all_triggers()

-- Suppression du role client
DROP ROLE client;
-- Suppression du role abonne
DROP ROLE abonne;
-- Suppression du role personnel
DROP ROLE personnel;
-- Suppression du role bibliothecaire
DROP ROLE bibliothecaire;
-- Suppression du role intervenant
DROP ROLE intervenant;
-- Suppression du role directeur
DROP ROLE directeur

Select init_roles();

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM PUBLIC;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;



-- Attribution des privilèges aux rôles

-- Attribution de tous les privilèges au directeur
GRANT ALL ON ALL TABLES IN SCHEMA public TO directeur;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO directeur;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO directeur;

-- Attribution des privlièges aux abonnes
GRANT SELECT ON Abonnes_Exemplaires TO abonne;
GRANT SELECT ON Evenements TO abonne;
GRANT SELECT, UPDATE Reservations abonne;
GRANT INSERT ON Participants TO client;
GRANT SELECT ON Penalites_Abonnes TO abonne;

-- Attribution des privlièges aux bibliothecaires
GRANT SELECT ON Vue_Bibliotheques_Bibliothecaires TO bibliothecaire;
GRANT SELECT ON Vue_Reservations_Bibliothecaires TO bibliothecaire;
GRANT SELECT ON Evenements, Collections TO bibliothecaire;
GRANT SELECT ON Vue_Prets_Bibliothecaires TO bibliothecaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON Transferts, Clients, Abonnes, Ouvrages, Exemplaires, Codes_Postaux TO bibliothecaire;
GRANT SELECT, UPDATE ON Abonnes TO bibliothecaire;
GRANT SELECT ON Penalites, Amendes, Banissements, Banissements_Temporaires TO bibliothecaire;
GRANT UPDATE ON Reservations TO bibliothecaire;

-- Attribution des privlièges aux agents de sécurité
GRANT SELECT, UPDATE ON Penalites, Amendes, Banissements, Banissements_Temporaires TO agent_securite;

-- Attribution des privlièges aux techiniciens informatique
GRANT SELECT, UPDATE ON Bibliotheques, Personnels TO technicien_informatique;

-- Attribution des privlièges aux client;
GRANT SELECT ON Ouvrages, Evenements TO client;
GRANT INSERT ON Participants TO client;

-- Attribution des privilèges aux intervenants
GRANT SELECT ON Evenements TO intervenant;



-- Table des personnes
CREATE TABLE IF NOT EXISTS Personnes (
  id_personne INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom VARCHAR NOT NULL,
  prenom VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE
);

-- Table des clients
CREATE TABLE IF NOT EXISTS Clients (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes
);

-- Table des abonnements
CREATE TABLE IF NOT EXISTS Abonnements (
  id_abonnement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre_livres INTEGER NOT NULL,
  prix INTEGER NOT NULL
);

-- Table des codes postaux
CREATE TABLE IF NOT EXISTS Codes_Postaux (
  code_postal INTEGER PRIMARY KEY,
  ville VARCHAR NOT NULL,
  pays VARCHAR NOT NULL
);

-- Table des abonnés
CREATE TABLE IF NOT EXISTS Abonnes (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes,
  adresse VARCHAR NOT NULL,
  code_postal INTEGER NOT NULL REFERENCES Codes_Postaux,
  rib VARCHAR NOT NULL,
  id_abonnement INTEGER NOT NULL REFERENCES Abonnements
);

-- Table des bibliothèques
CREATE TABLE IF NOT EXISTS Bibliotheques (
  id_bibliotheque INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom_bibliotheque VARCHAR NOT NULL,
  adresse VARCHAR NOT NULL,
  code_postal INTEGER NOT NULL REFERENCES Codes_Postaux
);

-- Table des métiers
CREATE TABLE IF NOT EXISTS Metiers (
  id_metier INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom_metier VARCHAR NOT NULL
);

-- Table du personnel
CREATE TABLE IF NOT EXISTS Personnels (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes,
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques,
  id_metier INTEGER NOT NULL REFERENCES Metiers,
  iban VARCHAR NOT NULL
);

-- Table des intervenants
CREATE TABLE IF NOT EXISTS Intervenants (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes
);

-- Table des événements
CREATE TABLE IF NOT EXISTS Evenements (
  id_evenement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_personne INTEGER NOT NULL REFERENCES Personnes,  -- Organisateur
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques,
  theme VARCHAR NOT NULL,
  nom VARCHAR NOT NULL,
  date_evenement DATE NOT NULL,
  nb_max_personne INTEGER NOT NULL,
  nb_abonne INTEGER NOT NULL
);

-- Table des collections (normalisation de l'attribut id_collection)
CREATE TABLE IF NOT EXISTS Collections (
  id_collection INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom_collection VARCHAR NOT NULL
);

-- Table des ouvrages
CREATE TABLE IF NOT EXISTS Ouvrages (
  id_ouvrage INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  titre VARCHAR NOT NULL,
  auteur VARCHAR NOT NULL,
  annee INTEGER NOT NULL,
  nb_pages INTEGER NOT NULL,
  edition VARCHAR NOT NULL,
  id_collection INTEGER NOT NULL REFERENCES Collections,
  resume TEXT NOT NULL,
  prix INTEGER NOT NULL
);

-- Table des exemplaires
CREATE TABLE IF NOT EXISTS Exemplaires (
  id_exemplaire INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_ouvrage INTEGER NOT NULL REFERENCES Ouvrages,
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques
);

-- Table des participants aux événements
CREATE TABLE IF NOT EXISTS Participants (
  id_participation INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_evenement INTEGER NOT NULL REFERENCES Evenements,
  id_personne INTEGER NOT NULL REFERENCES Personnes
);

-- Table des réservations d'ouvrages
CREATE TABLE IF NOT EXISTS Reservations (
  id_reservation INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires,
  id_abonne INTEGER NOT NULL REFERENCES Abonnes,
  date_reservation DATE NOT NULL,
  date_expiration DATE NOT NULL
);

-- Table des prêts d'ouvrages
CREATE TABLE IF NOT EXISTS Prets (
  id_pret INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires,
  id_abonne INTEGER NOT NULL REFERENCES Abonnes,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  compteur_renouvellement INTEGER NOT NULL,
  retard INTEGER NOT NULL
);

-- Table des interventions des intervenants
CREATE TABLE IF NOT EXISTS Interventions (
  id_intervention INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_personne INTEGER NOT NULL REFERENCES Intervenants
);

-- Table des transferts d'exemplaires entre bibliothèques
CREATE TABLE IF NOT EXISTS Transferts (
  id_transfert INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires,
  id_bibliotheque_depart INTEGER NOT NULL REFERENCES Bibliotheques,
  id_bibliotheque_arrivee INTEGER NOT NULL REFERENCES Bibliotheques,
  date_demande DATE NOT NULL,
  date_arrivee DATE NOT NULL
);

-- Table des achats d'exemplaires
CREATE TABLE IF NOT EXISTS Achats (
  id_achat INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires,
  prix INTEGER NOT NULL,
  date_achat DATE NOT NULL,
  fournisseur VARCHAR NOT NULL
);

-- Table des pénalités
CREATE TABLE IF NOT EXISTS Penalites (
  id_penalite INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nature_infraction VARCHAR NOT NULL,
  id_pret INTEGER NOT NULL REFERENCES Prets,
  id_personne INTEGER NOT NULL REFERENCES Personnes
);

-- Table des amendes
CREATE TABLE IF NOT EXISTS Amendes (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites,
  montant INTEGER NOT NULL
);

-- Table des bannissements temporaires
CREATE TABLE IF NOT EXISTS Banissements_Temporaires (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL
);

-- Table des bannissements permanents
CREATE TABLE IF NOT EXISTS Banissements (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites,
  date_debut DATE NOT NULL
);




-- Insertion des métiers
INSERT INTO Metiers (nom_metier) VALUES
('Directeur'),
('Bibliothécaire'),
('Agent de sécurité'),
('Technicien informatique');

-- Insertion des personnes
INSERT INTO Personnes (nom, prenom, email) 
VALUES 
('Dupont', 'Jean', 'jean.dupont@example.com'),
('Martin', 'Claire', 'claire.martin@example.com'),
('Durand', 'Paul', 'paul.durand@example.com'),
('Morel', 'Sophie', 'sophie.morel@example.com'),
('Roux', 'Luc', 'luc.roux@example.com'),
('Petit', 'Emma', 'emma.petit@example.com'),
('Noir', 'Mathieu', 'mathieu.noir@example.com'),
('Blanc', 'Laura', 'laura.blanc@example.com'),
('Girard', 'Nicolas', 'nicolas.girard@example.com'),
('Bernard', 'Marion', 'marion.bernard@example.com'),
('Perret', 'Julien', 'julien.perret@example.com'),
('Barbier', 'Elodie', 'elodie.barbier@example.com'),
('Garnier', 'Thomas', 'thomas.garnier@example.com'),
('Leclerc', 'Manon', 'manon.leclerc@example.com'),
('Dupuis', 'Lucas', 'lucas.dupuis@example.com'),
('Marchand', 'Camille', 'camille.marchand@example.com'),
('Simon', 'Hugo', 'hugo.simon@example.com'),
('Caron', 'Alice', 'alice.caron@example.com'),
('Lemoine', 'Pierre', 'pierre.lemoine@example.com'),
('Fournier', 'Chloe', 'chloe.fournier@example.com');

-- Insertion des clients
INSERT INTO Clients (id_personne)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insertion des abonnements
INSERT INTO Abonnements (nombre_livres, prix)
VALUES
(1, 24),
(3, 48),
(72, 6);

-- Insertion des abonnés
INSERT INTO Abonnes (id_personne, adresse, ville, code_postal, pays, rib, id_abonnement)
VALUES
(11, '12 Rue des Lilas', 'Paris', 75012, 'France', 'FR7630003000701234567890125', 1),
(12, '45 Avenue des Champs', 'Lyon', 69002, 'France', 'FR7630003000709876543210987', 2),
(13, '3 Impasse des Jardins', 'Marseille', 13008, 'France', 'FR7630003000705678901234567', 1),
(14, '9 Boulevard Saint-Michel', 'Toulouse', 31000, 'France', 'FR7630003000702345678912345', 3),
(15, '14 Rue de la République', 'Bordeaux', 33000, 'France', 'FR7630003000700987654321234', 2),
(16, '22 Place Bellecour', 'Lille', 59000, 'France', 'FR7630003000701122334455667', 3);

-- Insertion des bibliothèques
INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays)
VALUES
('Bibliothèque Centrale', '1 Place de l Université', 'Paris', 'France'),
('Médiathèque de Lyon', '5 Rue des Archives', 'Lyon', 'France'),
('Bibliothèque Municipale', '10 Boulevard de la République', 'Marseille', 'France');

-- Insertion des personnels avec id_metier
INSERT INTO Personnels (id_personne, id_biliotheque, id_metier, iban)
VALUES
(17, 1, 1, 'FR7612345678901234567890123'), -- Directeur
(18, 1, 2, 'FR7623456789012345678901234'), -- Bibliothécaire
(19, 1, 2, 'FR7634567890123456789012345'), -- Bibliothécaire
(20, 1, 3, 'FR7701234567890123456789012'), -- Agent de sécurité
(21, 1, 4, 'FR7712345678901234567890123'), -- Technicien informatique
(22, 2, 1, 'FR7645678901234567890123456'), -- Directeur
(23, 2, 2, 'FR7656789012345678901234567'), -- Bibliothécaire
(24, 2, 2, 'FR7667890123456789012345678'), -- Bibliothécaire
(25, 2, 3, 'FR7723456789012345678901234'), -- Agent de sécurité
(26, 2, 4, 'FR7734567890123456789012345'), -- Technicien informatique
(27, 3, 1, 'FR7678901234567890123456789'), -- Directeur
(28, 3, 2, 'FR7689012345678901234567890'), -- Bibliothécaire
(29, 3, 2, 'FR7690123456789012345678901'), -- Bibliothécaire
(30, 3, 3, 'FR7745678901234567890123456'), -- Agent de sécurité
(31, 3, 4, 'FR7756789012345678901234567'); -- Technicien informatique

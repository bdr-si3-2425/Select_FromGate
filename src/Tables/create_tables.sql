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
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  retard INTEGER NOT NULL
);

-- Table des renouvellements
CREATE TABLE IF NOT EXISTS Prets_Renouvellements(
  id_renouvellement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_pret INTEGER NOT NULL REFERENCES Prets,
  date_renouvellement DATE NOT NULL,
  date_fin DATE NOT NULL
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
  id_personne INTEGER NOT NULL REFERENCES Personnes,
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

-- Table des réglements d'amendes
CREATE TABLE IF NOT EXISTS Amendes_Reglements(
  id_amende_reglement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_penalite INTEGER NOT NULL REFERENCES Penalites,
  date_reglement DATE NOT NULL
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

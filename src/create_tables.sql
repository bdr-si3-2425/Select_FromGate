CREATE TABLE IF NOT EXISTS Personnes (
  id_personne SERIAL PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Clients (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes(id_personne)
);

CREATE TABLE IF NOT EXISTS Abonnements (
  id_abonnement SERIAL PRIMARY KEY,
  nombre_livres INTEGER NOT NULL,
  prix INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Abonnes (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes(id_personne),
  adresse VARCHAR(255) NOT NULL,
  ville VARCHAR(255) NOT NULL,
  code_postal VARCHAR(10) NOT NULL,
  pays VARCHAR(255) NOT NULL,
  rib VARCHAR(34) NOT NULL,
  id_abonnement INTEGER NOT NULL REFERENCES Abonnements(id_abonnement)
);

CREATE TABLE IF NOT EXISTS Bibliotheques (
  id_bibliotheque SERIAL PRIMARY KEY,
  nom_bibliotheque VARCHAR(255) NOT NULL,
  adresse VARCHAR(255) NOT NULL,
  ville VARCHAR(255) NOT NULL,
  pays VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Personnels (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes(id_personne),
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques(id_bibliotheque),
  poste VARCHAR(255) NOT NULL,
  iban VARCHAR(34) NOT NULL
);

CREATE TABLE IF NOT EXISTS Intervenants (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes(id_personne)
);

CREATE TABLE IF NOT EXISTS Evenements (
  id_evenement SERIAL PRIMARY KEY,
  id_personne INTEGER NOT NULL REFERENCES Personnes(id_personne),
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques(id_bibliotheque),
  theme VARCHAR(255) NOT NULL,
  nom VARCHAR(255) NOT NULL,
  date_evenement DATE NOT NULL,
  nb_max_personne INTEGER NOT NULL CHECK (nb_max_personne > 0),
  nb_abonne INTEGER NOT NULL CHECK (nb_abonne >= 0)
);

CREATE TABLE IF NOT EXISTS Ouvrages (
  id_ouvrage SERIAL PRIMARY KEY,
  titre VARCHAR(255) NOT NULL,
  auteur VARCHAR(255) NOT NULL,
  annee INTEGER NOT NULL CHECK (annee > 0),
  nb_pages INTEGER NOT NULL CHECK (nb_pages > 0),
  edition VARCHAR(255) NOT NULL,
  id_collection INTEGER NOT NULL,
  resume TEXT NOT NULL,
  prix INTEGER NOT NULL CHECK (prix >= 0)
);

CREATE TABLE IF NOT EXISTS Exemplaires (
  id_exemplaire SERIAL PRIMARY KEY,
  id_ouvrage INTEGER NOT NULL REFERENCES Ouvrages(id_ouvrage),
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques(id_bibliotheque)
);

CREATE TABLE IF NOT EXISTS Participants (
  id_participation SERIAL PRIMARY KEY,
  id_evenement INTEGER NOT NULL REFERENCES Evenements(id_evenement),
  id_personne INTEGER NOT NULL REFERENCES Personnes(id_personne)
);

CREATE TABLE IF NOT EXISTS Reservations (
  id_reservation SERIAL PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires(id_exemplaire),
  id_abonne INTEGER NOT NULL REFERENCES Abonnes(id_personne),
  date_reservation DATE NOT NULL,
  date_expiration DATE NOT NULL CHECK (date_expiration > date_reservation)
);

CREATE TABLE IF NOT EXISTS Prets (
  id_pret SERIAL PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires(id_exemplaire),
  id_abonne INTEGER NOT NULL REFERENCES Abonnes(id_personne),
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL CHECK (date_fin > date_debut),
  compteur_renouvellement INTEGER NOT NULL DEFAULT 0 CHECK (compteur_renouvellement >= 0),
  retard INTEGER NOT NULL DEFAULT 0 CHECK (retard >= 0)
);

CREATE TABLE IF NOT EXISTS Interventions (
  id_intervention SERIAL PRIMARY KEY,
  id_personne INTEGER NOT NULL REFERENCES Intervenants(id_personne)
);

CREATE TABLE IF NOT EXISTS Transferts (
  id_transfert SERIAL PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires(id_exemplaire),
  id_bibliotheque_depart INTEGER NOT NULL REFERENCES Bibliotheques(id_bibliotheque),
  id_bibliotheque_arrivee INTEGER NOT NULL REFERENCES Bibliotheques(id_bibliotheque),
  date_demande DATE NOT NULL,
  date_arrivee DATE NOT NULL CHECK (date_arrivee >= date_demande)
);

CREATE TABLE IF NOT EXISTS Achats (
  id_achat SERIAL PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires(id_exemplaire),
  prix INTEGER NOT NULL CHECK (prix >= 0),
  date_achat DATE NOT NULL,
  fournisseur VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Penalites (
  id_penalite SERIAL PRIMARY KEY,
  nature_infraction VARCHAR(255) NOT NULL,
  id_pret INTEGER NOT NULL REFERENCES Prets(id_pret),
  id_personne INTEGER NOT NULL REFERENCES Personnes(id_personne)
);

CREATE TABLE IF NOT EXISTS Amendes (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites(id_penalite),
  montant INTEGER NOT NULL CHECK (montant >= 0)
);

CREATE TABLE IF NOT EXISTS Banissements_Temporaires (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites(id_penalite),
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL CHECK (date_fin > date_debut)
);

CREATE TABLE IF NOT EXISTS Banissements (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites(id_penalite),
  date_debut DATE NOT NULL
);

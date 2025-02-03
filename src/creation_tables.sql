-- Creation de la table Personnes
CREATE TABLE IF NOT EXISTS Personnes (
  id_personne integer generated always as identity primary key,
  nom varchar not null,
  prenom varchar not null,
  email varchar not null
);

-- Creation de la table Clients
CREATE TABLE IF NOT EXISTS Clients (
  id_personne integer primary key REFERENCES Personnes
);

-- Creation de la table Abonnements
CREATE TABLE IF NOT EXISTS Abonnements(
  id_abonnement integer generated always as identity primary key,
  nombre_livres integer not null,
  prix integer not null
);

-- Creation de la table Abonnes
CREATE TABLE IF NOT EXISTS Abonnes (
  id_personne integer primary key REFERENCES Personnes,
  adresse varchar not null,
  ville varchar not null,
  code_postal integer not null,
  pays varchar not null,
  rib varchar not null,
  id_abonnement integer not null REFERENCES Abonnements
);

-- Creation de la table Bibliotheques
CREATE TABLE IF NOT EXISTS Bibliotheques (
  id_bibliotheque integer generated always as identity primary key,
  nom_bibliotheque varchar not null,
  adresse varchar not null,
  ville varchar not null,
  pays varchar not null
);

-- Creation de la table Personnels
CREATE TABLE IF NOT EXISTS Personnels (
  id_personne integer primary key REFERENCES Personnes,
  id_biliotheque integer not null REFERENCES Bibliotheques,
  poste varchar not null,
  iban varchar not null
);

-- Creation de la table Intervenants
CREATE TABLE IF NOT EXISTS Intervernants (
  id_personne integer primary key REFERENCES Personnes
);

-- Creation de la table Evenements
CREATE TABLE IF NOT EXISTS Evenements (
  id_evenement integer generated always as identity primary key,
  id_personne integer not null REFERENCES Personnes,
  id_bibliotheque integer not null REFERENCES Bibliotheques,
  theme varchar not null,
  nom varchar not null,
  date_evenement date not null,
  nb_max_personne integer not null,
  nb_abonne integer not null
);

-- Creation de la table Ouvrages
CREATE TABLE IF NOT EXISTS Ouvrages (
  id_ouvrage integer generated always as identity primary key,
  titre varchar not null,
  autheur varchar not null,
  annee integer not null,
  nb_pages integer not null,
  edition varchar not null,
  id_collection integer not null,
  resume varchar not null,
  prix integer not null
);

-- Creation de la table Exemplaires
CREATE TABLE IF NOT EXISTS Exemplaires(
  id_exemplaire integer generated always as identity primary key,
  id_ouvrage integer not null REFERENCES Ouvrages,
  id_bibliotheque integer not null REFERENCES Bibliotheques
);

-- Creation de la table Participants
CREATE TABLE IF NOT EXISTS Participants(
  id_participation integer generated always as identity primary key,
  id_evenement integer not null REFERENCES Evenements,
  id_personne integer not null REFERENCES Personnes
);

-- Creation de la table Reservations
CREATE TABLE IF NOT EXISTS Reservations(
  id_reservation integer generated always as identity primary key,
  id_exemplaire integer not null REFERENCES Exemplaires,
  id_abonne integer not null REFERENCES Abonnes,
  date_reservation date not null,
  date_expiration date not null
);

-- Creation de la table Prets
CREATE TABLE IF NOT EXISTS Prets(
  id_pret integer generated always as identity primary key,
  id_exemplaire integer not null REFERENCES Exemplaires,
  id_abonne integer not null REFERENCES Abonnes,
  date_debut date not null,
  date_fin date not null,
  compteur_renouvellement integer not null,
  retard integer not null
);

-- Creation de la table Interventions
CREATE TABLE IF NOT EXISTS Interventions(
  id_intervention integer generated always as identity primary key,
  id_personne integer not null REFERENCES Intervernants
);

-- Creation de la table Transferts
CREATE TABLE IF NOT EXISTS Transferts(
  id_transfert integer generated always as identity primary key,
  id_exemplaire integer not null REFERENCES Exemplaires,
  id_bibliotheque_depart integer not null REFERENCES Bibliotheques,
  id_bibliotheque_arrivee integer not null REFERENCES Bibliotheques,
  date_demande date not null,
  date_arrivee date not null
);

-- Creation de la table Achats
CREATE TABLE IF NOT EXISTS Achats(
  id_achat integer generated always as identity primary key,
  id_exemplaire integer not null REFERENCES Exemplaires,
  prix integer not null,
  date_achat date not null,
  fournisseur varchar not null
);

-- Creation de la table Penalites
CREATE TABLE IF NOT EXISTS Penalites(
  id_penalite integer generated always as identity primary key,
  nature_infraction varchar not null,
  id_pret integer not null,
  id_personne integer not null REFERENCES Personnes
);

-- Creation de la table Amendes
CREATE TABLE IF NOT EXISTS Amendes(
  id_penalite integer primary key REFERENCES Penalites,
  montant integer not null
);

-- Creation de la table Banissements_temporaires
CREATE TABLE IF NOT EXISTS Banissements_Temporaires(
  id_penalite integer primary key REFERENCES Penalites,
  date_debut date not null,
  date_fin date not null
);

-- Creation de la table Banissements
CREATE TABLE IF NOT EXISTS Banissements(
  id_penalite integer primary key REFERENCES Penalites,
  date_debut date not null
);


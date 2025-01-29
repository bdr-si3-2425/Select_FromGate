CREATE TABLE IF NOT EXISTS Personnes (
  id_personne integer primary key,
  nom varchar,
  prenom varchar,
  email varchar
);

CREATE TABLE IF NOT EXISTS Client (
  id_personne integer primary key REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Abonnements(
  id_abonnement integer primary key,
  prix integer
);

CREATE TABLE IF NOT EXISTS Abonnes (
  id_personne integer primary key REFERENCES Personnes,
  adresse varchar,
  ville varchar,
  code_postal integer,
  pays integer,
  rib varchar,
  id_abonnement integer REFERENCES Abonnements
);

CREATE TABLE IF NOT EXISTS Bibliotheques (
  id_bibliotheque integer primary key,
  nom_bibliotheque varchar,
  adresse varchar,
  ville varchar,
  pays varchar
);

CREATE TABLE IF NOT EXISTS Personnels (
  id_personne integer primary key REFERENCES Personnes,
  id_biliotheque integer REFERENCES Bibliotheques,
  poste varchar,
  iban varchar
);

CREATE TABLE IF NOT EXISTS Intervernants (
  id_personne integer primary key REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Evenements (
  id_evenement integer primary key,
  id_personne integer REFERENCES Personnes,
  id_bibliotheque integer REFERENCES Bibliotheques,
  theme varchar,
  nom varchar,
  date_evenement date,
  nb_max_personne integer,
  nb_abonne integer
);

CREATE TABLE IF NOT EXISTS Ouvrages (
  id_ouvrage integer primary key,
  titre varchar,
  autheur varchar,
  annee integer,
  nb_pages integer,
  edition varchar,
  id_collection integer,
  resume varchar,
  prix integer
);

CREATE TABLE IF NOT EXISTS Exemplaires(
  id_exemplaire integer primary key,
  id_ouvrage integer REFERENCES Ouvrages,
  id_bibliotheque integer REFERENCES Bibliotheques
);

CREATE TABLE IF NOT EXISTS Participants(
  id_participation integer primary key,
  id_evenement integer REFERENCES Evenements,
  id_personne integer REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Reservations(
  id_reservation integer primary key,
  id_exemplaire integer REFERENCES Exemplaires,
  id_abonne integer REFERENCES Abonnes,
  date_reservation date,
  date_expiration date
);

CREATE TABLE IF NOT EXISTS Prets(
  id_pret integer primary key,
  id_exemplaire integer REFERENCES Exemplaires,
  id_abonne integer REFERENCES Abonnes,
  date_debut date,
  date_fin date,
  compteur_renouvellement integer,
  retard integer
);

CREATE TABLE IF NOT EXISTS Interventions(
  id_intervention integer primary key,
  id_personne integer REFERENCES Intervernants
);

CREATE TABLE IF NOT EXISTS Transferts(
  id_transfert integer primary key,
  id_exemplaire integer REFERENCES Exemplaires,
  id_bibliotheque_depart integer REFERENCES Bibliotheques,
  id_bibliotheque_arrivee integer REFERENCES Bibliotheques,
  date_demande date,
  date_arrivee date
);

CREATE TABLE IF NOT EXISTS Achats(
  id_achat integer primary key,
  id_exemplaire integer REFERENCES Exemplaires,
  prix integer,
  date_achat date,
  fournisseur varchar
);

CREATE TABLE IF NOT EXISTS Penalites(
  id_penalite integer primary key,
  nature_infraction varchar,
  id_pret integer,
  id_personne integer REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Amendes(
  id_penalite integer primary key REFERENCES Penalites,
  montant integer
);

CREATE TABLE IF NOT EXISTS Banissements_Temporaires(
  id_penalite integer primary key REFERENCES Penalites,
  date_debut date,
  date_fin date
);

CREATE TABLE IF NOT EXISTS Banissements(
  id_penalite integer primary key REFERENCES Penalites,
  date_debut date
);


CREATE Table Personne (
  id_personne integer primary key,
  nom varchar,
  prenom varchar,
  email varchar
);

CREATE Table Client (
  id_personne integer primary key REFERENCES Personne
);

CREATE Table Abonne (
  id_personne integer primary key REFERENCES Personne,
  adresse varchar,
  ville varchar,
  code_postal integer,
  pays integer,
  rib varchar,
  id_abonnement integer
);

CREATE Table Personnel (
  id_personne integer primary key REFERENCES Personne,
  id_biliotheque integer,
  poste varchar
);

CREATE Table Intervenant (
  id_personne integer primary key REFERENCES Personne
);

CREATE Table Evenement (
  id_evenement integer primary key,
  id_personne integer,
  id_bibliotheque integer,
  theme varchar,
  nom varchar,
  date_evenement date,
  nb_max_personne integer,
  nb_abonne integer
);

CREATE Table Bibliotheque (
  id_bibliotheque integer primary key,
  nom_bibliotheque varchar,
  adresse varchar,
  ville varchar,
  pays varchar
);

CREATE Table Ouvrages (
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

CREATE Table Exemplaire(
  id_exemplaire integer primary key,
  id_ouvrage integer,
  id_bibliotheque integer
);

CREATE Table Employes(
  id_personne integer primary key,
  id_bibliotheque integer,
  poste varchar,
  iban varchar
);

CREATE Table Participants(
  id_participation integer primary key,
  id_evenement integer,
  id_personne integer
);

CREATE Table Reservation(
  id_reservation integer primary key,
  id_exemplaire integer,
  id_abonne integer,
  date_reservation date,
  date_expiration date
);

CREATE Table Pret(
  id_pret integer primary key,
  id_exemplaire integer,
  id_abonne integer,
  date_debut date,
  date_fin date,
  compteur_renouvellement integer,
  retard integer
);

CREATE Table Interventions(
  id_intervention integer primary key,
  id_personne integer
);

CREATE Table Transfert(
  id_transfert integer primary key,
  id_exemplaire integer,
  id_bibliotheque_depart integer,
  id_bibliotheque_arrivee integer,
  date_demande date,
  date_arrivee date
);

CREATE Table Achat(
  id_achat integer primary key,
  id_exemplaire integer,
  prix integer,
  date_achat date,
  fournisseur varchar
);

CREATE Table Penalite(
  id_penalite integer primary key,
  nature_infraction varchar,
  id_pret integer,
  id_personne integer REFERENCES Personne
);

CREATE Table Amendes(
  id_penalite integer primary key,
  montant integer
);

CREATE Table Banissement_Temporaire(
  id_penalite integer primary key,
  date_debut date,
  date_fin date
);

CREATE Table Banissement(
  id_penalite integer primary key,
  date_debut date
);

CREATE Table Abonnement(
  id_abonnement integer primary key,
  prix integer
);

/*
Ref: Personne.id_personne > Client.id_personne,
Ref: Personne.id_personne > Abonne.id_personne,
Ref: Personne.id_personne > Personnel.id_personne,
Ref: Personne.id_personne > Intervenant.id_personne,
Ref: Personne.id_personne > Evenement.id_personne,
Ref: Personne.id_personne > Participants.id_personne,
Ref: Personne.id_personne > Penalite.id_personne,

Ref: Bibliotheque.id_bibliotheque > Evenement.id_bibliotheque,
Ref: Bibliotheque.id_bibliotheque > Exemplaire.id_bibliotheque,
Ref: Bibliotheque.id_bibliotheque > Employes.id_bibliotheque,
Ref: Bibliotheque.id_bibliotheque > Transfert.id_bibliotheque_depart,
Ref: Bibliotheque.id_bibliotheque > Transfert.id_bibliotheque_arrivee,

Ref: Ouvrages.id_ouvrage > Exemplaire.id_ouvrage,

Ref: Exemplaire.id_exemplaire > Transfert.id_exemplaire,
Ref: Exemplaire.id_exemplaire > Achat.id_exemplaire,
Ref: Exemplaire.id_exemplaire > Pret.id_exemplaire,
Ref: Exemplaire.id_exemplaire > Reservation.id_exemplaire,

Ref: Evenement.id_evenement > Participants.id_evenement,

Ref: Intervenant.id_personne > Interventions.id_personne,

Ref: Personnel.id_personne > Employes.id_personne,

Ref: Abonne.id_personne > Pret.id_abonne,
Ref: Abonne.id_personne > Reservation.id_abonne,

Ref: Penalite.id_penalite > Amendes.id_penalite,
Ref: Penalite.id_penalite > Banissement_Temporaire.id_penalite,
Ref: Penalite.id_penalite > Banissement.id_penalite,

Ref: Abonnement.id_abonnement > Abonne.id_abonnement,
*/
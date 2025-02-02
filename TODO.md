Executer les tests une foids que l'on aura trouvé la cause du bug

Pour tester :
```sql
--------------------------------------------------------------------------------
-- Création des tables :
--------------------------------------------------------------------------------

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
  depassement INTEGER NOT NULL DEFAULT 0 CHECK (depassement >= 0)
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


--------------------------------------------------------------------------------
-- Insertions initiales :
--------------------------------------------------------------------------------

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
('Fournier', 'Chloe', 'chloe.fournier@example.com'),
('Dupond', 'Lucas', 'lucas.dupond@example.com'),
('Lemoine', 'Pierre', 'pierre.lemoine@example.com'),
('Fournier', 'Chloe', 'chloe.fournier@example.com'),
('Petit', 'Maxime', 'maxime.petit@example.com'),
('Martin', 'Sophie', 'sophie.martin@example.com'),
('Leclerc', 'Alice', 'alice.leclerc@example.com'),
('Roux', 'Julien', 'julien.roux@example.com'),
('Lemoine', 'Claire', 'claire.lemoine@example.com'),
('Morel', 'Antoine', 'antoine.morel@example.com'),
('Garnier', 'Camille', 'camille.garnier@example.com'),
('Bernard', 'Hugo', 'hugo.bernard@example.com'),
('Girard', 'Mélanie', 'melanie.girard@example.com'),
('Perret', 'Nicolas', 'nicolas.perret@example.com'),
('Caron', 'Elise', 'elise.caron@example.com'),
('Blanc', 'Thomas', 'thomas.blanc@example.com'),
('Dupont', 'Pierre', 'pierre.dupont@example.com'),
('Lemoine', 'Mathieu', 'mathieu.lemoine@example.com'),
('Roux', 'Sophie', 'sophie.roux@example.com'),
('Martin', 'Julien', 'julien.martin@example.com'),
('Leclerc', 'Antoine', 'antoine.leclerc@example.com'),
('Morel', 'Chloe', 'chloe.morel@example.com'),
('Garnier', 'Julien', 'julien.garnier@example.com'),
('Bernard', 'Sophie', 'sophie.bernard@example.com'),
('Girard', 'Maxime', 'maxime.girard@example.com'),
('Perret', 'Mélanie', 'melanie.perret@example.com'),
('Caron', 'Antoine', 'antoine.caron@example.com'),
('Blanc', 'Nicolas', 'nicolas.blanc@example.com'),
('Dupont', 'Julien', 'julien.dupont@example.com'),
('Lemoine', 'Clara', 'clara.lemoine@example.com');

INSERT INTO Clients (id_personne)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO Abonnements (nombre_livres, prix)
VALUES
(1, 24),
(3, 48),
(72, 6);

INSERT INTO Abonnes (id_personne, adresse, ville, code_postal, pays, rib, id_abonnement)
VALUES
(11, '12 Rue des Lilas', 'Paris', '75012', 'France', 'FR7630003000701234567890125', 1),
(12, '45 Avenue des Champs', 'Lyon', '69002', 'France', 'FR7630003000709876543210987', 2),
(13, '3 Impasse des Jardins', 'Marseille', '13008', 'France', 'FR7630003000705678901234567', 1),
(14, '9 Boulevard Saint-Michel', 'Toulouse', '31000', 'France', 'FR7630003000702345678912345', 3),
(15, '14 Rue de la République', 'Bordeaux', '33000', 'France', 'FR7630003000700987654321234', 2),
(16, '22 Place Bellecour', 'Lille', '59000', 'France', 'FR7630003000701122334455667', 3),
(17, '5 Rue Nationale', 'Nantes', '44000', 'France', 'FR7630003000702233445566778', 1),
(18, '18 Rue des Fleurs', 'Strasbourg', '67000', 'France', 'FR7630003000703344556677889', 2),
(19, '7 Avenue de la Paix', 'Rennes', '35000', 'France', 'FR7630003000704455667788990', 1),
(20, '11 Rue Victor Hugo', 'Nice', '06000', 'France', 'FR7630003000705566778899001', 3),
(21, '12 Rue des Lilas', 'Paris', '75012', 'France', 'FR7630003000701234567890125', 1),
(22, '45 Avenue des Champs', 'Lyon', '69002', 'France', 'FR7630003000709876543210987', 2),
(23, '3 Impasse des Jardins', 'Marseille', '13008', 'France', 'FR7630003000705678901234567', 1),
(24, '9 Boulevard Saint-Michel', 'Toulouse', '31000', 'France', 'FR7630003000702345678912345', 3),
(25, '14 Rue de la République', 'Bordeaux', '33000', 'France', 'FR7630003000700987654321234', 2),
(26, '22 Place Bellecour', 'Lille', '59000', 'France', 'FR7630003000701122334455667', 3),
(27, '5 Rue Nationale', 'Nantes', '44000', 'France', 'FR7630003000702233445566778', 1),
(28, '18 Rue des Fleurs', 'Strasbourg', '67000', 'France', 'FR7630003000703344556677889', 2),
(29, '7 Avenue de la Paix', 'Rennes', '35000', 'France', 'FR7630003000704455667788990', 1),
(30, '11 Rue Victor Hugo', 'Nice', '06000', 'France', 'FR7630003000705566778899001', 3);

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays)
VALUES
('Bibliothèque Centrale', '1 Place de l Université', 'Paris', 'France'),
('Médiathèque de Lyon', '5 Rue des Archives', 'Lyon', 'France'),
('Bibliothèque Municipale', '10 Boulevard de la République', 'Marseille', 'France');

INSERT INTO Personnels (id_personne, id_bibliotheque, poste, iban)
VALUES
(31, 1, 'Directeur', 'FR7612345678901234567890123'),
(32, 1, 'Bibliothécaire', 'FR7623456789012345678901234'),
(33, 1, 'Bibliothécaire', 'FR7634567890123456789012345'),
(40, 1, 'Agent de sécurité', 'FR7701234567890123456789012'),
(41, 1, 'Technicien informatique', 'FR7712345678901234567890123'),
(34, 2, 'Directeur', 'FR7645678901234567890123456'),
(35, 2, 'Bibliothécaire', 'FR7656789012345678901234567'),
(36, 2, 'Bibliothécaire', 'FR7667890123456789012345678'),
(42, 2, 'Agent de sécurité', 'FR7723456789012345678901234'),
(43, 2, 'Technicien informatique', 'FR7734567890123456789012345'),
(37, 3, 'Directeur', 'FR7678901234567890123456789'),
(38, 3, 'Bibliothécaire', 'FR7689012345678901234567890'),
(39, 3, 'Bibliothécaire', 'FR7690123456789012345678901'),
(44, 3, 'Agent de sécurité', 'FR7745678901234567890123456'),
(45, 3, 'Technicien informatique', 'FR7756789012345678901234567');



--------------------------------------------------------------------------------
-- Fonctions auxiliaires pour les triggers :
--------------------------------------------------------------------------------

-- Cette fonction vérifie que la personne effectuant la réservation possède le droit de réserver.
-- Elle prend en paramètre un enregistrement de la table Reservations.
CREATE OR REPLACE FUNCTION _verif_personne_reservation_ability_fn(_new Reservations)
RETURNS void AS $$
BEGIN
    -- Vérifie que la personne soit bien abonnée :
    IF NOT EXISTS (
        SELECT 1
        FROM Abonnes ab
        WHERE ab.id_personne = _new.id_abonne
    ) THEN
        RAISE EXCEPTION 'Seul un abonné peut réaliser une reservation';
    END IF;

    -- Vérifie que l'abonné n'ait pas été banni définitivement :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Banissements b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = _new.id_abonne
    ) THEN
        RAISE EXCEPTION 'L''abonné est banni définitevement';
    END IF;

    -- Vérifie que l'abonné n'ait pas été banni temporairement :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Banissements_Temporaires bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = _new.id_abonne
          AND bt.date_debut <= CURRENT_DATE
          AND CURRENT_DATE <= bt.date_fin
    ) THEN
        RAISE EXCEPTION 'L''abonné est banni temporairement';
    END IF;

    -- Vérifie que l'abonné n'ait pas d'amendes impayées :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Amendes am ON am.id_penalite = p.id_penalite
        WHERE p.id_personne = _new.id_abonne
          AND am.id_penalite NOT IN (SELECT id_penalite FROM Amendes_Reglements)
    ) THEN
        RAISE EXCEPTION 'L''abonné a des amendes impayées';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Cette fonction vérifie la validité d'une réservation.
CREATE OR REPLACE FUNCTION _verif_reservation_validity_fn(_new Reservations)
RETURNS void AS $$
BEGIN
    -- Vérifier si la réservation n'est pas faite trop tôt (plus d'1 mois et demi à l'avance)
    IF (_new.date_reservation > (CURRENT_DATE + INTERVAL '1 month 15 days')) THEN
        RAISE EXCEPTION 'Un exemplaire ne peut être réservé plus d''un mois et demi à l''avance';
    END IF;

    -- Vérifier si l'exemplaire n'a pas déjà été réservé
    IF EXISTS (
        SELECT 1
        FROM Reservations r
        WHERE r.id_exemplaire = _new.id_exemplaire
    ) THEN
        RAISE EXCEPTION 'L''exemplaire a déjà été réservé';
    END IF;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Fonction trigger principale :
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verif_reservation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Si la date de réservation n'est pas précisée, on la met à la date du jour.
    IF NEW.date_reservation IS NULL THEN
        NEW.date_reservation := CURRENT_DATE;
    ELSIF NEW.date_reservation < CURRENT_DATE THEN
        RAISE EXCEPTION 'Date de reservation erronée';
    END IF;

    -- Si la date d'expiration n'est pas renseignée, on la fixe à 2 semaines après la date de réservation.
    IF NEW.date_expiration IS NULL THEN
        NEW.date_expiration := NEW.date_reservation + INTERVAL '2 weeks';
    END IF;

    -- Appel des fonctions de vérification.
    PERFORM _verif_personne_reservation_ability_fn(NEW);
    PERFORM _verif_reservation_validity_fn(NEW);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Création des triggers :
--------------------------------------------------------------------------------

CREATE TRIGGER verif_reservation_insert
    BEFORE INSERT ON Reservations
    FOR EACH ROW
    EXECUTE FUNCTION verif_reservation_insert_fn();



--------------------------------------------------------------------------------
-- Tests :
--------------------------------------------------------------------------------

-- Test 1 : Reservation de la part d'une personne non-abbonnée
/*
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (3, 1);
*/


-- Test 2 : Reservation d'un exemplaire déjà reservé
/*
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 11, CURRENT_DATE, CURRENT_DATE + INTERVAL '7 days');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');
*/


-- Test 3 : Abonné temporairement banni
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Retard', 1, 12);
INSERT INTO Banissements_Temporaires (id_penalite, date_debut, date_fin) VALUES (1, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day');
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (6, 12);
*/


-- Test 4 : Abonné définitivement banni)
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Fraude', 1, 13);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (1, 13);
*/


-- Test 5: Abonné n'ayant pas encore rêglé son amende
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Amende', 1, 13);
INSERT INTO Amendes (id_penalite, montant) VALUES (1, 25);
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (1, 13);
*/


-- Test 6 : Insertion d'un prêt avec une date de début incorrecte
/*
INSERT INTO Prets (id_exemplaire, id_abonne, date_fin)
VALUES (2, 12, CURRENT_DATE - INTERVAL '10 days');
*/
```
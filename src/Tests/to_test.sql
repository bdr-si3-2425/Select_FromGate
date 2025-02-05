Select drop_all_tables();

Select drop_all_roles();

Select drop_all_views();

Select drop_all_triggers();

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Tables :
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



-- Table des personnes
CREATE TABLE IF NOT EXISTS Personnes (
  id_personne INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom VARCHAR NOT NULL,
  prenom VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE
);

-- Table des clients
CREATE TABLE IF NOT EXISTS Clients (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes ON DELETE CASCADE
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
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes ON DELETE CASCADE,
  adresse VARCHAR NOT NULL,
  code_postal INTEGER NOT NULL REFERENCES Codes_Postaux ON DELETE CASCADE,
  rib VARCHAR NOT NULL,
  id_abonnement INTEGER NOT NULL REFERENCES Abonnements ON DELETE CASCADE
);

-- Table des bibliothèques
CREATE TABLE IF NOT EXISTS Bibliotheques (
  id_bibliotheque INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom_bibliotheque VARCHAR NOT NULL,
  adresse VARCHAR NOT NULL,
  code_postal INTEGER NOT NULL REFERENCES Codes_Postaux ON DELETE CASCADE
);

-- Table des métiers
CREATE TABLE IF NOT EXISTS Metiers (
  id_metier INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nom_metier VARCHAR NOT NULL
);

-- Table du personnel
CREATE TABLE IF NOT EXISTS Personnels (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes ON DELETE CASCADE,
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques ON DELETE CASCADE,
  id_metier INTEGER NOT NULL REFERENCES Metiers ON DELETE CASCADE,
  iban VARCHAR NOT NULL
);

-- Table des intervenants
CREATE TABLE IF NOT EXISTS Intervenants (
  id_personne INTEGER PRIMARY KEY REFERENCES Personnes ON DELETE CASCADE
);

-- Table des événements
CREATE TABLE IF NOT EXISTS Evenements (
  id_evenement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_personne INTEGER NOT NULL REFERENCES Personnes ON DELETE CASCADE,  -- Organisateur
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques ON DELETE CASCADE,
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
  id_collection INTEGER NOT NULL REFERENCES Collections ON DELETE CASCADE,
  resume TEXT NOT NULL,
  prix INTEGER NOT NULL
);

-- Table des exemplaires
CREATE TABLE IF NOT EXISTS Exemplaires (
  id_exemplaire INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_ouvrage INTEGER NOT NULL REFERENCES Ouvrages ON DELETE CASCADE,
  id_bibliotheque INTEGER NOT NULL REFERENCES Bibliotheques ON DELETE CASCADE
);

-- Table des participants aux événements
CREATE TABLE IF NOT EXISTS Participants (
  id_participation INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_evenement INTEGER NOT NULL REFERENCES Evenements ON DELETE CASCADE,
  id_personne INTEGER NOT NULL REFERENCES Personnes ON DELETE CASCADE
);

-- Table des réservations d'ouvrages
CREATE TABLE IF NOT EXISTS Reservations (
  id_reservation INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires ON DELETE CASCADE,
  id_abonne INTEGER NOT NULL REFERENCES Abonnes ON DELETE CASCADE,
  date_reservation DATE NOT NULL,
  date_expiration DATE NOT NULL
);

-- Table des prêts d'ouvrages
CREATE TABLE IF NOT EXISTS Prets (
  id_pret INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires ON DELETE CASCADE,
  id_abonne INTEGER NOT NULL REFERENCES Abonnes ON DELETE CASCADE,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  retard INTEGER NOT NULL
);

-- Table des renouvellements
CREATE TABLE IF NOT EXISTS Prets_Renouvellements(
  id_renouvellement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_pret INTEGER NOT NULL REFERENCES Prets ON DELETE CASCADE,
  date_renouvellement DATE NOT NULL,
  date_fin DATE NOT NULL
);

-- Table des interventions des intervenants
CREATE TABLE IF NOT EXISTS Interventions (
  id_intervention INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_personne INTEGER NOT NULL REFERENCES Intervenants ON DELETE CASCADE
);

-- Table des transferts d'exemplaires entre bibliothèques
CREATE TABLE IF NOT EXISTS Transferts (
  id_transfert INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires ON DELETE CASCADE,
  id_bibliotheque_depart INTEGER NOT NULL REFERENCES Bibliotheques ON DELETE CASCADE,
  id_bibliotheque_arrivee INTEGER NOT NULL REFERENCES Bibliotheques ON DELETE CASCADE,
  date_demande DATE NOT NULL,
  date_arrivee DATE NOT NULL
);

-- Table des achats d'exemplaires
CREATE TABLE IF NOT EXISTS Achats (
  id_achat INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_exemplaire INTEGER NOT NULL REFERENCES Exemplaires ON DELETE CASCADE,
  prix INTEGER NOT NULL,
  date_achat DATE NOT NULL,
  fournisseur VARCHAR NOT NULL
);

-- Table des pénalités
CREATE TABLE IF NOT EXISTS Penalites (
  id_penalite INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nature_infraction VARCHAR NOT NULL,
  id_pret INTEGER NOT NULL REFERENCES Prets ON DELETE CASCADE,
  id_personne INTEGER NOT NULL REFERENCES Personnes ON DELETE CASCADE
);

-- Table des amendes
CREATE TABLE IF NOT EXISTS Amendes (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites ON DELETE CASCADE,
  montant INTEGER NOT NULL
);

-- Table des réglements d'amendes
CREATE TABLE IF NOT EXISTS Amendes_Reglements(
  id_amende_reglement INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_penalite INTEGER NOT NULL REFERENCES Penalites ON DELETE CASCADE,
  date_reglement DATE NOT NULL
);

-- Table des bannissements temporaires
CREATE TABLE IF NOT EXISTS Banissements_Temporaires (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites ON DELETE CASCADE,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL
);

-- Table des bannissements permanents
CREATE TABLE IF NOT EXISTS Banissements (
  id_penalite INTEGER PRIMARY KEY REFERENCES Penalites ON DELETE CASCADE,
  date_debut DATE NOT NULL
);


-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Functions :
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- ABONNEMENTS :

-- Vérifie la possibilité de résiliation de l'abonnement
CREATE OR REPLACE FUNCTION _verif_pret_before_subsription_delete_fn(abonnement Abonnements)
RETURNS VOID AS $$
BEGIN
	-- Vérifie que l'abonné(e) n'as pas de prêts en cours
    IF EXISTS (
		SELECT 1
		FROM Prets AS pret
		WHERE abonnement.id_personne = pret.id_abonne
		AND (pret.date_fin + INTERVAL '1 day' * pret.retard) > CURRENT_DATE
	) THEN
		RAISE EXCEPTION 'L''abonné(e) a un prêt en cours, il ne peut donc pas résilier son abonnement';
	END IF;
END;
$$ LANGUAGE plpgsql;


-- Main Function :

CREATE OR REPLACE FUNCTION on_subsription_delete_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Appel des fonctions de validation en leur passant la ligne OLD
	PERFORM _verif_pret_before_subsription_delete_fn(OLD)

	-- On retire les réservation en cours/futures de l'abonné(e)
	DELETE FROM Reservations
	WHERE id_abonne = OLD.id_personne
	AND date_expiration >= CURRENT_DATE;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- PRETS :

CREATE OR REPLACE FUNCTION verif_pret_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
	-- Vérifier que la date de début existe et corriger si besoin
    IF (NEW.date_debut IS NULL) THEN
        NEW.date_debut = CURRENT_DATE;
	END IF;

    -- Vérifier que l'emprunt dure bien 1 mois et corriger si besoin
    IF (NEW.date_fin != NEW.date_debut + INTERVAL '1 month' OR NEW.date_fin IS NULL) THEN
        NEW.date_fin := NEW.date_debut + INTERVAL '1 month';
	END IF;

	-- Vérifier le nombre de renouvellement est bien renseigné
    IF (NEW.retard IS NULL) THEN
        NEW.retard = 0;
	END IF;

    -- Vérifier si l'exemplaire n'est pas déjà emprunté sur la période demandée
    IF (
    EXISTS (
            SELECT 1
            FROM Prets
            WHERE id_exemplaire = NEW.id_exemplaire
            AND NEW.date_debut <= date_fin
            AND NEW.date_fin >= date_debut
        ) OR EXISTS (
            SELECT 1
            FROM Prets AS p
            JOIN (
                SELECT id_pret, MAX(date_fin) AS last_date_fin
                FROM Prets_Renouvellements
                GROUP BY id_pret
            ) AS pr ON pr.id_pret = p.id_pret
            WHERE p.id_exemplaire = NEW.id_exemplaire
            AND NEW.date_debut <= pr.last_date_fin
            AND NEW.date_fin >= p.date_debut
        )
    ) THEN
    	RAISE EXCEPTION 'L''ouvrage est déjà emprunté sur cette période';
	END IF;


    -- Vérifier si l'exemplaire n'est pas déjà réservé sur la période demandée
    IF (
    EXISTS (
            SELECT 1
            FROM Reservations AS r
            WHERE r.id_exemplaire = NEW.id_exemplaire
            AND NEW.date_debut <= r.date_expiration
            AND NEW.date_fin >= r.date_reservation
        )
    ) THEN
    	RAISE EXCEPTION 'L''ouvrage est déjà réservé sur cette période';
	END IF;


    -- Vérifier si l'abonné(e) n'a pas atteint son maximum de livres empruntés
    IF (
        (
            SELECT abnmt.nombre_livres
            FROM Abonnes AS abe
            JOIN Abonnements AS abnmt ON abe.id_abonnement = abnmt.id_abonnement
            WHERE abe.id_personne = NEW.id_abonne
        ) <= (
            SELECT COUNT(*)
            FROM Prets AS p
            WHERE p.id_abonne = NEW.id_abonne
            AND p.date_fin >= CURRENT_DATE -- Livres non encore rendus
        )
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) a déjà atteint le maximum de livres empruntables permis par son abonnement';
    END IF;

    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement temporaire)
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements_Temporaires AS bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND bt.date_debut <= CURRENT_DATE
        AND bt.date_fin >= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) est banni temporairement';
    END IF;

    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement définitif)
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements AS b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND b.date_debut <= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) est banni définitivement';
    END IF;

	-- Vérifie que l'abonné(e) n'ait pas d'amende impayée :
	IF EXISTS (
	    SELECT 1
	    FROM Penalites p
	    JOIN Amendes am ON am.id_penalite = p.id_penalite
	    WHERE p.id_personne = NEW.id_abonne
	    AND am.id_penalite NOT IN (SELECT id_penalite FROM Amendes_Reglements)
	) THEN
	    RAISE EXCEPTION 'L''abonné(e) n''a pas encore réglé ses amendes';
    END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION verif_pret_prolongation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier que la date de renouvellement est instanciée
    IF (NEW.date_renouvellement IS NULL) THEN
        NEW.date_renouvellement = CURRENT_DATE;
	END IF;

	-- Vérifier que la date de fin est instanciée
    IF (NEW.date_fin IS NULL) THEN
        NEW.date_fin := CURRENT_DATE + INTERVAL '14 days';
	END IF;

    -- Vérifier si le livre n'est pas réservé sur la période de prolongation
    IF EXISTS (
        SELECT 1
        FROM Prets AS p
        JOIN Reservations AS r ON r.id_exemplaire = p.id_exemplaire
        WHERE NEW.id_pret = p.id_pret
        AND r.date_expiration >= NEW.date_renouvellement
        AND NEW.date_fin >= r.date_reservation
    ) THEN
        RAISE EXCEPTION 'L''ouvrage est réservé';
	END IF;

    -- Vérifier que l'abonné(e) n'a pas atteint sa limite de renouvellement (3 fois max)
    IF (SELECT COUNT(*) FROM Prets_Renouvellements WHERE id_pret = NEW.id_pret) > 3 THEN
        RAISE EXCEPTION 'L''abonné(e) a déjà consommé ses 3 renouvellements sur ce prêt';
	END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;





--------------------------------------------------------------------------------
-- RESERVATIONS :


-- Vérifie la capacité de la personne à faire une réservation
CREATE OR REPLACE FUNCTION _verif_personne_reservation_ability(rec Reservations)
RETURNS VOID AS $$
BEGIN
    -- Vérifie que la personne soit bien abonnée :
    IF (rec.id_abonne NOT IN (SELECT id_personne FROM Abonnes)) THEN
        RAISE EXCEPTION 'Seul un abonné peut réaliser une reservation';
    END IF;

    -- Vérifie que l'abonné n'ait pas été banni définitivement :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Banissements b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = rec.id_abonne
    ) THEN
        RAISE EXCEPTION 'L''abonné est banni définitivement';
    END IF;

    -- Vérifie que l'abonné n'ait pas été banni temporairement :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Banissements_Temporaires bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = rec.id_abonne
          AND bt.date_debut <= CURRENT_DATE
          AND CURRENT_DATE <= bt.date_fin
    ) THEN
        RAISE EXCEPTION 'L''abonné est banni temporairement';
    END IF;

    -- Vérifier que l'abonné n'ait pas d'amendes impayées :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Amendes am ON am.id_penalite = p.id_penalite
        WHERE p.id_personne = rec.id_abonne
          AND am.id_penalite NOT IN (SELECT id_penalite FROM Amendes_Reglements)
    ) THEN
        RAISE EXCEPTION 'L''abonné a des amendes impayées';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Vérifie la validité de la réservation
CREATE OR REPLACE FUNCTION _verif_reservation_validity(rec Reservations)
RETURNS VOID AS $$
BEGIN
    -- Vérifie que la date de réservation ne soit pas trop éloignée (plus de 1,5 mois à l'avance)
    IF (rec.date_reservation > (CURRENT_DATE + INTERVAL '1 month 15 days')) THEN
        RAISE EXCEPTION 'Un exemplaire ne peut être réservé plus d''un mois et demi à l''avance';
    END IF;

    -- Vérifie que l'exemplaire n'ait pas déjà été réservé
    IF EXISTS (
        SELECT 1
        FROM Reservations r
        WHERE r.id_exemplaire = rec.id_exemplaire
    ) THEN
        RAISE EXCEPTION 'L''exemplaire a déjà été réservé';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Main Function :

CREATE OR REPLACE FUNCTION verif_reservation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérification et réglage de la date de réservation
    IF (NEW.date_reservation IS NULL) THEN
        NEW.date_reservation := CURRENT_DATE;
    ELSIF (NEW.date_reservation < CURRENT_DATE) THEN
        RAISE EXCEPTION 'Date de reservation erronée';
    END IF;

    -- Si la date d'expiration n'est pas définie, on la fixe à 2 semaines après la date de début
    IF (NEW.date_expiration IS NULL) THEN
        NEW.date_expiration := NEW.date_reservation + INTERVAL '2 weeks';
    END IF;

    -- TODO : Lever une exception si la date de fin est trop éloignée une fois que la durée max d'une reservation est connue

    -- Appel des fonctions de validation en leur passant la ligne NEW
    PERFORM _verif_personne_reservation_ability(NEW);
    PERFORM _verif_reservation_validity(NEW);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;






--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Triggers :
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- ABONNEMENTS

CREATE TRIGGER verif_end_of_subsription
	BEFORE DELETE ON Abonnes
	FOR EACH ROW
	EXECUTE FUNCTION on_subsription_delete_fn();


--------------------------------------------------------------------------------
-- PRETS

CREATE TRIGGER verif_pret_insert
    BEFORE INSERT ON Prets
    FOR EACH ROW
    EXECUTE FUNCTION verif_pret_insert_fn();

CREATE TRIGGER verif_pret_prolongation_insert
    BEFORE INSERT ON Prets_Renouvellements
    FOR EACH ROW
    EXECUTE FUNCTION verif_pret_prolongation_insert_fn();


--------------------------------------------------------------------------------
-- RESERVATIONS

CREATE TRIGGER verif_reservation_insert
    BEFORE INSERT ON Reservations
    FOR EACH ROW
    EXECUTE FUNCTION verif_reservation_insert_fn();


Select init_roles();

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM PUBLIC;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;

CREATE VIEW Abonnes_Exemplaires AS
SELECT e.id_exemplaire, e.id_ouvrage, e.id_bibliotheque
FROM Exemplaires e
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Abonnes a ON a.code_postal = b.code_postal;

CREATE VIEW Vue_Bibliotheques_Bibliothecaires AS
SELECT DISTINCT b.*
FROM Bibliotheques b
JOIN Personnels p ON b.id_bibliotheque = p.id_bibliotheque;

CREATE OR REPLACE VIEW Penalites_Abonnes AS
SELECT p.*
FROM Penalites p
WHERE p.id_personne = (SELECT id_personne FROM Personnes where email = CURRENT_USER);

CREATE OR REPLACE VIEW Vue_Prets_Bibliothecaires AS
SELECT p.*
FROM Prets p
JOIN Exemplaires e ON p.id_exemplaire = e.id_exemplaire
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Personnels per ON b.id_bibliotheque = per.id_bibliotheque
WHERE per.id_personne = (Select id_personne FROM Personnes where email = CURRENT_USER);

CREATE VIEW Vue_Reservations_Bibliothecaires AS
SELECT r.*
FROM Reservations r
JOIN Exemplaires e ON r.id_exemplaire = e.id_exemplaire
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Personnels p ON p.id_bibliotheque = b.id_bibliotheque;

CREATE OR REPLACE VIEW Ouvrages_Frequemment_Transferes AS
SELECT
    o.id_ouvrage,
    o.titre,
    o.auteur,
    o.annee,
    t.id_transfert,
    t.date_demande,
    t.date_arrivee,
    EXTRACT(EPOCH FROM (t.date_arrivee::timestamp - t.date_demande::timestamp)) / 86400 AS temps_transfert_jours
FROM
    Ouvrages o
JOIN
    Exemplaires e ON o.id_ouvrage = e.id_ouvrage
JOIN
    Transferts t ON e.id_exemplaire = t.id_exemplaire
ORDER BY
    t.date_arrivee DESC;


-- Attribution des privilèges aux rôles

-- Attribution de tous les privilèges au directeur
ALTER ROLE directeur WITH SUPERUSER;

-- Attribution des privlièges aux abonnes
GRANT SELECT ON Exemplaires TO abonne;
GRANT SELECT ON Evenements TO abonne;
GRANT INSERT ON Reservations TO abonne;
GRANT INSERT ON Participants TO client;
GRANT SELECT ON Penalites_Abonnes TO abonne;
GRANT SELECT ON Abonnes_Exemplaires TO abonne;

-- Attribution des privlièges aux bibliothecaires
GRANT SELECT ON Vue_Bibliotheques_Bibliothecaires TO bibliothecaire;
GRANT SELECT ON Vue_Reservations_Bibliothecaires TO bibliothecaire;
GRANT SELECT ON Evenements, Collections TO bibliothecaire;
GRANT SELECT ON Vue_Prets_Bibliothecaires TO bibliothecaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON Transferts, Clients, Abonnes, Ouvrages, Exemplaires, Codes_Postaux, Prets TO bibliothecaire;
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


-- Insertion des métiers (inchangé)
INSERT INTO Metiers (nom_metier) VALUES
('Directeur'),
('Bibliothécaire'),
('Agent de sécurité'),
('Technicien informatique');

-- Insertion des personnes (inchangé)
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
('Leclerc', 'Antoine', 'antoine.leclerc@example.com'),
('Morel', 'Chloe', 'chloe.morel@example.com'),
('Garnier', 'Julien', 'julien.garnier@example.com'),
('Bernard', 'Sophie', 'sophie.bernard@example.com'),
('Girard', 'Maxime', 'maxime.girard@example.com'),
('Perret', 'Mélanie', 'melanie.perret@example.com'),
('Caron', 'Antoine', 'antoine.caron@example.com'),
('Blanc', 'Nicolas', 'nicolas.blanc@example.com'),
('Dupont', 'Julien', 'julien.dupont@example.com'),
('Lemoine', 'Clara', 'clara.lemoine@example.com'),
('Villard', 'Dorian', 'dorian.villard@example.com');


-- Insertion des clients (inchangé)
INSERT INTO Clients (id_personne)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insertion des abonnements (inchangé)
INSERT INTO Abonnements (nombre_livres, prix)
VALUES
(1, 24),
(3, 48),
(72, 6);

-- Insertion dans Codes_Postaux
-- On insère chaque code postal une seule fois et on ajoute ceux nécessaires pour les abonnés
INSERT INTO Codes_Postaux (code_postal, ville, pays)
VALUES
  (75012, 'Paris', 'France'),
  (69002, 'Lyon', 'France'),
  (13008, 'Marseille', 'France'),
  (31000, 'Toulouse', 'France'),
  (33000, 'Bordeaux', 'France'),
  (59000, 'Lille', 'France');

-- Insertion des abonnés
INSERT INTO Abonnes (id_personne, adresse, code_postal, rib, id_abonnement)
VALUES
  (11, '12 Rue des Lilas', 75012, 'FR7630003000701234567890125', 1),
  (12, '45 Avenue des Champs', 69002, 'FR7630003000709876543210987', 2),
  (13, '3 Impasse des Jardins', 13008, 'FR7630003000705678901234567', 1),
  (14, '9 Boulevard Saint-Michel', 31000, 'FR7630003000702345678912345', 3),
  (15, '14 Rue de la République', 33000, 'FR7630003000700987654321234', 2),
  (16, '22 Place Bellecour', 59000, 'FR7630003000701122334455667', 3);

-- Insertion des bibliothèques
-- On utilise le code postal pour respecter la référence
INSERT INTO Bibliotheques (nom_bibliotheque, adresse, code_postal)
VALUES
  ('Bibliothèque Centrale', '1 Place de l Université', 75012),
  ('Médiathèque de Lyon', '5 Rue des Archives', 69002),
  ('Bibliothèque Municipale', '10 Boulevard de la République', 13008);

-- Insertion des personnels avec id_metier
-- Correction du nom de colonne id_bibliotheque
INSERT INTO Personnels (id_personne, id_bibliotheque, id_metier, iban)
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

INSERT INTO Collections(nom_collection) VALUES ('Hachette');

INSERT INTO Ouvrages (titre, auteur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES
('Le Seigneur des Anneaux', 'J.R.R. Tolkien', 1954, 1200, 'Allen & Unwin', 1, 'Un groupe d amis part en quête pour détruire un anneau maléfique et sauver leur monde.', 25),
('1984', 'George Orwell', 1949, 328, 'Secker & Warburg', 1, 'Dans un futur totalitaire, un homme lutte contre le contrôle absolu de la pensée.', 15),
('Harry Potter à l École des Sorciers', 'J.K. Rowling', 1997, 309, 'Bloomsbury', 1, 'Un jeune orphelin découvre qu il est un sorcier et entre dans une école magique.', 20),
('La Peste', 'Albert Camus', 1947, 324, 'Gallimard', 1, 'Une épidémie de peste frappe une ville et les habitants luttent pour survivre.', 18);

INSERT INTO Exemplaires (id_ouvrage, id_bibliotheque)
VALUES
  (1, 1), -- Exemplaire 1 du livre "Le seigneur des anneaux" dans la bibliothèque 1
  (1, 1), -- Exemplaire 2 du même livre
  (2, 1), -- Exemplaire 3 du livre "1984" dans la bibliothèque 1
  (3, 1), -- Exemplaire 4 du livre "Harry Potter à l'école des sorciers" dans la bibliothèque 1
  (4, 1), -- Exemplaire 5 du livre "La peste" dans la bibliothèque 1
  (4, 1); -- Exemplaire 6 du même livre
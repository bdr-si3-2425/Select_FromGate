Executer les tests une foids que l'on aura trouvé la cause du bug

Pour tester :
```sql
CREATE TABLE IF NOT EXISTS Personnes (
    id_personne integer generated always as identity primary key,
    nom varchar not null,
    prenom varchar not null,
    email varchar not null
);

CREATE TABLE IF NOT EXISTS Clients (
    id_personne integer primary key REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Abonnements(
    id_abonnement integer generated always as identity primary key,
    nombre_livres integer not null,
    prix integer not null
);

CREATE TABLE IF NOT EXISTS Abonnes (
    id_personne integer primary key REFERENCES Personnes,
    adresse varchar not null,
    ville varchar not null,
    code_postal integer not null,
    pays varchar not null,
    rib varchar not null,
    id_abonnement integer not null REFERENCES Abonnements
);

CREATE TABLE IF NOT EXISTS Bibliotheques (
    id_bibliotheque integer generated always as identity primary key,
    nom_bibliotheque varchar not null,
    adresse varchar not null,
    ville varchar not null,
    pays varchar not null
);

CREATE TABLE IF NOT EXISTS Personnels (
    id_personne integer primary key REFERENCES Personnes,
    id_biliotheque integer not null REFERENCES Bibliotheques,
    poste varchar not null,
    iban varchar not null
);

CREATE TABLE IF NOT EXISTS Intervernants (
    id_personne integer primary key REFERENCES Personnes
);

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

CREATE TABLE IF NOT EXISTS Exemplaires(
    id_exemplaire integer generated always as identity primary key,
    id_ouvrage integer not null REFERENCES Ouvrages,
    id_bibliotheque integer not null REFERENCES Bibliotheques
);

CREATE TABLE IF NOT EXISTS Participants(
    id_participation integer generated always as identity primary key,
    id_evenement integer not null REFERENCES Evenements,
    id_personne integer not null REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Reservations(
    id_reservation integer generated always as identity primary key,
    id_exemplaire integer not null REFERENCES Exemplaires,
    id_abonne integer not null REFERENCES Abonnes,
    date_reservation date not null,
    date_expiration date not null
);

CREATE TABLE IF NOT EXISTS Prets(
    id_pret integer generated always as identity primary key,
    id_exemplaire integer not null REFERENCES Exemplaires,
    id_abonne integer not null REFERENCES Abonnes,
    date_debut date,
    date_fin date,
    compteur_renouvellement integer,
    retard integer
);

CREATE TABLE IF NOT EXISTS Interventions(
    id_intervention integer generated always as identity primary key,
    id_personne integer not null REFERENCES Intervernants
);

CREATE TABLE IF NOT EXISTS Transferts(
    id_transfert integer generated always as identity primary key,
    id_exemplaire integer not null REFERENCES Exemplaires,
    id_bibliotheque_depart integer not null REFERENCES Bibliotheques,
    id_bibliotheque_arrivee integer not null REFERENCES Bibliotheques,
    date_demande date not null,
    date_arrivee date not null
);

CREATE TABLE IF NOT EXISTS Achats(
    id_achat integer generated always as identity primary key,
    id_exemplaire integer not null REFERENCES Exemplaires,
    prix integer not null,
    date_achat date not null,
    fournisseur varchar not null
);

CREATE TABLE IF NOT EXISTS Penalites(
    id_penalite integer generated always as identity primary key,
    nature_infraction varchar not null,
    id_pret integer not null,
    id_personne integer not null REFERENCES Personnes
);

CREATE TABLE IF NOT EXISTS Amendes(
    id_penalite integer primary key REFERENCES Penalites,
    montant integer not null
);

CREATE TABLE IF NOT EXISTS Amendes_Reglements(
    id_amende_reglement integer generated always as identity primary key,
    id_penalite integer NOT NULL REFERENCES Penalites,
    date_reglement date not null
);

CREATE TABLE IF NOT EXISTS Banissements_Temporaires(
    id_penalite integer primary key REFERENCES Penalites,
    date_debut date not null,
    date_fin date not null
);

CREATE TABLE IF NOT EXISTS Banissements(
    id_penalite integer primary key REFERENCES Penalites,
    date_debut date not null
);




CREATE OR REPLACE FUNCTION _verif_personne_reservation_ability_fn()
RETURNS TRIGGER AS $$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM Abonnes AS ab
        WHERE ab.id_personne = NEW.id_abonne
    ) THEN
        RAISE EXCEPTION "Seul un abonné peut réaliser une reservation";
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements AS b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
    ) THEN
        RAISE EXCEPTION "L'abonné est banni définitevement";
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements_Temporaires AS bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_
        AND bt.date_debut <= CURRENT_DATE
        AND CURRENT_DATE <= bt.date_fin
    ) THEN
        RAISE EXCEPTION "L'abonné est banni temporairement";
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Amendes AS am ON am.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND bt.date_debut <= CURRENT_DATE
        AND bt.date_fin >= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION "L'abonné a des amendes impayées";
    END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION _verif_reservation_validity_fn()
RETURNS TRIGGER AS $$
BEGIN

    IF (NEW.date_reservation > (CURRENT_DATE + INTERVAL '1 month 15 days')) THEN
        RAISE EXCEPTION "Un exemplaire ne peut être réservé plus d'un mois et demi à l'avance";
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Reservation AS r
        WHERE r.id_exemplaire = NEW.id_exemplaire
    ) THEN
        RAISE EXCEPTION "L'exemplaire a déjà était reservé";
    END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;


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
('Dupuis', 'Lucas', 'lucas.dupuis@example.com'),
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
(11, '12 Rue des Lilas', 'Paris', 75012, 'France', 'FR7630003000701234567890125', 1),
(12, '45 Avenue des Champs', 'Lyon', 69002, 'France', 'FR7630003000709876543210987', 2),
(13, '3 Impasse des Jardins', 'Marseille', 13008, 'France', 'FR7630003000705678901234567', 1),
(14, '9 Boulevard Saint-Michel', 'Toulouse', 31000, 'France', 'FR7630003000702345678912345', 3),
(15, '14 Rue de la République', 'Bordeaux', 33000, 'France', 'FR7630003000700987654321234', 2),
(16, '22 Place Bellecour', 'Lille', 59000, 'France', 'FR7630003000701122334455667', 3),
(17, '5 Rue Nationale', 'Nantes', 44000, 'France', 'FR7630003000702233445566778', 1),
(18, '18 Rue des Fleurs', 'Strasbourg', 67000, 'France', 'FR7630003000703344556677889', 2),
(19, '7 Avenue de la Paix', 'Rennes', 35000, 'France', 'FR7630003000704455667788990', 1),
(20, '11 Rue Victor Hugo', 'Nice', 06000, 'France', 'FR7630003000705566778899001', 3),
(21, '12 Rue des Lilas', 'Paris', 75012, 'France', 'FR7630003000701234567890125', 1),
(22, '45 Avenue des Champs', 'Lyon', 69002, 'France', 'FR7630003000709876543210987', 2),
(23, '3 Impasse des Jardins', 'Marseille', 13008, 'France', 'FR7630003000705678901234567', 1),
(24, '9 Boulevard Saint-Michel', 'Toulouse', 31000, 'France', 'FR7630003000702345678912345', 3),
(25, '14 Rue de la République', 'Bordeaux', 33000, 'France', 'FR7630003000700987654321234', 2),
(26, '22 Place Bellecour', 'Lille', 59000, 'France', 'FR7630003000701122334455667', 3),
(27, '5 Rue Nationale', 'Nantes', 44000, 'France', 'FR7630003000702233445566778', 1),
(28, '18 Rue des Fleurs', 'Strasbourg', 67000, 'France', 'FR7630003000703344556677889', 2),
(29, '7 Avenue de la Paix', 'Rennes', 35000, 'France', 'FR7630003000704455667788990', 1),
(30, '11 Rue Victor Hugo', 'Nice', 06000, 'France', 'FR7630003000705566778899001', 3);

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays)
VALUES
('Bibliothèque Centrale', '1 Place de l Université', 'Paris', 'France'),
('Médiathèque de Lyon', '5 Rue des Archives', 'Lyon', 'France'),
('Bibliothèque Municipale', '10 Boulevard de la République', 'Marseille', 'France');

INSERT INTO Personnels (id_personne, id_biliotheque, poste, iban)
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
-- MAIN FUNCTION :
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verif_reservation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN

    IF (NEW.date_reservation IS NULL) THEN
        NEW.date_reservation = CURRENT_DATE;
    ELSIF (NEW.date_reservation < CURRENT_DATE) THEN
        RAISE EXCEPTION "Date de reservation erronée";
    END IF;

    IF (NEW.date_fin IS NULL) THEN
        NEW.date_fin := NEW.date_debut + INTERVAL '2 weeks';
    END IF;

    EXECUTE _verif_personne_reservation_ability_fn();
    EXECUTE _verif_reservation_validity_fn();
    USING NEW;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- EMPRUNTS
--------------------------------------------------------------------------------

-- ...



--------------------------------------------------------------------------------
-- RESERVATIONS
--------------------------------------------------------------------------------


CREATE TRIGGER verif_reservation_insert
    BEFORE INSERT ON Reservations
    FOR EACH ROW
    EXECUTE FUNCTION verif_reservation_insert_fn;



--------------------------------------------------------------------------------
-- Tests :
--------------------------------------------------------------------------------

-- ...
```
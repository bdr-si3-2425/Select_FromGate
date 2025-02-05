TRUNCATE TABLE Prets, Reservations CASCADE;
TRUNCATE TABLE Penalites, Banissements, Banissements_Temporaires, Amendes CASCADE;
TRUNCATE TABLE Amendes_Reglements CASCADE;

-- Test : Abonné n'ayant pas encore rêglé son amende
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin) VALUES (3, 12, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day');
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Amende', 1, 12);
INSERT INTO Amendes (id_penalite, montant) VALUES (1, 25);
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (1, 12);

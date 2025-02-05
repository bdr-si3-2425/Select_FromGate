TRUNCATE TABLE Prets, Reservations CASCADE;
TRUNCATE TABLE Penalites, Banissements, Banissements_Temporaires, Amendes CASCADE;
TRUNCATE TABLE Amendes_Reglements CASCADE;

-- Test : Abonné définitivement banni)
INSERT INTO Prets (id_exemplaire, id_bibliotheque,id_abonne, date_debut, date_fin) VALUES (3, 1, 12, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day');
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Fraude', 1, 13);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (1, 13);

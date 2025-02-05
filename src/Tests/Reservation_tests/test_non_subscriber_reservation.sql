TRUNCATE TABLE Prets, Reservations CASCADE;
TRUNCATE TABLE Penalites, Banissements, Banissements_Temporaires, Amendes CASCADE;
TRUNCATE TABLE Amendes_Reglements CASCADE;

-- Test : Reservation de la part d'une personne non-abbonnée
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (3, 1);

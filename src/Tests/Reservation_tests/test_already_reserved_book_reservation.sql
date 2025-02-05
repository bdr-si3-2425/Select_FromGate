TRUNCATE TABLE Prets, Reservations CASCADE;
TRUNCATE TABLE Penalites, Banissements, Banissements_Temporaires, Amendes CASCADE;
TRUNCATE TABLE Amendes_Reglements CASCADE;

-- Test : Reservation d'un exemplaire déjà reservé
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 11, CURRENT_DATE, CURRENT_DATE + INTERVAL '7 days');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');
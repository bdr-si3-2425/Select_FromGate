-- Vérification de la prolongation en cas de réservation existante
DELETE FROM Reservations WHERE id_exemplaire = 1;

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
VALUES (1, 12, CURRENT_DATE + INTERVAL '32 days', CURRENT_DATE + INTERVAL '60 days');

INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (1, 13);

UPDATE Prets
	SET date_fin = NULL
	WHERE id_abonne = 13 AND id_exemplaire = 1;
-- le trigger doit lever l'exception "L''ouvrage est réservé".


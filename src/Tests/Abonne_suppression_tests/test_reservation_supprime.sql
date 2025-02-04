-- Test 2 : Abonné sans prêt en cours (doit réussir)
DELETE FROM Prets WHERE id_abonne = 12;
DELETE FROM Reservations WHERE id_abonne = 12;

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
VALUES (2, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
VALUES (2, 12, CURRENT_DATE - INTERVAL '2 years', CURRENT_DATE - INTERVAL '500 days');

DELETE FROM Abonnes WHERE id_personne = 12;

-- On verifie que la suppression d'un abonné supprime bien sa réservation (en cours ou future)
SELECT * FROM Reservations WHERE id_abonne = 12;

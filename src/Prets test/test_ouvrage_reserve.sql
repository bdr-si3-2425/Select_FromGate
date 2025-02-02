-- Prêt sur exemplaire réservé
DELETE FROM Reservations WHERE id_exemplaire = 4;
DELETE FROM Prets WHERE id_exemplaire = 4;

-- On insère une réservation sur l'exemplaire 4 pour abonné 11
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
VALUES (4, 11, CURRENT_DATE + INTERVAL '2 days', CURRENT_DATE + INTERVAL '50 days');

-- Tentative de prêt sur le même exemplaire (abonné 12) : doit lever une exception
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

-- Se connecter en tant qu'abonné
SET ROLE abonne;

-- Vérifier si un abonné peut voir les exemplaires disponibles dans sa ville
SELECT * FROM Abonnes_Exemplaires; -- Doit fonctionner

-- Vérifier si un abonné peut voir les événements
SELECT * FROM Evenements; -- Doit fonctionner

-- Vérifier si un abonné peut réserver un ouvrage
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration) 
VALUES (1, 11, CURRENT_DATE, CURRENT_DATE + INTERVAL '7 days'); -- Doit echouer

-- Vérifier si un abonné peut mettre à jour sa réservation
UPDATE Reservations SET date_expiration = CURRENT_DATE + INTERVAL '10 days' WHERE id_abonne = 11; -- Doit échouer

-- Revenir au rôle normal
RESET ROLE;
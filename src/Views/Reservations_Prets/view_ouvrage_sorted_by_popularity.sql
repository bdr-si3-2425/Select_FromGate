CREATE VIEW Ouvrages_Sorted_By_Prets_Amount AS
    SELECT o.titre, o.id_ouvrage, COUNT(p.id_pret) AS "Nombre de prêts"
    FROM Exemplaires e
    JOIN Ouvrages o ON e.id_ouvrage = o.id_ouvrage
    JOIN Prets p ON p.id_exemplaire = e.id_exemplaire
    GROUP BY o.id_ouvrage
    ORDER BY COUNT(p.id_pret), o.titre;


CREATE VIEW Ouvrages_Sorted_By_Reservations_Amount AS
    SELECT o.titre, o.id_ouvrage, COUNT(r.id_reservation) AS "Nombre de réservations"
    FROM Exemplaires e
    JOIN Ouvrages o ON e.id_ouvrage = o.id_ouvrage
    JOIN Reservations r ON r.id_exemplaire = e.id_exemplaire
    GROUP BY o.id_ouvrage
    ORDER BY COUNT(r.id_reservation), o.titre;


-- Pour tester :
/*
TRUNCATE TABLE Prets, Reservations CASCADE;

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (5, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (6, 14, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

SELECT * FROM Ouvrages_Sorted_By_Prets_Amount;
*/

--------------------------------------------------------------------------------

/*
TRUNCATE TABLE Prets, Reservations CASCADE;

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (5, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (6, 14, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

SELECT * FROM Ouvrages_Sorted_By_Reservations_Amount;
*/
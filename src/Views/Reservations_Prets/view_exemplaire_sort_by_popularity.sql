CREATE VIEW Exemplaires_Sorted_By_Prets_Amount AS
    SELECT e.id_exemplaire, o.titre, e.id_ouvrage, COUNT(p.id_pret) AS "Nombre de prêts"
    FROM Exemplaires e
    JOIN Ouvrages o ON e.id_ouvrage = o.id_ouvrage
    JOIN Prets p ON p.id_exemplaire = e.id_exemplaire
    GROUP BY e.id_exemplaire
    ORDER BY COUNT(p.id_pret), o.titre;


CREATE VIEW Exemplaires_Sorted_By_Reservations_Amount AS
    SELECT e.id_exemplaire, o.titre, e.id_ouvrage, COUNT(r.id_reservation) AS "Nombre de réservations"
    FROM Exemplaires e
    JOIN Ouvrages o ON e.id_ouvrage = o.id_ouvrage
    JOIN Reservations r ON r.id_exemplaire = p.id_exemplaire
    GROUP BY e.id_exemplaire
    ORDER BY COUNT(r.id_reservation), o.titre;



-- Pour tester :
/*
TRUNCATE TABLE Prets, Reservations CASCADE;

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE + INTERVAL '1 month 1 day', CURRENT_DATE + INTERVAL '2 months 1 day');

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (6, 14, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

SELECT * FROM Exemplaires_Sorted_By_Prets_Amount;
*/

/*
TRUNCATE TABLE Prets, Reservations CASCADE;

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (5, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 months');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (6, 14, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

SELECT * FROM Exemplaires_Sorted_By_Reservations_Amount;
*/
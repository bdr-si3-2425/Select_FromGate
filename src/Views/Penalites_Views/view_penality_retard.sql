CREATE VIEW Abonnes_Retard AS
    SELECT id_personne
    FROM Abonnes ab
    JOIN Penalites pen USING(id_personne)
    WHERE pen.nature_infraction LIKE 'Retard';

CREATE VIEW Abonnes_Retard_Sorted_By_Frequence AS
    SELECT id_personne, COUNT(id_penalite) AS "Frequence"
    FROM Abonnes ab
    JOIN Penalites pen USING(id_personne)
    WHERE pen.nature_infraction LIKE 'Retard'
    GROUP BY id_personne
    ORDER BY COUNT(id_penalite);


-- Pour tester :
/*
TRUNCATE TABLE Prets, Reservations CASCADE;
TRUNCATE TABLE Penalites, Banissements, Banissements_Temporaires, Amendes CASCADE;

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE + INTERVAL '1 month 1 day', CURRENT_DATE + INTERVAL '2 months 1 day');
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (6, 14, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
    VALUES ('Retard', 1, 12);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');

INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
    VALUES ('Retard', 2, 12);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');

INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
    VALUES ('Retard', 3, 14);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');

SELECT * FROM Abonnes_Retard;
SELECT * FROM Abonnes_Retard_Sorted_By_Frequence;
*/
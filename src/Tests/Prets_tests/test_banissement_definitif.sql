-- Abonné définitivement banni (abonné 13)
DELETE FROM Prets WHERE id_abonne = 13;
DELETE FROM Banissements WHERE id_penalite = 1;
DELETE FROM Penalites WHERE id_penalite = 1;

-- Insertion d'une pénalité de type "Fraude" pour abonné 13
INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
VALUES ('Fraude', 1, 13);

-- Insertion d'un bannissement définitif lié à cette pénalité
INSERT INTO Banissements (id_penalite, date_debut)
VALUES (
	(SELECT id_penalite FROM Penalites ORDER BY id_penalite DESC LIMIT 1), 
	CURRENT_DATE - INTERVAL '1 day');

-- Tentative d'insertion d'un prêt pour abonné 13 : doit lever une exception
INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (1, 13);

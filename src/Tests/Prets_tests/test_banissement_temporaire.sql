-- Abonné temporairement banni (abonné 12)
DELETE FROM Prets WHERE id_abonne = 12;
DELETE FROM Banissements_Temporaires WHERE id_penalite = 1;
DELETE FROM Penalites WHERE id_penalite = 1;

-- Création du prêt
INSERT INTO Prets (id_exemplaire, id_abonne, id_bibliotheque)
VALUES (3, 12, 1);

-- Insertion d'une pénalité de type "Retard" pour abonné 12
INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
VALUES ('Retard', 1, 12);

-- Insertion d'un banissement temporaire lié à cette pénalité
INSERT INTO Banissements_Temporaires (id_penalite, date_debut, date_fin)
VALUES (
	(SELECT id_penalite FROM Penalites ORDER BY id_penalite DESC LIMIT 1), 
	CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day');

-- Tentative d'insertion d'un prêt pour abonné 12 : doit lever une exception
INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (6, 12);

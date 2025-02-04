-- Amende non réglée pour abonné 13
DELETE FROM Prets WHERE id_abonne = 13;
DELETE FROM Amendes_Reglements WHERE id_penalite = 1;
DELETE FROM Amendes WHERE id_penalite = 1;
DELETE FROM Penalites WHERE id_penalite = 1;

-- Insertion d'une pénalité de type "Amende" pour abonné 13
INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
VALUES ('Amende', 1, 13);

-- Création de l'amende correspondante
INSERT INTO Amendes (id_penalite, montant)
VALUES (
	(SELECT id_penalite FROM Penalites ORDER BY id_penalite DESC LIMIT 1), 
	25);

-- Aucune insertion dans Amendes_Reglements (donc l'amende n'est pas réglée)

-- Tentative d'insertion d'un prêt pour abonné 13 : doit lever une exception
INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (1, 13);

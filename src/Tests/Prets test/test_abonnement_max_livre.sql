-- Nombre maximum de prêts pour un abonné (abonné 11)
DELETE FROM Prets WHERE id_abonne = 11;

-- Premier prêt
INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (3, 11);

-- Tentative d'un second prêt pour abonné 11 (exemplaire 5) : doit lever une exception
INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (5, 11);

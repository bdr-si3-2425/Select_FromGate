-- Correction de la durée du prêt pour abonné 12 sur exemplaire 2
DELETE FROM Prets WHERE id_exemplaire = 2 AND id_abonne = 12;

INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (2, 12);

-- On insère un prêt avec date_fin incorrecte (CURRENT_DATE + 10 days)
UPDATE Prets 
SET date_fin = CURRENT_DATE + INTERVAL '10 days'
WHERE id_abonne = 12 AND id_exemplaire = 2;
UPDATE Prets 

SET date_fin = CURRENT_DATE + INTERVAL '10 days'
WHERE id_abonne = 12 AND id_exemplaire = 2;

-- Vérification : le trigger devrait avoir modifié date_fin à CURRENT_DATE 1 mois + 14 jours et a incrementé le renouvellement de 2 
SELECT * FROM Prets WHERE id_exemplaire = 2 AND id_abonne = 12;

-- Se connecter en tant qu'agent de sécurité
SET ROLE agent_securite;

-- Vérifier qu'il peut voir les pénalités
SELECT * FROM Penalites; -- Doit fonctionner

-- Vérifier qu'il peut voir les amendes
SELECT * FROM Amendes; -- Doit fonctionner

-- Vérifier qu'il peut Update les amendes
UPDATE Amendes SET montant = 50 WHERE id_penalite = 1;  -- Doit fonctionner

-- Vérifier qu'il peut modifier une pénalité
UPDATE Penalites SET nature_infraction = 'Retard' WHERE id_penalite = 1;

-- Vérifier qu'il ne peut pas modifier un prêt
UPDATE Prets SET retard = 1 WHERE id_pret = 1; -- Doit échouer

-- Vérifier qu'il ne peut pas lire la table Abonnes
SELECT * FROM Abonnes;  -- Doit échouer

-- Revenir au rôle normal
RESET ROLE;

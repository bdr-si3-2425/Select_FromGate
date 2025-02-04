-- Se connecter en tant qu'intervenant
SET ROLE intervenant;

-- Vérifier s'il peut voir les événements
SELECT * FROM Evenements;

-- Vérifier qu'il ne peut pas voir les prêts
SELECT * FROM Prets;

-- Revenir au rôle normal
RESET ROLE;

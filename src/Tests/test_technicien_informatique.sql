-- Se connecter en tant que technicien informatique
SET ROLE technicien_informatique;

-- Vérifier s'il peut voir les bibliothèques
SELECT * FROM Bibliotheques; -- Doit fonctionner

-- Vérifier s'il peut modifier les bibliothèques
UPDATE Bibliotheques SET nom_bibliotheque = 'Nouvelle Bibliothèque' WHERE id_bibliotheque = 1;  -- Doit fonctionner

-- Vérifier s'il peut mettre à jour une bibliothèque
UPDATE Bibliotheques SET nom_bibliotheque = 'Bibliothèque Modifiée' WHERE id_bibliotheque = 1; -- Doit fonctionner

-- Vérifier qu'il peut voir les employés
SELECT * FROM Personnels; -- Doit fonctionner

-- Vérifier qu'il peut modifier les employés
UPDATE Personnels SET iban = 'FR123456789' WHERE id_personne = 1; -- Doit fonctionner

-- Vérifier qu'il ne peut pas voir les prêts
SELECT * FROM Prets; -- Doit échouer

-- Vérifier qu'il ne peut pas modifier un ouvrage
UPDATE Ouvrages SET titre = 'Titre Modifié' WHERE id_ouvrage = 1;  -- Doit échouer

-- Revenir au rôle normal
RESET ROLE;

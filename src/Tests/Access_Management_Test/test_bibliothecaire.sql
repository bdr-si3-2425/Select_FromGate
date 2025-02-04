-- Se connecter en tant que bibliothécaire
SET ROLE bibliothecaire;

-- Vérifier si un bibliothécaire peut voir les bibliothèques où il travaille
SELECT * FROM Vue_Bibliotheques_Bibliothecaires; -- Doit fonctionner


-- Vérifier s'il peut voir les réservations de sa région
SELECT * FROM Vue_Reservations_Bibliothecaires; -- Doit fonctionner

-- Vérifier s'il peut ajouter un ouvrage
INSERT INTO Ouvrages (titre, auteur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES ('Nouveau Livre', 'Auteur Test', 2024, 300, 'Édition Test', 1, 'Résumé test', 25); -- Doit fonctionner

-- Vérifier s'il peut modifier un prêt
UPDATE Prets SET date_fin = CURRENT_DATE + INTERVAL '14 days' WHERE id_pret = 1; -- Doit fonctionner

-- Vérifier qu'il ne peut pas voir toutes les réservations
SELECT * FROM Reservations; -- Doit échouer

-- Revenir au rôle normal
RESET ROLE;

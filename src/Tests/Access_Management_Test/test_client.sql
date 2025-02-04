-- Se connecter en tant que client
SET ROLE client;

-- Vérifier s'il peut voir les ouvrages disponibles
SELECT * FROM Ouvrages; -- Doit fonctionner

-- Vérifier s'il peut voir les événements
SELECT * FROM Evenements; -- Doit fonctionner

-- Vérifier s'il peut s'inscrire à un événement
INSERT INTO Participants (id_evenement, id_personne) VALUES (1, 3); -- Doit fonctionner

-- Vérifier qu'il ne peut pas ajouter d'ouvrage
INSERT INTO Ouvrages (titre, auteur, annee, nb_pages, edition, id_collection, resume, prix) 
VALUES ('Livre Interdit', 'Auteur X', 2024, 200, 'Edition 2', 2, 'Résumé', 15);  -- Doit échouer

-- Revenir au rôle normal
RESET ROLE;

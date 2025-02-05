-- Insertion de personnes
INSERT INTO Personnes (nom, prenom, email) 
VALUES 
('Dupont', 'Jean', 'jean.dupont@gmail.com');

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays)
VALUES ('André Malraux', '6 rue des Colombes', 'Marseille', 'France');

-- Création d'un event
INSERT INTO Evenements (id_personne, id_bibliotheque, theme, nom, date_evenement, nb_max_personne, nb_abonne)
VALUES (1, 1, 'Littérature', 'Conférence littéraire', '2025-02-10', 3, 0);

-- Ajout du participant
INSERT INTO Participants (id_evenement, id_personne) VALUES (1, 1);
-- nb_abonnes devrait être à 1

-- Suppression du participant
DELETE FROM Participants WHERE id_participation = 1;
-- nb_abonnes devrait être à 0

SELECT * FROM Evenements;
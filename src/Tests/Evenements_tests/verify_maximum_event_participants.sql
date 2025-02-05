-- Insertion de personnes
INSERT INTO Personnes (nom, prenom, email) 
VALUES 
('Dupont', 'Jean', 'jean.dupont@gmail.com'),
('Martin', 'Claire', 'claire.martin@gmail.com'),
('Durand', 'Paul', 'paul.durand@gmail.com'),
('Morel', 'Sophie', 'sophie.morel@gmail.com');

-- Création d'un event avec 3 participants
INSERT INTO Evenements (id_personne, id_bibliotheque, theme, nom, date_evenement, nb_max_personne, nb_abonne)
VALUES (1, 1, 'Littérature', 'Conférence littéraire', '2025-02-10', 3, 0);

-- Ajout des 3 premiers participants
INSERT INTO Participants (id_evenement, id_personne) VALUES (1, 1), (1, 2), (1, 3);

-- Tentative d'ajout d'un quatrième participant
INSERT INTO Participants (id_evenement, id_personne) VALUES (1, 4);
-- erreur
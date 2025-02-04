-- Insertion des métiers
INSERT INTO Metiers (nom_metier) VALUES
('Directeur'),
('Bibliothécaire'),
('Agent de sécurité'),
('Technicien informatique');

-- Insertion des personnes
INSERT INTO Personnes (nom, prenom, email) 
VALUES 
('Dupont', 'Jean', 'jean.dupont@example.com'),
('Martin', 'Claire', 'claire.martin@example.com'),
('Durand', 'Paul', 'paul.durand@example.com'),
('Morel', 'Sophie', 'sophie.morel@example.com'),
('Roux', 'Luc', 'luc.roux@example.com'),
('Petit', 'Emma', 'emma.petit@example.com'),
('Noir', 'Mathieu', 'mathieu.noir@example.com'),
('Blanc', 'Laura', 'laura.blanc@example.com'),
('Girard', 'Nicolas', 'nicolas.girard@example.com'),
('Bernard', 'Marion', 'marion.bernard@example.com'),
('Perret', 'Julien', 'julien.perret@example.com'),
('Barbier', 'Elodie', 'elodie.barbier@example.com'),
('Garnier', 'Thomas', 'thomas.garnier@example.com'),
('Leclerc', 'Manon', 'manon.leclerc@example.com'),
('Dupuis', 'Lucas', 'lucas.dupuis@example.com'),
('Marchand', 'Camille', 'camille.marchand@example.com'),
('Simon', 'Hugo', 'hugo.simon@example.com'),
('Caron', 'Alice', 'alice.caron@example.com'),
('Lemoine', 'Pierre', 'pierre.lemoine@example.com'),
('Fournier', 'Chloe', 'chloe.fournier@example.com');

-- Insertion des clients
INSERT INTO Clients (id_personne)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insertion des abonnements
INSERT INTO Abonnements (nombre_livres, prix)
VALUES
(1, 24),
(3, 48),
(72, 6);

-- Insertion des abonnés
INSERT INTO Abonnes (id_personne, adresse, ville, code_postal, pays, rib, id_abonnement)
VALUES
(11, '12 Rue des Lilas', 'Paris', 75012, 'France', 'FR7630003000701234567890125', 1),
(12, '45 Avenue des Champs', 'Lyon', 69002, 'France', 'FR7630003000709876543210987', 2),
(13, '3 Impasse des Jardins', 'Marseille', 13008, 'France', 'FR7630003000705678901234567', 1),
(14, '9 Boulevard Saint-Michel', 'Toulouse', 31000, 'France', 'FR7630003000702345678912345', 3),
(15, '14 Rue de la République', 'Bordeaux', 33000, 'France', 'FR7630003000700987654321234', 2),
(16, '22 Place Bellecour', 'Lille', 59000, 'France', 'FR7630003000701122334455667', 3);

-- Insertion des bibliothèques
INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays)
VALUES
('Bibliothèque Centrale', '1 Place de l Université', 'Paris', 'France'),
('Médiathèque de Lyon', '5 Rue des Archives', 'Lyon', 'France'),
('Bibliothèque Municipale', '10 Boulevard de la République', 'Marseille', 'France');

-- Insertion des personnels avec id_metier
INSERT INTO Personnels (id_personne, id_biliotheque, id_metier, iban)
VALUES
(17, 1, 1, 'FR7612345678901234567890123'), -- Directeur
(18, 1, 2, 'FR7623456789012345678901234'), -- Bibliothécaire
(19, 1, 2, 'FR7634567890123456789012345'), -- Bibliothécaire
(20, 1, 3, 'FR7701234567890123456789012'), -- Agent de sécurité
(21, 1, 4, 'FR7712345678901234567890123'), -- Technicien informatique
(22, 2, 1, 'FR7645678901234567890123456'), -- Directeur
(23, 2, 2, 'FR7656789012345678901234567'), -- Bibliothécaire
(24, 2, 2, 'FR7667890123456789012345678'), -- Bibliothécaire
(25, 2, 3, 'FR7723456789012345678901234'), -- Agent de sécurité
(26, 2, 4, 'FR7734567890123456789012345'), -- Technicien informatique
(27, 3, 1, 'FR7678901234567890123456789'), -- Directeur
(28, 3, 2, 'FR7689012345678901234567890'), -- Bibliothécaire
(29, 3, 2, 'FR7690123456789012345678901'), -- Bibliothécaire
(30, 3, 3, 'FR7745678901234567890123456'), -- Agent de sécurité
(31, 3, 4, 'FR7756789012345678901234567'); -- Technicien informatique

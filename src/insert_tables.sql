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
('Fournier', 'Chloe', 'chloe.fournier@example.com'),
('Dupuis', 'Lucas', 'lucas.dupuis@example.com'),
('Lemoine', 'Pierre', 'pierre.lemoine@example.com'),
('Fournier', 'Chloe', 'chloe.fournier@example.com'),
('Petit', 'Maxime', 'maxime.petit@example.com'),
('Martin', 'Sophie', 'sophie.martin@example.com'),
('Leclerc', 'Alice', 'alice.leclerc@example.com'),
('Roux', 'Julien', 'julien.roux@example.com'),
('Lemoine', 'Claire', 'claire.lemoine@example.com'),
('Morel', 'Antoine', 'antoine.morel@example.com'),
('Garnier', 'Camille', 'camille.garnier@example.com'),
('Bernard', 'Hugo', 'hugo.bernard@example.com'),
('Girard', 'Mélanie', 'melanie.girard@example.com'),
('Perret', 'Nicolas', 'nicolas.perret@example.com'),
('Caron', 'Elise', 'elise.caron@example.com'),
('Blanc', 'Thomas', 'thomas.blanc@example.com'),
('Dupont', 'Pierre', 'pierre.dupont@example.com'),
('Lemoine', 'Mathieu', 'mathieu.lemoine@example.com'),
('Roux', 'Sophie', 'sophie.roux@example.com'),
('Martin', 'Julien', 'julien.martin@example.com'),
('Leclerc', 'Antoine', 'antoine.leclerc@example.com'),
('Morel', 'Chloe', 'chloe.morel@example.com'),
('Garnier', 'Julien', 'julien.garnier@example.com'),
('Bernard', 'Sophie', 'sophie.bernard@example.com'),
('Girard', 'Maxime', 'maxime.girard@example.com'),
('Perret', 'Mélanie', 'melanie.perret@example.com'),
('Caron', 'Antoine', 'antoine.caron@example.com'),
('Blanc', 'Nicolas', 'nicolas.blanc@example.com'),
('Dupont', 'Julien', 'julien.dupont@example.com'),
('Lemoine', 'Clara', 'clara.lemoine@example.com');

INSERT INTO Clients (id_personne)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO Abonnements (nombre_livres, prix)
VALUES
(1, 24),
(3, 48),
(72, 6);

INSERT INTO Abonnes (id_personne, adresse, ville, code_postal, pays, rib, id_abonnement)
VALUES
(11, '12 Rue des Lilas', 'Paris', 75012, 'France', 'FR7630003000701234567890125', 1),
(12, '45 Avenue des Champs', 'Lyon', 69002, 'France', 'FR7630003000709876543210987', 2),
(13, '3 Impasse des Jardins', 'Marseille', 13008, 'France', 'FR7630003000705678901234567', 1),
(14, '9 Boulevard Saint-Michel', 'Toulouse', 31000, 'France', 'FR7630003000702345678912345', 3),
(15, '14 Rue de la République', 'Bordeaux', 33000, 'France', 'FR7630003000700987654321234', 2),
(16, '22 Place Bellecour', 'Lille', 59000, 'France', 'FR7630003000701122334455667', 3),
(17, '5 Rue Nationale', 'Nantes', 44000, 'France', 'FR7630003000702233445566778', 1),
(18, '18 Rue des Fleurs', 'Strasbourg', 67000, 'France', 'FR7630003000703344556677889', 2),
(19, '7 Avenue de la Paix', 'Rennes', 35000, 'France', 'FR7630003000704455667788990', 1),
(20, '11 Rue Victor Hugo', 'Nice', 06000, 'France', 'FR7630003000705566778899001', 3),
(21, '12 Rue des Lilas', 'Paris', 75012, 'France', 'FR7630003000701234567890125', 1),
(22, '45 Avenue des Champs', 'Lyon', 69002, 'France', 'FR7630003000709876543210987', 2),
(23, '3 Impasse des Jardins', 'Marseille', 13008, 'France', 'FR7630003000705678901234567', 1),
(24, '9 Boulevard Saint-Michel', 'Toulouse', 31000, 'France', 'FR7630003000702345678912345', 3),
(25, '14 Rue de la République', 'Bordeaux', 33000, 'France', 'FR7630003000700987654321234', 2),
(26, '22 Place Bellecour', 'Lille', 59000, 'France', 'FR7630003000701122334455667', 3),
(27, '5 Rue Nationale', 'Nantes', 44000, 'France', 'FR7630003000702233445566778', 1),
(28, '18 Rue des Fleurs', 'Strasbourg', 67000, 'France', 'FR7630003000703344556677889', 2),
(29, '7 Avenue de la Paix', 'Rennes', 35000, 'France', 'FR7630003000704455667788990', 1),
(30, '11 Rue Victor Hugo', 'Nice', 06000, 'France', 'FR7630003000705566778899001', 3);

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays)
VALUES
('Bibliothèque Centrale', '1 Place de l Université', 'Paris', 'France'),
('Médiathèque de Lyon', '5 Rue des Archives', 'Lyon', 'France'),
('Bibliothèque Municipale', '10 Boulevard de la République', 'Marseille', 'France');

INSERT INTO Personnels (id_personne, id_biliotheque, poste, iban)
VALUES
(31, 1, 'Directeur', 'FR7612345678901234567890123'),
(32, 1, 'Bibliothécaire', 'FR7623456789012345678901234'),
(33, 1, 'Bibliothécaire', 'FR7634567890123456789012345'),
(40, 1, 'Agent de sécurité', 'FR7701234567890123456789012'),
(41, 1, 'Technicien informatique', 'FR7712345678901234567890123'),
(34, 2, 'Directeur', 'FR7645678901234567890123456'),
(35, 2, 'Bibliothécaire', 'FR7656789012345678901234567'),
(36, 2, 'Bibliothécaire', 'FR7667890123456789012345678'),
(42, 2, 'Agent de sécurité', 'FR7723456789012345678901234'),
(43, 2, 'Technicien informatique', 'FR7734567890123456789012345'),
(37, 3, 'Directeur', 'FR7678901234567890123456789'),
(38, 3, 'Bibliothécaire', 'FR7689012345678901234567890'),
(39, 3, 'Bibliothécaire', 'FR7690123456789012345678901'),
(44, 3, 'Agent de sécurité', 'FR7745678901234567890123456'),
(45, 3, 'Technicien informatique', 'FR7756789012345678901234567');
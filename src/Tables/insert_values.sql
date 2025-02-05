-- Insertion des métiers (inchangé)
INSERT INTO Metiers (nom_metier) VALUES
('Directeur'),
('Bibliothécaire'),
('Agent de sécurité'),
('Technicien informatique');

-- Insertion des personnes (inchangé)
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
('Leclerc', 'Antoine', 'antoine.leclerc@example.com'),
('Morel', 'Chloe', 'chloe.morel@example.com'),
('Garnier', 'Julien', 'julien.garnier@example.com'),
('Bernard', 'Sophie', 'sophie.bernard@example.com'),
('Girard', 'Maxime', 'maxime.girard@example.com'),
('Perret', 'Mélanie', 'melanie.perret@example.com'),
('Caron', 'Antoine', 'antoine.caron@example.com'),
('Blanc', 'Nicolas', 'nicolas.blanc@example.com'),
('Dupont', 'Julien', 'julien.dupont@example.com'),
('Lemoine', 'Clara', 'clara.lemoine@example.com'),
('Villard', 'Dorian', 'dorian.villard@example.com');


-- Insertion des clients (inchangé)
INSERT INTO Clients (id_personne)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insertion des abonnements (inchangé)
INSERT INTO Abonnements (nombre_livres, prix)
VALUES
(1, 24),
(3, 48),
(72, 6);

-- Insertion dans Codes_Postaux
-- On insère chaque code postal une seule fois et on ajoute ceux nécessaires pour les abonnés
INSERT INTO Codes_Postaux (code_postal, ville, pays)
VALUES
  (75012, 'Paris', 'France'),
  (69002, 'Lyon', 'France'),
  (13008, 'Marseille', 'France'),
  (31000, 'Toulouse', 'France'),
  (33000, 'Bordeaux', 'France'),
  (59000, 'Lille', 'France');

-- Insertion des abonnés
INSERT INTO Abonnes (id_personne, adresse, code_postal, rib, id_abonnement)
VALUES
  (11, '12 Rue des Lilas', 75012, 'FR7630003000701234567890125', 1),
  (12, '45 Avenue des Champs', 69002, 'FR7630003000709876543210987', 2),
  (13, '3 Impasse des Jardins', 13008, 'FR7630003000705678901234567', 1),
  (14, '9 Boulevard Saint-Michel', 31000, 'FR7630003000702345678912345', 3),
  (15, '14 Rue de la République', 33000, 'FR7630003000700987654321234', 2),
  (16, '22 Place Bellecour', 59000, 'FR7630003000701122334455667', 3);

-- Insertion des bibliothèques
-- On utilise le code postal pour respecter la référence
INSERT INTO Bibliotheques (nom_bibliotheque, adresse, code_postal)
VALUES
  ('Bibliothèque Centrale', '1 Place de l Université', 75012),
  ('Médiathèque de Lyon', '5 Rue des Archives', 69002),
  ('Bibliothèque Municipale', '10 Boulevard de la République', 13008);

-- Insertion des personnels avec id_metier
-- Correction du nom de colonne id_bibliotheque
INSERT INTO Personnels (id_personne, id_bibliotheque, id_metier, iban)
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

INSERT INTO Collections(nom_collection) VALUES ('Hachette');

INSERT INTO Ouvrages (titre, auteur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES
('Le Seigneur des Anneaux', 'J.R.R. Tolkien', 1954, 1200, 'Allen & Unwin', 1, 'Un groupe d amis part en quête pour détruire un anneau maléfique et sauver leur monde.', 25),
('1984', 'George Orwell', 1949, 328, 'Secker & Warburg', 1, 'Dans un futur totalitaire, un homme lutte contre le contrôle absolu de la pensée.', 15),
('Harry Potter à l École des Sorciers', 'J.K. Rowling', 1997, 309, 'Bloomsbury', 1, 'Un jeune orphelin découvre qu il est un sorcier et entre dans une école magique.', 20),
('La Peste', 'Albert Camus', 1947, 324, 'Gallimard', 1, 'Une épidémie de peste frappe une ville et les habitants luttent pour survivre.', 18);

INSERT INTO Exemplaires (id_ouvrage, id_bibliotheque)
VALUES
  (1, 1), -- Exemplaire 1 du livre "Le seigneur des anneaux" dans la bibliothèque 1
  (1, 1), -- Exemplaire 2 du même livre
  (2, 1), -- Exemplaire 3 du livre "1984" dans la bibliothèque 1
  (3, 1), -- Exemplaire 4 du livre "Harry Potter à l'école des sorciers" dans la bibliothèque 1
  (4, 1), -- Exemplaire 5 du livre "La peste" dans la bibliothèque 1
  (4, 1); -- Exemplaire 6 du même livre
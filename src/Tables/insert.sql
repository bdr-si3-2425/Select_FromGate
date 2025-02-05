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
('Lemoine', 'Clara', 'clara.lemoine@example.com'),
('Léo', 'Migny', 'leopc.migny@gmail.com');

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

INSERT INTO Intervernants (id_personne)
VALUES (46), (47), (48), (49), (50);

INSERT INTO Evenements (id_personne, id_bibliotheque, theme, nom, date_evenement, nb_max_personne, nb_abonne) 
VALUES
(46, 1, 'Littérature moderne', 'Conférence sur les nouvelles tendances', '2025-03-15', 50, 20),
(47, 2, 'Science et nature', 'Atelier sur la biodiversité', '2025-04-10', 30, 15),
(48, 3, 'Art et culture', 'Exposition interactive', '2025-05-20', 70, 40);

INSERT INTO Ouvrages (titre, autheur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES
('Les Aventures de Jules', 'Martin Dupont', 2015, 320, 'Edition Soleil', 1, 'Une aventure fascinante d un jeune explorateur.', 25),
('La Nuit Étoilée', 'Claire Fontaine', 2019, 200, 'Edition Lune', 2, 'Un roman poétique sous le ciel nocturne.', 18),
('Secrets du Passé', 'Jean Moreau', 2010, 400, 'Edition Historica', 3, 'Un voyage dans les mystères de l histoire.', 30),
('Le Futur Imaginé', 'Sophie Lambert', 2021, 280, 'Edition Futurium', 4, 'Une exploration fascinante des technologies à venir.', 22),
('Voyage au Bout du Monde', 'Antoine Leclerc', 2017, 350, 'Edition Aventure', 5, 'Un périple extraordinaire à travers des paysages sauvages.', 27),
('L Art de la Cuisine', 'Michel Garnier', 2016, 150, 'Edition Gourmet', 6, 'Recettes savoureuses et astuces culinaires.', 20),
('La Magie des Étoiles', 'Isabelle Martin', 2020, 310, 'Edition Cosmique', 2, 'Un conte merveilleux sous les étoiles.', 24),
('Les Enigmes de l Univers', 'Paul Descartes', 2018, 450, 'Edition Savoir', 7, 'Une plongée fascinante dans les mystères de l univers.', 35),
('L Ombre du Passé', 'Marion Duval', 2014, 290, 'Edition Noir', 3, 'Un thriller captivant au cœur des secrets familiaux.', 28),
('L Harmonie Perdue', 'Emilie Laurent', 2019, 360, 'Edition Mélodie', 8, 'Un roman poignant sur la quête du bonheur.', 26),
('La Forêt Enchantée', 'Jacques Petit', 2021, 270, 'Edition Nature', 5, 'Une aventure magique dans une forêt mystérieuse.', 21),
('Les Machines du Futur', 'Julien Garnier', 2022, 340, 'Edition Techno', 4, 'Un regard fascinant sur les innovations technologiques.', 32),
('Le Secret de la Montagne', 'Anne Lefèvre', 2018, 300, 'Edition Aventurine', 1, 'Un mystère captivant au sommet des montagnes.', 29),
('Les Couleurs de l Aube', 'Nicolas Fontaine', 2015, 220, 'Edition Lumière', 2, 'Une histoire inspirante sur la résilience.', 19),
('La Cité Disparue', 'Lucie Morel', 2017, 410, 'Edition Mystère', 9, 'Une quête palpitante pour découvrir une cité ancienne.', 33),
('Les Portes du Temps', 'Camille Dubois', 2016, 380, 'Edition Chronos', 3, 'Un voyage épique à travers les âges.', 31),
('L Éveil des Dragons', 'Olivier Lambert', 2021, 290, 'Edition Fantasy', 10, 'Une aventure fantastique peuplée de dragons.', 29),
('L Horizon Infini', 'Hélène Durand', 2020, 270, 'Edition Cosmos', 2, 'Une réflexion poétique sur l infini.', 23),
('La Ville des Ombres', 'Thomas Lefebvre', 2018, 400, 'Edition Thriller', 11, 'Un polar haletant dans une ville obscure.', 34),
('Les Chemins de la Liberté', 'Élodie Martin', 2019, 360, 'Edition Humaniste', 12, 'Une fresque historique sur la quête de liberté.', 30),
('Le Chant des Sirènes', 'Charlotte Garnier', 2017, 250, 'Edition Marine', 13, 'Un roman envoûtant sur les légendes marines.', 28),
('Les Murmures du Vent', 'Pierre Dupuis', 2014, 310, 'Edition Naturel', 1, 'Une exploration poétique des éléments naturels.', 26),
('L Énigme des Sables', 'Victor Morel', 2016, 390, 'Edition Désert', 7, 'Un suspense captivant dans les dunes désertiques.', 33),
('Le Labyrinthe des Souvenirs', 'Sophie Meunier', 2022, 280, 'Edition Mémoire', 14, 'Un voyage introspectif à travers les souvenirs.', 29),
('Les Flammes de l Espoir', 'Amélie Charpentier', 2019, 320, 'Edition Courage', 15, 'Une histoire inspirante de résilience.', 25),
('Le Dernier Oracle', 'Pauline Lefèvre', 2021, 420, 'Edition Prophétie', 4, 'Un thriller ésotérique haletant.', 36),
('La Lumière Cachée', 'Aurélien Garnier', 2018, 350, 'Edition Clairvoyance', 2, 'Un roman mystérieux au cœur d une énigme spirituelle.', 32),
('Les Jardins Suspendus', 'Florian Petit', 2020, 270, 'Edition Écologie', 16, 'Un conte écologique merveilleux.', 21),
('La Mer des Étoiles', 'Claire Lefebvre', 2017, 390, 'Edition Stella', 17, 'Une épopée spatiale fascinante.', 35),
('Les Ombres de la Vérité', 'Juliette Garnier', 2022, 340, 'Edition Évidence', 1, 'Un thriller psychologique captivant.', 30),
('La Montagne Sacrée', 'Nina Duval', 2015, 280, 'Edition Mystique', 18, 'Une aventure spirituelle à travers les sommets.', 28),
('Le Rêve des Étoiles', 'Simon Durand', 2019, 310, 'Edition Onirique', 5, 'Une aventure cosmique au-delà des rêves.', 26),
('Les Secrets de la Lune', 'Alice Moreau', 2021, 360, 'Edition Lunaire', 19, 'Une histoire fantastique sous la lumière lunaire.', 31),
('Le Pouvoir du Vent', 'Antoine Lambert', 2016, 400, 'Edition Éolienne', 6, 'Un roman épique porté par la force du vent.', 33),
('Les Légendes Perdues', 'Marie Fontaine', 2018, 290, 'Edition Mythos', 20, 'Un voyage fascinant à travers des légendes oubliées.', 28),
('L Odeur de la Terre', 'Hugo Morel', 2020, 280, 'Edition Éco', 21, 'Un récit authentique sur le retour à la nature.', 25),
('Le Chant des Brumes', 'Émilie Petit', 2019, 370, 'Edition Mystère', 9, 'Un roman mystérieux enveloppé de brume.', 31),
('Les Pierres du Destin', 'Louis Garnier', 2021, 330, 'Edition Aventure', 10, 'Une quête épique à travers des terres magiques.', 32),
('La Vallée Cachée', 'Marion Lefebvre', 2015, 320, 'Edition Enigma', 22, 'Un thriller captivant dans une vallée isolée.', 29),
('Les Murmures de l Océan', 'Hélène Moreau', 2018, 360, 'Edition Aquatique', 13, 'Une histoire envoûtante sur les mystères de la mer.', 27),
('L Appel de l Aventure', 'Théo Garnier', 2022, 290, 'Edition Exploration', 4, 'Une aventure palpitante à travers des contrées lointaines.', 30),
('La Quête des Origines', 'Camille Lefèvre', 2019, 400, 'Edition Archéologique', 23, 'Un périple fascinant à la recherche des racines humaines.', 35),
('Les Rêves Oubliés', 'Sophie Petit', 2017, 350, 'Edition Mémoire', 14, 'Une quête poétique à travers les rêves perdus.', 29),
('La Flamme Eternelle', 'Aurélie Fontaine', 2021, 310, 'Edition Immortelle', 24, 'Un roman captivant sur l immortalité.', 32),
('Les Contes de la Forêt', 'Julien Garnier', 2020, 280, 'Edition Enchantement', 5, 'Des contes magiques dans une forêt mystérieuse.', 21);

INSERT INTO Exemplaires (id_ouvrage, id_bibliotheque)
VALUES
  (1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
  (6, 2), (7, 2), (8, 2), (9, 2), (10, 2),
  (11, 3), (12, 3), (13, 3), (14, 3), (15, 3),
  (16, 1), (17, 1), (18, 1), (19, 1), (20, 1);

INSERT INTO Participants (id_evenement, id_personne)
VALUES
(1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12), (1, 13),
(2, 14), (2, 15), (2, 16), (2, 17), (2, 18),
(3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24), (3, 25), (3, 26), (3, 27);

INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration) VALUES
-- Réservations pour des abonnés
(1, 26, '2025-02-01', '2025-02-15'),
(2, 27, '2025-02-02', '2025-02-16'),
(3, 28, '2025-02-03', '2025-02-17'),
(4, 29, '2025-02-04', '2025-02-18'),
(5, 30, '2025-02-05', '2025-02-19'),
(6, 11, '2025-02-06', '2025-02-20'),
(7, 12, '2025-02-07', '2025-02-21'),
(8, 13, '2025-02-08', '2025-02-22'),
(9, 14, '2025-02-09', '2025-02-23'),
(10, 15, '2025-02-10', '2025-02-24'),
(11, 16, '2025-02-11', '2025-02-25'),
(12, 17, '2025-02-12', '2025-02-26'),
(13, 18, '2025-02-13', '2025-02-27'),
(14, 19, '2025-02-14', '2025-02-28'),
(15, 20, '2025-02-15', '2025-03-01'),
(16, 21, '2025-02-16', '2025-03-02'),
(17, 22, '2025-02-17', '2025-03-03'),
(18, 23, '2025-02-18', '2025-03-04'),
(19, 24, '2025-02-19', '2025-03-05'),
(20, 25, '2025-02-20', '2025-03-06');

INSERT INTO Interventions (id_personne)
VALUES (46), (47), (48), (49), (50);

INSERT INTO Transferts (id_exemplaire, id_bibliotheque_depart, id_bibliotheque_arrivee, date_demande, date_arrivee)
VALUES
(1, 1, 2, '2023-01-15', '2023-01-20'),
(2, 2, 3, '2023-02-01', '2023-02-06'),
(3, 3, 2, '2023-03-10', '2023-03-15'),
(4, 2, 1, '2023-04-05', '2023-04-10'),
(5, 1, 2, '2023-05-20', '2023-05-25');

INSERT INTO Achats (id_exemplaire, prix, date_achat, fournisseur) VALUES
(1, 100, '2023-01-10', 'Librairie Centrale'),
(2, 150, '2023-02-15', 'Éditions Modernes'),
(3, 200, '2023-03-20', 'Distributeur Alpha'),
(4, 180, '2023-04-25', 'Fournisseur Beta'),
(5, 120, '2023-05-30', 'Librairie des Temps'),
(6, 220, '2023-06-10', 'Éditions Horizon');

INSERT INTO Penalites (nature_infraction, id_pret, id_personne)
VALUES
('Retour tardif', 1, 1),
('Dommage à l ouvrage', 2, 2),
('Perte d ouvrage', 3, 3),
('Non-respect des conditions de prêt', 4, 4);

INSERT INTO Amendes (id_penalite, montant)
VALUES
(1, 50),
(2, 100);

INSERT INTO Amendes_Reglements (id_penalite, date_reglement)
VALUES
(1, '2023-02-15'),
(2, '2023-03-10');

INSERT INTO Banissements_Temporaires (id_penalite, date_debut, date_fin)
VALUES
(3, '2023-04-01', '2023-06-01');

INSERT INTO Banissements (id_penalite, date_debut)
VALUES
(4, '2023-07-01');

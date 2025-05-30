INSERT INTO Bibliotheques (nom_bibliotheque, adresse, code_postal)
VALUES ('Bibliothèque Centrale', '10 rue de Paris',75012),
       ('André Malraux', '6 rue des Colombres', 13008);

INSERT INTO Ouvrages (titre, auteur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES ('Le Livre Exemple', 'Auteur A', 2020, 200, 'Édition 1', 1, 'livre', 15);

-- on insère un exemplaire
INSERT INTO Exemplaires (id_ouvrage, id_bibliotheque) VALUES (1, 1);

-- on créé un abonnement et un abonné
INSERT INTO Abonnements (nombre_livres, prix) VALUES (5, 50);
INSERT INTO Abonnes (id_personne, adresse, code_postal, rib, id_abonnement)
VALUES (1, '10 rue de Test', 75012, 'FR123456789', 1);

-- créer un transfert en cours
INSERT INTO Transferts (id_exemplaire, id_bibliotheque_depart, id_bibliotheque_arrivee, date_demande, date_arrivee)
VALUES (1, 1, 2, '2025-02-01', '2025-02-05');

-- tentative de transfert
INSERT INTO Transferts (id_exemplaire, id_bibliotheque_depart, id_bibliotheque_arrivee, date_demande, date_arrivee)
VALUES (1, 2, 1, '2025-02-06', '2025-02-10');

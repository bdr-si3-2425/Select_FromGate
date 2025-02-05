INSERT INTO Personnes (nom, prenom, email) VALUES ('Jean', 'Dupont', 'jean.dupont@example.com');
INSERT INTO Personnes (nom, prenom, email) VALUES ('Marie', 'Martin', 'marie.martin@example.com');

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays) VALUES ('Bibliothèque Centrale', '10 rue de Paris', 'Paris', 'France');

INSERT INTO Ouvrages (titre, autheur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES ('Le Livre Exemple', 'Auteur A', 2020, 200, 'Édition 1', 1, 'livre', 15);

-- on insère un exemplaire
INSERT INTO Exemplaires (id_ouvrage, id_bibliotheque) VALUES (1, 1);

-- on créé un abonnement et un abonné
INSERT INTO Abonnements (nombre_livres, prix) VALUES (5, 50);
INSERT INTO Abonnes (id_personne, adresse, ville, code_postal, pays, rib, id_abonnement)
VALUES (1, '10 rue de Test', 'Paris', 75000, 'France', 'FR123456789', 1);

-- création du premier prêt
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
VALUES (1, 1, '2025-01-01', NULL);

-- tentative de transfert
INSERT INTO Transferts (id_exemplaire, id_bibliotheque_depart, id_bibliotheque_arrivee, date_demande, date_arrivee)
VALUES (1, 1, 1, '2025-02-01', '2025-02-05');
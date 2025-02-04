-- Insertion d'une personne et d'une bibliothèque
INSERT INTO Personnes (nom, prenom, email) 
VALUES ('Dupont', 'Jean', 'jean.dupont@example.com'),
       ('Martin', 'Alice', 'alice.martin@example.com'),
       ('Durand', 'Bob', 'bob.durand@example.com');

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays) 
VALUES ('Bibliothèque centrale', '1 rue de la Culture', 'Paris', 'France');

-- Création d'un événement avec un maximum de 2 participants
INSERT INTO Evenements (id_personne, id_bibliotheque, theme, nom, date_evenement, nb_max_personne, nb_abonne)
VALUES (1, 1, 'Littérature', 'Soirée Littéraire', '2025-03-15', 2, 0);

-- Ajout des participants
INSERT INTO Participants (id_evenement, id_personne) 
VALUES (1, 1),
       (1, 2),
	   (1, 3);

-- Insertion d'une personne (organisateur) et d'une bibliothèque
INSERT INTO Personnes (nom, prenom, email) 
VALUES ('Durand', 'Claire', 'claire.durand@example.com'),
       ('Martin', 'Alice', 'alice.martin@yahoo.fr');

INSERT INTO Bibliotheques (nom_bibliotheque, adresse, ville, pays) 
VALUES ('Bibliothèque Municipale', '10 rue des Livres', 'Lyon', 'France');

-- Création d'un événement
INSERT INTO Evenements (id_personne, id_bibliotheque, theme, nom, date_evenement, nb_max_personne, nb_abonne)
VALUES (1, 1, 'Culture', 'Atelier d écriture', '2025-06-15', 3, 0);

INSERT INTO Participants (id_evenement, id_personne) 
VALUES (1, 1),
       (1, 2);

-- Alice annule son abonnement
DELETE FROM Participants 
    WHERE id_participation = 2;

-- Affichage du nombre de participants après annulation
SELECT 'Après annulation' AS Etape, nb_abonne 
    FROM Evenements 
    WHERE id_evenement = 1;
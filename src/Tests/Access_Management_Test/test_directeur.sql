SET ROLE directeur;

-- Test 4: Modifier une ligne dans la table Abonnes
UPDATE Abonnes
SET adresse = 'Nouvelle adresse 123'
WHERE id_personne = 1;

-- Test 6: Ajouter la même ligne dans la table Abonnes après suppression
INSERT INTO Abonnes (id_personne, adresse, code_postal, rib, id_abonnement)
VALUES (1, 'Nouvelle adresse 123', 13008, 'RIB123456', 1);

-- Test 7: Modifier une ligne dans la table Bibliotheques
UPDATE Bibliotheques
SET nom_bibliotheque = 'Nouvelle Bibliothèque'
WHERE id_bibliotheque = 1;

-- Test 9: Ajouter la même ligne dans la table Bibliotheques après suppression
INSERT INTO Bibliotheques (nom_bibliotheque, adresse, code_postal)
VALUES ('Nouvelle Bibliothèque', '1 Rue de la Bibliothèque', 13008);

-- Test 10: Modifier une ligne dans la table Evenements
UPDATE Evenements
SET theme = 'Nouveau thème'
WHERE id_evenement = 1;

-- Test 12: Ajouter la même ligne dans la table Evenements après suppression
INSERT INTO Evenements (id_personne, id_bibliotheque, theme, nom, date_evenement, nb_max_personne, nb_abonne)
VALUES (1, 1, 'Nouveau thème', 'Nouvel événement', '2025-03-01', 100, 10);

-- Test 13: Modifier une ligne dans la table Collections
UPDATE Collections
SET nom_collection = 'Nouvelle collection'
WHERE id_collection = 1;

-- Test 15: Ajouter la même ligne dans la table Collections après suppression
INSERT INTO Collections (nom_collection)
VALUES ('Nouvelle collection');

-- Test 16: Modifier une ligne dans la table Ouvrages
UPDATE Ouvrages
SET titre = 'Nouveau Titre'
WHERE id_ouvrage = 1;


-- Test 18: Ajouter la même ligne dans la table Ouvrages après suppression
INSERT INTO Ouvrages (titre, auteur, annee, nb_pages, edition, id_collection, resume, prix)
VALUES ('Nouveau Titre', 'Auteur X', 2025, 300, 'Édition Y', 1, 'Résumé du livre', 20);

-- Test 19: Modifier une ligne dans la table Exemplaires
UPDATE Exemplaires
SET id_bibliotheque = 2
WHERE id_exemplaire = 1;

-- Test 21: Ajouter la même ligne dans la table Exemplaires après suppression
INSERT INTO Exemplaires (id_ouvrage, id_bibliotheque)
VALUES (1, 2);

-- Test 22: Modifier une ligne dans la table Participants
UPDATE Participants
SET id_personne = 2
WHERE id_participation = 1;

-- Test 24: Ajouter la même ligne dans la table Participants après suppression
INSERT INTO Participants (id_evenement, id_personne)
VALUES (1, 2);

-- Test 25: Modifier une ligne dans la table Reservations
UPDATE Reservations
SET date_expiration = '2025-04-01'
WHERE id_reservation = 1;

-- Test 27: Ajouter la même ligne dans la table Reservations après suppression
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
VALUES (1, 1, '2025-02-05', '2025-03-01');

-- Test 28: Modifier une ligne dans la table Prets
UPDATE Prets
SET date_fin = '2025-06-01'
WHERE id_pret = 1;

-- Test 30: Ajouter la même ligne dans la table Prets après suppression
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin, retard)
VALUES (1, 1, '2025-01-01', '2025-06-01', 0);

-- Test 29: Supprimer une ligne dans la table Prets
DELETE FROM Prets
WHERE id_pret = 1;

-- Test 26: Supprimer une ligne dans la table Reservations
DELETE FROM Reservations
WHERE id_reservation = 1;

-- Test 17: Supprimer une ligne dans la table Ouvrages
DELETE FROM Ouvrages
WHERE id_ouvrage = 1;

-- Test 20: Supprimer une ligne dans la table Exemplaires
DELETE FROM Exemplaires
WHERE id_exemplaire = 1;

-- Test 23: Supprimer une ligne dans la table Participants
DELETE FROM Participants
WHERE id_participation = 1;

-- Test 11: Supprimer une ligne dans la table Evenements
DELETE FROM Evenements
WHERE id_evenement = 1;

-- Test 14: Supprimer une ligne dans la table Collections
DELETE FROM Collections
WHERE id_collection = 1;

-- Test 5: Supprimer une ligne dans la table Abonnes
DELETE FROM Abonnes
WHERE id_personne = 1;

-- Test 8: Supprimer une ligne dans la table Bibliotheques
DELETE FROM Bibliotheques
WHERE id_bibliotheque = 1;

RESET ROLE
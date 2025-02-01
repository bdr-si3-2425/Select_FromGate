-- Test 1 : Insertion d’un prêt sans date_debut ni date_fin
/*
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (3, 11);
SELECT * FROM Prets WHERE id_abonne = 11;
*/


-- Test 2 : Insertion d’un prêt sur un exemplaire déjà emprunté sur la même période
/*
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (3, 11);
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin) VALUES (3, 12);
*/


-- Test 3 : Insertion d’un prêt sur un exemplaire qui est réservé
/*
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 11, CURRENT_DATE, CURRENT_DATE + INTERVAL '7 days');

INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');
*/


-- Test 4 : Vérification du nombre maximum de livres empruntés (L'abonné(e) 11 a un abonnement permettant le prêt d'un livre)
/*
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (3, 11);
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (5, 11);
*/


-- Test 5 : Abonné temporairement banni

/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Retard', 1, 12);
INSERT INTO Banissements_Temporaires (id_penalite, date_debut, date_fin) VALUES (1, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day');
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (6, 12);
*/


-- Test 6 : Abonné définitivement banni
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Fraude', 1, 13);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (1, 13);
*/

-- Test 7 : Insertion d'une réservation avec une durée incorrecte (Modifie pour la bonne valeur +14j)
/*
INSERT INTO Prets (id_exemplaire, id_abonne, date_fin)
VALUES (2, 12, CURRENT_DATE + INTERVAL '10 days');
SELECT * FROM Prets;
*/


--Test 8 : Insertion d'une réservation qui chevauche une réservation existante
/*
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
VALUES (1, 12, CURRENT_DATE + INTERVAL '8 days', CURRENT_DATE + INTERVAL '30 days');

INSERT INTO Prets (id_exemplaire, id_abonne, date_fin)
VALUES (1, 12, CURRENT_DATE + INTERVAL '14 days');
*/

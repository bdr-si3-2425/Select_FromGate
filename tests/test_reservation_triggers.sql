-- Test 1 : Reservation de la part d'une personne non-abbonnée
/*
INSERT INTO Reservations (id_exemplaire, id_personne) VALUES (3, 1);
*/


-- Test 2 : Reservation d'un exemplaire déjà reservé
/*
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation, date_expiration)
	VALUES (4, 11, CURRENT_DATE, CURRENT_DATE + INTERVAL '7 days');

INSERT INTO Reservations (id_exemplaire, id_abonne, date_debut, date_fin)
	VALUES (4, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');
*/


-- Test 3 : Abonné temporairement banni
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Retard', 1, 12);
INSERT INTO Banissements_Temporaires (id_penalite, date_debut, date_fin) VALUES (1, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day');
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (6, 12);
*/


-- Test 4 : Abonné définitivement banni)
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Fraude', 1, 13);
INSERT INTO Banissements (id_penalite, date_debut) VALUES (1, CURRENT_DATE - INTERVAL '1 day');
INSERT INTO Reservations (id_exemplaire, id_abonne) VALUES (1, 13);
*/


-- Test 5: Abonné n'ayant pas encore rêglé son amende
/*
INSERT INTO Penalites (nature_infraction, id_pret, id_personne) VALUES ('Amende', 1, 13);
INSERT INTO Amendes (id_penalite, montant) VALUES (1, 25);
INSERT INTO Prets (id_exemplaire, id_abonne) VALUES (1, 13);
*/


-- Test 6 : Insertion d'un prêt avec une date de début incorrecte
/*
INSERT INTO Prets (id_exemplaire, id_abonne, date_fin)
VALUES (2, 12, CURRENT_DATE - INTERVAL '10 days');
*/

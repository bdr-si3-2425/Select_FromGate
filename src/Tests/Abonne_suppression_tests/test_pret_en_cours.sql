-- Test 1 : Abonné avec prêt en cours (doit échouer)

INSERT INTO Prets (id_exemplaire, id_abonne, id_bibliotheque, date_debut, date_fin, retard)
VALUES (3, 11, 1, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '10 days', 0);

DELETE FROM Abonnes WHERE id_personne = 11;

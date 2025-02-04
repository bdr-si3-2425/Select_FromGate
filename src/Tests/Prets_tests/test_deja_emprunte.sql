-- Prêt sur exemplaire déjà emprunté
DELETE FROM Prets WHERE id_exemplaire = 3 AND id_abonne IN (11, 12);

-- Premier prêt pour l'exemplaire 3 (abonné 11)
INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (3, 11);

-- Tentative d'insertion pour l'exemplaire 3 (abonné 12) : devrait lever une exception 
INSERT INTO Prets (id_exemplaire, id_abonne, date_debut, date_fin)
VALUES (3, 12, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month');

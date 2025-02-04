-- Insertion d’un prêt sans date_debut ni date de fin
DELETE FROM Prets WHERE id_abonne = 11;

INSERT INTO Prets (id_exemplaire, id_abonne)
VALUES (3, 11);

-- Vérifie que les dates ont été corrigées par le trigger :
SELECT * FROM Prets WHERE id_abonne = 11;

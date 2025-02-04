CREATE OR REPLACE VIEW Penalites_Abonnes AS
SELECT p.*
FROM Penalites p
WHERE p.id_personne = (SELECT id_personne FROM Personnes where email = CURRENT_USER);

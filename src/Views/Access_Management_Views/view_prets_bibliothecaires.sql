CREATE OR REPLACE VIEW Vue_Prets_Bibliothecaires AS
SELECT p.*
FROM Prets p
JOIN Exemplaires e ON p.id_exemplaire = e.id_exemplaire
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Personnels per ON b.id_bibliotheque = per.id_bibliotheque
WHERE per.id_personne = (Select id_personne FROM personne where email = CURRENT_USER);

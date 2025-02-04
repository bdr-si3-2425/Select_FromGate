CREATE VIEW Abonnes_Exemplaires AS
SELECT e.id_exemplaire, e.id_ouvrage, e.id_bibliotheque
FROM Exemplaires e
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Abonnes a ON a.code_postal = b.code_postal;
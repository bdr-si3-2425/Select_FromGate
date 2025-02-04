CREATE VIEW Vue_Bibliotheques_Bibliothecaires AS
SELECT DISTINCT b.*
FROM Bibliotheques b
JOIN Personnels p ON b.id_bibliotheque = p.id_bibliotheque;

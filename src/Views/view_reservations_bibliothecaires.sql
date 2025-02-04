CREATE VIEW Vue_Reservations_Bibliothecaires AS
SELECT r.*
FROM Reservations r
JOIN Exemplaires e ON r.id_exemplaire = e.id_exemplaire
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Personnels p ON p.id_bibliotheque = b.id_bibliotheque;
CREATE VIEW Abonnes_Exemplaires AS
SELECT e.id_exemplaire, e.id_ouvrage, e.id_bibliotheque
FROM Exemplaires e
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Abonnes a ON a.code_postal = b.code_postal;

CREATE VIEW Vue_Bibliotheques_Bibliothecaires AS
SELECT DISTINCT b.*
FROM Bibliotheques b
JOIN Personnels p ON b.id_bibliotheque = p.id_bibliotheque;

CREATE OR REPLACE VIEW Penalites_Abonnes AS
SELECT p.*
FROM Penalites p
WHERE p.id_personne = (SELECT id_personne FROM Personnes where email = CURRENT_USER);

CREATE OR REPLACE VIEW Vue_Prets_Bibliothecaires AS
SELECT p.*
FROM Prets p
JOIN Exemplaires e ON p.id_exemplaire = e.id_exemplaire
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Personnels per ON b.id_bibliotheque = per.id_bibliotheque
WHERE per.id_personne = (Select id_personne FROM Personnes where email = CURRENT_USER);

CREATE VIEW Vue_Reservations_Bibliothecaires AS
SELECT r.*
FROM Reservations r
JOIN Exemplaires e ON r.id_exemplaire = e.id_exemplaire
JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
JOIN Personnels p ON p.id_bibliotheque = b.id_bibliotheque;

CREATE OR REPLACE VIEW Ouvrages_Frequemment_Transferes AS
SELECT
    o.id_ouvrage,
    o.titre,
    o.auteur,
    o.annee,
    t.id_transfert,
    t.date_demande,
    t.date_arrivee,
    EXTRACT(EPOCH FROM (t.date_arrivee::timestamp - t.date_demande::timestamp)) / 86400 AS temps_transfert_jours
FROM
    Ouvrages o
JOIN
    Exemplaires e ON o.id_ouvrage = e.id_ouvrage
JOIN
    Transferts t ON e.id_exemplaire = t.id_exemplaire
ORDER BY
    t.date_arrivee DESC;
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
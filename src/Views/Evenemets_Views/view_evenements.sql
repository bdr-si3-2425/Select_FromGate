CREATE VIEW Bibliotheques_Evenements AS
    SELECT id_evenement, id_bibliotheque
    FROM Evenements
    JOIN Bibliotheques USING(id_bibliotheque)
    ORDER BY id_bibliotheque;


CREATE VIEW Personnes_Participant_Evenement_Same_Theme AS
    SELECT theme, id_abonne
    FROM Participants p
    JOIN Evenements USING (id_evenement)
    ORDER BY theme, id_bibliotheque;


-- Pour tester :
/*
TODO : ..
*/
CREATE TRIGGER verif_emprun
BEFORE INSERT ON Prets
FOR EACH ROW
BEGIN 
    IF EXISTS (
        SELECT 1 FROM Prets 
        WHERE id_exemplaire = NEW.id_exemplaire 
        AND NEW.date_debut <= date_fin
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ouvrage est déjà emprunté sur cette période";
    END IF;
END;
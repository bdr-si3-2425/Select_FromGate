CREATE TRIGGER verif_book_borrowed_emprun
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

CREATE TRIGGER verif_book_reserved_prolongation
BEFORE UPDATE ON Prets
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Reservation AS r 
        WHERE r.id_exemplaire = NEW.id_exemplaire
        AND r.date_expiration >= CURDATE()
        AND NEW.date_fin >= r.date_debut
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ouvrage est réservé";
    END IF;
END;

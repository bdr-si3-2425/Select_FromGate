CREATE TRIGGER verif_book_borrowed_emprun
BEFORE INSERT ON Prets
FOR EACH ROW
BEGIN 
    -- Vérifier si l'exemplaire n'est pas déjà emprunté sur la période demandée
    IF EXISTS (
        SELECT 1 FROM Prets 
        WHERE id_exemplaire = NEW.id_exemplaire 
        AND NEW.date_debut <= date_fin 
        AND NEW.date_fin >= date_debut
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ouvrage est déjà emprunté sur cette période";
    END IF;

    -- Vérifier si l'abonné(e) n'a pas atteint son maximum de livres empruntés
    IF (
        (SELECT abnmt.nombre_livres 
         FROM Abonnes AS abe 
         JOIN Abonnements AS abnmt ON abe.id_abonnement = abnmt.id_abonnement 
         WHERE abe.id_personne = NEW.id_abonne
        ) <= 
        (SELECT COUNT(*) 
         FROM Prets AS p 
         WHERE p.id_abonne = NEW.id_abonne 
         AND p.date_fin >= CURDATE() -- Livres non encore rendus
        )
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'abonné(e) a déjà atteint le maximum de livres empruntables permis par son abonnement";
    END IF;

    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement temporaire)
    IF EXISTS (
        SELECT 1 
        FROM Penalites AS p 
        JOIN Banissements_Temporaires AS bt ON bt.id_penalite = p.id_penalite 
        WHERE p.id_personne = NEW.id_abonne
        AND bt.date_debut <= CURDATE() 
        AND bt.date_fin >= CURDATE()
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'abonné(e) est banni temporairement";
    END IF;
    
    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement définitif)
    IF EXISTS (
        SELECT 1 
        FROM Penalites AS p 
        JOIN Banissements AS b ON b.id_penalite = p.id_penalite 
        WHERE p.id_personne = NEW.id_abonne
        AND b.date_debut <= CURDATE()
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'abonné(e) est banni définitivement";
    END IF;
END;


CREATE TRIGGER verif_book_reserved_prolongation
BEFORE UPDATE ON Prets
FOR EACH ROW
BEGIN

	-- Verifier si le livre n'est pas reservé sur la période de prolongation
    IF EXISTS (
        SELECT 1 FROM Reservation AS r 
        WHERE r.id_exemplaire = NEW.id_exemplaire
        AND r.date_expiration >= CURDATE()
        AND NEW.date_fin >= r.date_debut
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ouvrage est réservé";
    END IF;

	-- Vérifier que l'abonné(e) n'a pas atteint sa limite de renouvellement (3 fois max)
    IF NEW.compteur_renouvellement > 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'abonné(e) a déjà consommé ses 3 renouvellements sur ce prêt";
    END IF;
END;

CREATE OR REPLACE FUNCTION check_exemplaire_disponibilite()
RETURNS TRIGGER AS $$
DECLARE
    pret_count INT;
    transfert_count INT;
BEGIN
    -- on vérifie si l'exemplaire est prêté
    SELECT COUNT(*)
        INTO pret_count
        FROM Prets
        WHERE id_exemplaire = NEW.id_exemplaire
        AND date_fin IS NULL;

    IF pret_count > 0 THEN
        RAISE EXCEPTION 'L exemplaire % est actuellement prêté, transfert impossible.', NEW.id_exemplaire;
    END IF;

    -- on vérifie si l'exemplaire est déjà en transfert
    SELECT COUNT(*)
        INTO transfert_count
        FROM Transferts
        WHERE id_exemplaire = NEW.id_exemplaire
        AND date_arrivee IS NULL;

    IF transfert_count > 0 THEN
        RAISE EXCEPTION 'L exemplaire % est déjà en transfert, opération impossible.', NEW.id_exemplaire;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

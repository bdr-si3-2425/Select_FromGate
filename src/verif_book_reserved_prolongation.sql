CREATE OR REPLACE FUNCTION verif_book_reserved_prolongation_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier que la prolongation dure bien 2 semaines et corriger si besoin
    IF (NEW.date_fin != (NEW.date_debut + INTERVAL '14 days')) THEN
        NEW.date_fin := NEW.date_debut + INTERVAL '14 days';
END IF;

    -- Vérifier si le livre n'est pas réservé sur la période de prolongation
    IF EXISTS (
        SELECT 1
        FROM Reservation AS r
        WHERE r.id_exemplaire = NEW.id_exemplaire
        AND r.date_expiration >= CURRENT_DATE
        AND NEW.date_fin >= r.date_debut
    ) THEN
        RAISE EXCEPTION 'L''ouvrage est réservé';
END IF;

    -- Vérifier que l'abonné(e) n'a pas atteint sa limite de renouvellement (3 fois max)
    IF NEW.compteur_renouvellement > 3 THEN
        RAISE EXCEPTION 'L''abonné(e) a déjà consommé ses 3 renouvellements sur ce prêt';
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

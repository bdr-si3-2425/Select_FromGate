CREATE OR REPLACE FUNCTION verif_pret_prolongation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier que la date de renouvellement est instanciée
    IF (NEW.date_renouvellement IS NULL) THEN
        NEW.date_renouvellement = CURRENT_DATE;
	END IF;

	-- Vérifier que la date de fin est instanciée
    IF (NEW.date_fin IS NULL) THEN
        NEW.date_fin := CURRENT_DATE + INTERVAL '14 days';
	END IF;

    -- Vérifier si le livre n'est pas réservé sur la période de prolongation
    IF EXISTS (
        SELECT 1
        FROM Prets AS p
        JOIN Reservations AS r ON r.id_exemplaire = p.id_exemplaire
        WHERE NEW.id_pret = p.id_pret
        AND r.date_expiration >= NEW.date_renouvellement
        AND NEW.date_fin >= r.date_reservation
    ) THEN
        RAISE EXCEPTION 'L''ouvrage est réservé';
	END IF;

    -- Vérifier que l'abonné(e) n'a pas atteint sa limite de renouvellement (3 fois max)
    IF (SELECT COUNT(*) FROM Prets_Renouvellements WHERE id_pret = NEW.id_pret) > 3 THEN
        RAISE EXCEPTION 'L''abonné(e) a déjà consommé ses 3 renouvellements sur ce prêt';
	END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

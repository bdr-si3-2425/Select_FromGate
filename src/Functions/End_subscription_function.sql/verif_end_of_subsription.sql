CREATE OR REPLACE FUNCTION verif_end_of_subsription_fn()
RETURNS TRIGGER AS $$
BEGIN

	-- Vérifier que l'abonné(e) n'as pas de prêts en cours
    IF EXISTS (
		SELECT 1 FROM Prets 
		WHERE OLD.id_personne = id_abonne 
		AND (date_fin + INTERVAL '1 day' * retard) > CURRENT_DATE 
	) THEN 
		RAISE EXCEPTION 'L''abonné(e) a un prêt en cours, il ne peut donc pas résilier son abonnement'; 
	END IF;


	-- On retire les réservation en cours/futures de l'abonné(e)
	DELETE FROM Reservations
	WHERE id_abonne = OLD.id_personne
	AND date_expiration >= CURRENT_DATE;
	
RETURN NEW;
END;
$$ LANGUAGE plpgsql;






	
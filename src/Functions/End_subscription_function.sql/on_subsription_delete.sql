-- Vérifie la possibilité de résiliation de l'abonnement
CREATE OR REPLACE FUNCTION _verif_pret_before_subsription_delete_fn(abonnement Abonnements)
RETURNS VOID AS $$
BEGIN
	-- Vérifie que l'abonné(e) n'as pas de prêts en cours
    IF EXISTS (
		SELECT 1
		FROM Prets AS pret
		WHERE abonnement.id_personne = pret.id_abonne
		AND (pret.date_fin + INTERVAL '1 day' * pret.retard) > CURRENT_DATE
	) THEN
		RAISE EXCEPTION 'L''abonné(e) a un prêt en cours, il ne peut donc pas résilier son abonnement';
	END IF;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Main Function :
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION on_subsription_delete_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Appel des fonctions de validation en leur passant la ligne OLD
	PERFORM _verif_pret_before_subsription_delete_fn(OLD)

	-- On retire les réservation en cours/futures de l'abonné(e)
	DELETE FROM Reservations
	WHERE id_abonne = OLD.id_personne
	AND date_expiration >= CURRENT_DATE;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
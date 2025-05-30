CREATE OR REPLACE FUNCTION verif_pret_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
	-- Vérifier que la date de début existe et corriger si besoin
    IF (NEW.date_debut IS NULL) THEN
        NEW.date_debut = CURRENT_DATE;
	END IF;

    -- Vérifier que l'emprunt dure bien 1 mois et corriger si besoin
    IF (NEW.date_fin != NEW.date_debut + INTERVAL '1 month' OR NEW.date_fin IS NULL) THEN
        NEW.date_fin := NEW.date_debut + INTERVAL '1 month';
	END IF;

	-- Vérifier le nombre de renouvellement est bien renseigné
    IF (NEW.retard IS NULL) THEN
        NEW.retard = 0;
	END IF;

	-- Vérifier que l'examplaire est dans la bibliotheque de l'abonné(e)
	IF NOT EXISTS (
	    SELECT 1
	    FROM Exemplaires AS e
	    JOIN Abonnes AS a ON a.id_bibliotheque = e.id_bibliotheque
	    WHERE e.id_exemplaire = NEW.id_exemplaire
	    AND a.id_personne = NEW.id_abonne
	) THEN 
    	RAISE EXCEPTION 'L''ouvrage est présent dans une autre bibliotheque';
	END IF;

		
    -- Vérifier si l'exemplaire n'est pas déjà emprunté sur la période demandée
    IF (
    EXISTS (
            SELECT 1
            FROM Prets
            WHERE id_exemplaire = NEW.id_exemplaire
            AND NEW.date_debut <= date_fin
            AND NEW.date_fin >= date_debut
        ) OR EXISTS (
            SELECT 1
            FROM Prets AS p
            JOIN (
                SELECT id_pret, MAX(date_fin) AS last_date_fin
                FROM Prets_Renouvellements
                GROUP BY id_pret
            ) AS pr ON pr.id_pret = p.id_pret
            WHERE p.id_exemplaire = NEW.id_exemplaire
            AND NEW.date_debut <= pr.last_date_fin
            AND NEW.date_fin >= p.date_debut
        )
    ) THEN
    	RAISE EXCEPTION 'L''ouvrage est déjà emprunté sur cette période';
	END IF;


    -- Vérifier si l'exemplaire n'est pas déjà réservé sur la période demandée
    IF (
    EXISTS (
            SELECT 1
            FROM Reservations AS r
            WHERE r.id_exemplaire = NEW.id_exemplaire
            AND NEW.date_debut <= r.date_expiration
            AND NEW.date_fin >= r.date_reservation
        )
    ) THEN
    	RAISE EXCEPTION 'L''ouvrage est déjà réservé sur cette période';
	END IF;



    -- Vérifier si l'abonné(e) n'a pas atteint son maximum de livres empruntés
    IF (
        (
            SELECT abnmt.nombre_livres
            FROM Abonnes AS abe
            JOIN Abonnements AS abnmt ON abe.id_abonnement = abnmt.id_abonnement
            WHERE abe.id_personne = NEW.id_abonne
        ) <= (
            SELECT COUNT(*)
            FROM Prets AS p
            WHERE p.id_abonne = NEW.id_abonne
            AND p.date_fin >= CURRENT_DATE -- Livres non encore rendus
        )
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) a déjà atteint le maximum de livres empruntables permis par son abonnement';
    END IF;

    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement temporaire)
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements_Temporaires AS bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND bt.date_debut <= CURRENT_DATE
        AND bt.date_fin >= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) est banni temporairement';
    END IF;

    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement définitif)
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements AS b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND b.date_debut <= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) est banni définitivement';
    END IF;

	-- Vérifie que l'abonné(e) n'ait pas d'amende impayée :
	IF EXISTS (
	    SELECT 1
	    FROM Penalites p
	    JOIN Amendes am ON am.id_penalite = p.id_penalite
	    WHERE p.id_personne = NEW.id_abonne
	    AND am.id_penalite NOT IN (SELECT id_penalite FROM Amendes_Reglements)
	) THEN
	    RAISE EXCEPTION 'L''abonné(e) n''a pas encore réglé ses amendes';
    END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

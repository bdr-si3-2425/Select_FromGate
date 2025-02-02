CREATE OR REPLACE FUNCTION _verif_personne_reservation_ability_fn()
RETURNS TRIGGER AS $$
BEGIN

    -- Vérifie que la personne soit bien abonnée :
    IF NOT EXISTS (
        SELECT 1
        FROM Abonnes AS ab
        WHERE ab.id_personne = NEW.id_abonne
    ) THEN
        RAISE EXCEPTION "Seul un abonné peut réaliser une reservation";
    END IF;

    -- Vérifie que l'abonné n'ait pas était banni définitivement :
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements AS b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
    ) THEN
        RAISE EXCEPTION "L'abonné est banni définitevement";
    END IF;

    -- Vérifier que l'abonné n'ait pas était banni temporairement :
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Banissements_Temporaires AS bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND bt.date_debut <= CURRENT_DATE
        AND CURRENT_DATE <= bt.date_fin
    ) THEN
        RAISE EXCEPTION "L'abonné est banni temporairement";
    END IF;

    -- Vérifier que l'abonné n'ait pas d'amendes impayées :
    IF EXISTS (
        SELECT 1
        FROM Penalites AS p
        JOIN Amendes AS am ON am.id_penalite = p.id_penalite
        WHERE p.id_personne = NEW.id_abonne
        AND am.id_penalite NOT IN(SELECT id_penalite FROM Amendes_Reglements)
    ) THEN
        RAISE EXCEPTION "L'abonné a des amendes impayées";
    END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION _verif_reservation_validity_fn()
RETURNS TRIGGER AS $$
BEGIN

    -- Vérifier si le livre n'est pas reservé bcp trop tôt (plus de 1.5 mois)
    IF (NEW.date_reservation > (CURRENT_DATE + INTERVAL '1 month 15 days')) THEN
        RAISE EXCEPTION "Un exemplaire ne peut être réservé plus d'un mois et demi à l'avance";
    END IF;

    -- Vérifier si le livre n'a pas déjà était reservé
    IF EXISTS (
        SELECT 1
        FROM Reservation AS r
        WHERE r.id_exemplaire = NEW.id_exemplaire
    ) THEN
        RAISE EXCEPTION "L'exemplaire a déjà était reservé";
    END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;



--------------------------------------------------------------------------------
-- MAIN FUNCTION :
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verif_reservation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN

    IF (NEW.date_reservation IS NULL) THEN
        NEW.date_reservation = CURRENT_DATE;
    ELSIF (NEW.date_reservation < CURRENT_DATE) THEN
        RAISE EXCEPTION "Date de reservation erronée";
	END IF;

    IF (NEW.date_fin IS NULL) THEN
        NEW.date_fin := NEW.date_debut + INTERVAL '2 weeks';
	END IF;

    -- TODO : Lever un exception si la date de fin est trop loin une fois que l'on connaîtra la durée max d'une reservation 

    EXECUTE _verif_personne_reservation_ability_fn();
    EXECUTE _verif_reservation_validity_fn();
    USING NEW;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

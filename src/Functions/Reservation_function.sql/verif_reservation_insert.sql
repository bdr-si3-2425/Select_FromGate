-- Vérifie la capacité de la personne à faire une réservation
CREATE OR REPLACE FUNCTION _verif_personne_reservation_ability(rec Reservations)
RETURNS VOID AS $$
BEGIN
    -- Vérifie que la personne soit bien abonnée :
    IF (rec.id_abonne NOT IN (SELECT id_personne FROM Abonnes)) THEN
        RAISE EXCEPTION 'Seul un abonné peut réaliser une reservation';
    END IF;

    -- Vérifie que l'abonné n'ait pas été banni définitivement :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Banissements b ON b.id_penalite = p.id_penalite
        WHERE p.id_personne = rec.id_abonne
    ) THEN
        RAISE EXCEPTION 'L''abonné est banni définitivement';
    END IF;

    -- Vérifie que l'abonné n'ait pas été banni temporairement :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Banissements_Temporaires bt ON bt.id_penalite = p.id_penalite
        WHERE p.id_personne = rec.id_abonne
          AND bt.date_debut <= CURRENT_DATE
          AND CURRENT_DATE <= bt.date_fin
    ) THEN
        RAISE EXCEPTION 'L''abonné est banni temporairement';
    END IF;

    -- Vérifier que l'abonné n'ait pas d'amendes impayées :
    IF EXISTS (
        SELECT 1
        FROM Penalites p
        JOIN Amendes am ON am.id_penalite = p.id_penalite
        WHERE p.id_personne = rec.id_abonne
          AND am.id_penalite NOT IN (SELECT id_penalite FROM Amendes_Reglements)
    ) THEN
        RAISE EXCEPTION 'L''abonné a des amendes impayées';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Vérifie la validité de la réservation
CREATE OR REPLACE FUNCTION _verif_reservation_validity(rec Reservations)
RETURNS VOID AS $$
BEGIN
    -- Vérifie que la date de réservation ne soit pas trop éloignée (plus de 1,5 mois à l'avance)
    IF (rec.date_reservation > (CURRENT_DATE + INTERVAL '1 month 15 days')) THEN
        RAISE EXCEPTION 'Un exemplaire ne peut être réservé plus d''un mois et demi à l''avance';
    END IF;

    -- Vérifie que l'exemplaire n'ait pas déjà été réservé
    IF EXISTS (
        SELECT 1
        FROM Reservations r
        WHERE r.id_exemplaire = rec.id_exemplaire
    ) THEN
        RAISE EXCEPTION 'L''exemplaire a déjà été réservé';
    END IF;
END;
$$ LANGUAGE plpgsql;


--------------------------------------------------------------------------------
-- Main Function :
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verif_reservation_insert_fn()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérification et réglage de la date de réservation
    IF (NEW.date_reservation IS NULL) THEN
        NEW.date_reservation := CURRENT_DATE;
    ELSIF (NEW.date_reservation < CURRENT_DATE) THEN
        RAISE EXCEPTION 'Date de reservation erronée';
    END IF;

    -- Si la date d'expiration n'est pas définie, on la fixe à 2 semaines après la date de début
    IF (NEW.date_expiration IS NULL) THEN
        NEW.date_expiration := NEW.date_reservation + INTERVAL '2 weeks';
    END IF;

    -- TODO : Lever une exception si la date de fin est trop éloignée une fois que la durée max d'une reservation est connue

    -- Appel des fonctions de validation en leur passant la ligne NEW
    PERFORM _verif_personne_reservation_ability(NEW);
    PERFORM _verif_reservation_validity(NEW);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

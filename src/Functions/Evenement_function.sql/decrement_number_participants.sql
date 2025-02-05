CREATE OR REPLACE FUNCTION decrement_number_participant()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Evenements
        SET nb_abonne = nb_abonne - 1
        WHERE id_evenement = OLD.id_evenement;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

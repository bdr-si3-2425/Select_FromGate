CREATE OR REPLACE FUNCTION maximum_participants_event()
RETURNS TRIGGER AS $$
DECLARE current_count INT;
		max_count INT;
BEGIN

    -- Compter le nombre de participants inscrits pour l'event
    SELECT COUNT(*)
      INTO current_count
      FROM Participants
     WHERE id_evenement = NEW.id_evenement;

    -- Récupérer le nombre maximum de participants autorisés pour cet event
    SELECT nb_max_personne
      INTO max_count
      FROM Evenements
     WHERE id_evenement = NEW.id_evenement;

    -- Vérifier que le nombre de participants est inférieur au maximum autorisé
    IF current_count >= max_count THEN
        RAISE EXCEPTION 'Nombre maximum de participants atteint pour cet événement';
    END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;
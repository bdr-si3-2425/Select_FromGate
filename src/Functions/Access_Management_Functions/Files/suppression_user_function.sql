-- Création de la fonction qui supprime l'utilisateur et ses objets
CREATE OR REPLACE FUNCTION supprimer_personne_trigger()
RETURNS TRIGGER AS $$
DECLARE
    user_email TEXT;
BEGIN
    -- Récupérer l'email de la personne (qui est aussi le nom du user)
    SELECT email INTO user_email FROM Personnes WHERE id_personne = OLD.id_personne;

    -- Supprimer les objets possédés par l'utilisateur (permissions, vues, ...)
    EXECUTE format('DROP OWNED BY %I CASCADE', user_email);

    -- Supprimer l'utilisateur
    EXECUTE format('DROP USER IF EXISTS %I', user_email);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

Select supprimer_personne_trigger()

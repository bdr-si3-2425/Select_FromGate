-- Fonction pour créer un utilisateur à l'ajout d'une personne
CREATE OR REPLACE FUNCTION add_user()
RETURNS TRIGGER AS $$
DECLARE
    username TEXT;
BEGIN

    username := NEW.email;
    EXECUTE format('CREATE USER %I LOGIN PASSWORD %L', username, 'MotDePasseParDefaut');
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

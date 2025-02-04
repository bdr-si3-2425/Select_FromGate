-- Fonction pour modifier le username si l'email est mis à jour
CREATE OR REPLACE FUNCTION update_user()
RETURNS TRIGGER AS $$
DECLARE
    old_username TEXT;
    new_username TEXT;
BEGIN
    IF OLD.email <> NEW.email THEN
        old_username := OLD.email;
        new_username := NEW.email;
        EXECUTE format('ALTER ROLE %I RENAME TO %I', old_username, new_username);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

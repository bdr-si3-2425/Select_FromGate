
-- SUPPRESSION --

-- Create a function that drop all the tables of the database
CREATE OR REPLACE FUNCTION drop_all_tables()
RETURNS VOID AS $$ 
DECLARE
    r RECORD;
BEGIN
    -- Pour chaque table dans la base
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        -- Génère et exécute un DROP pour chaque table
        EXECUTE 'DROP TABLE IF EXISTS public.' || r.tablename || ' CASCADE';
    END LOOP;
END
$$ LANGUAGE plpgsql;



-- Create a function that drop all the triggers of the database
CREATE OR REPLACE FUNCTION drop_all_triggers()
RETURNS VOID AS $$
DECLARE
    r RECORD;
BEGIN
    -- Pour chaque trigger dans la base de données
    FOR r IN (SELECT tgname, tgrelid::regclass::text AS table_name
              FROM pg_trigger
              WHERE NOT tgisinternal) 
    LOOP
        -- Génère et exécute le DROP TRIGGER pour chaque trigger
        EXECUTE 'DROP TRIGGER IF EXISTS ' || r.tgname || ' ON ' || r.table_name;
    END LOOP;
END 
$$ LANGUAGE plpgsql;



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



CREATE OR REPLACE FUNCTION retirer_role_trigger()
RETURNS TRIGGER AS $$
DECLARE
    user_email TEXT;
    role_to_remove TEXT;
BEGIN
    -- Récupérer l'email de la personne supprimée
    SELECT email INTO user_email FROM Personnes WHERE id_personne = OLD.id_personne;

    -- Déterminer le rôle associé à la table
    IF TG_TABLE_NAME = 'Clients' THEN
        role_to_remove := 'client';
    ELSIF TG_TABLE_NAME = 'Abonnes' THEN
        role_to_remove := 'abonne';
    ELSIF TG_TABLE_NAME = 'Personnels' THEN
        role_to_remove := 'personnel';
    ELSIF TG_TABLE_NAME = 'Intervenants' THEN
        role_to_remove := 'intervenant';
    END IF;

    -- Vérifier si l'utilisateur a encore d'autres rôles avant de supprimer
    IF EXISTS (
        SELECT 1 FROM pg_auth_members pam
        JOIN pg_roles pr ON pam.roleid = pr.oid
        JOIN pg_user pu ON pam.member = pu.usesysid
        WHERE pu.usename = user_email
        AND pr.rolname = role_to_remove
    ) THEN
        -- Supprimer uniquement le rôle ciblé
        EXECUTE format('REVOKE %I FROM %I', role_to_remove, user_email);
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- CREATION --

CREATE OR REPLACE FUNCTION init_roles()
RETURNS VOID AS $$ 
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'directeur') THEN
        CREATE ROLE directeur;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'bibliothecaire') THEN
        CREATE ROLE bibliothecaire;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'agent_securite') THEN
        CREATE ROLE agent_securite;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'technicien_informatique') THEN
        CREATE ROLE technicien_informatique;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'client') THEN
        CREATE ROLE client;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'abonne') THEN
        CREATE ROLE abonne;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'intervenant') THEN
        CREATE ROLE intervenant;
    END IF;
END 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION init_user()
RETURNS VOID AS $$ 
DECLARE 
    rec RECORD;
    role_name TEXT;
    password TEXT;
BEGIN
    FOR rec IN (SELECT p.id_personne, p.email FROM Personnes p) LOOP
        -- Génération d'un mot de passe aléatoire (modifiable par l'utilisateur ensuite)
        password := 'pass' || rec.id_personne;

        -- Vérification et suppression de l'utilisateur s'il existe déjà
        IF EXISTS (SELECT FROM pg_roles WHERE rolname = rec.email) THEN
            EXECUTE format('DROP USER IF EXISTS %I', rec.email);
        END IF;

        -- Création du nouvel utilisateur
        EXECUTE format('CREATE USER %I WITH PASSWORD %L', rec.email, password);

        -- Attribution du rôle correspondant
        IF EXISTS (SELECT 1 FROM Personnels WHERE id_personne = rec.id_personne) THEN
            SELECT poste INTO role_name FROM Personnels WHERE id_personne = rec.id_personne;
            IF role_name = 'Directeur' THEN
                EXECUTE format('GRANT directeur TO %I', rec.email);
            ELSIF role_name = 'Bibliothécaire' THEN
                EXECUTE format('GRANT bibliothecaire TO %I', rec.email);
            ELSIF role_name = 'Agent de sécurité' THEN
                EXECUTE format('GRANT agent_securite TO %I', rec.email);
            ELSIF role_name = 'Technicien informatique' THEN
                EXECUTE format('GRANT technicien_informatique TO %I', rec.email);
            END IF;
        ELSIF EXISTS (SELECT 1 FROM clients WHERE id_personne = rec.id_personne) THEN
            EXECUTE format('GRANT client TO %I', rec.email);
        ELSIF EXISTS (SELECT 1 FROM abonnes WHERE id_personne = rec.id_personne) THEN
            EXECUTE format('GRANT abonne TO %I', rec.email);
        ELSIF EXISTS (SELECT 1 FROM intervenants WHERE id_personne = rec.id_personne) THEN
            EXECUTE format('GRANT intervenant TO %I', rec.email);
        END IF;
    END LOOP;
END 
$$ LANGUAGE plpgsql;

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

-- MODIFICATION --

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

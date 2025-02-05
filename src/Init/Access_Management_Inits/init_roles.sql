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

Select init_roles();
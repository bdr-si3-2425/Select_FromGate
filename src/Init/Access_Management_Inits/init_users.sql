CREATE OR REPLACE FUNCTION init_users()
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

SELECT init_users();

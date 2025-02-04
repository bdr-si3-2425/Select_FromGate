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




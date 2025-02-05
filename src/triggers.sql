--------------------------------------------------------------------------------
-- PERSONNES (users / roles)
--------------------------------------------------------------------------------

CREATE TRIGGER trigger_add_user
    AFTER INSERT ON Personnes
    FOR EACH ROW
    EXECUTE FUNCTION add_user();

CREATE TRIGGER trigger_supprimer_user
    AFTER DELETE ON Personnes
    FOR EACH ROW
    EXECUTE FUNCTION supprimer_personne_trigger();

CREATE TRIGGER trigger_modifier_utilisateur
    AFTER UPDATE ON Personnes
    FOR EACH ROW
    EXECUTE FUNCTION update_user();

-- Abonnes :
CREATE TRIGGER trigger_retirer_role_abonne
    AFTER DELETE ON Abonnes
    FOR EACH ROW
    EXECUTE FUNCTION retirer_role_trigger();

-- Clients :
CREATE TRIGGER trigger_retirer_role_client
    AFTER DELETE ON Clients
    FOR EACH ROW
    EXECUTE FUNCTION retirer_role_trigger();

-- Intervenants :
CREATE TRIGGER trigger_retirer_role_intervenant
    AFTER DELETE ON Intervenants
    FOR EACH ROW
    EXECUTE FUNCTION retirer_role_trigger();

-- Personnels :
CREATE TRIGGER trigger_retirer_role_abonne
    AFTER DELETE ON Personnel
    FOR EACH ROW
    EXECUTE FUNCTION retirer_role_trigger();


--------------------------------------------------------------------------------
-- ABONNEMENTS
--------------------------------------------------------------------------------

CREATE TRIGGER verif_end_of_subsription
	BEFORE DELETE ON Abonnes
	FOR EACH ROW
	EXECUTE FUNCTION on_subsription_delete_fn();


--------------------------------------------------------------------------------
-- PRETS
--------------------------------------------------------------------------------

CREATE TRIGGER verif_pret_insert
    BEFORE INSERT ON Prets
    FOR EACH ROW
    EXECUTE FUNCTION verif_pret_insert_fn();

CREATE TRIGGER verif_pret_prolongation_insert
    BEFORE INSERT ON Prets_Renouvellements
    FOR EACH ROW
    EXECUTE FUNCTION verif_pret_prolongation_insert_fn();


--------------------------------------------------------------------------------
-- RESERVATIONS
--------------------------------------------------------------------------------

CREATE TRIGGER verif_reservation_insert
    BEFORE INSERT ON Reservations
    FOR EACH ROW
    EXECUTE FUNCTION verif_reservation_insert_fn();
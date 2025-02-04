-- SUPPRESSION --

-- Personnes
CREATE TRIGGER trigger_supprimer_user
AFTER DELETE ON Personnes
FOR EACH ROW
EXECUTE FUNCTION supprimer_personne_trigger();

-- Abonnes
CREATE TRIGGER trigger_retirer_role_abonne
AFTER DELETE ON Abonnes
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();

-- Clients
CREATE TRIGGER trigger_retirer_role_client
AFTER DELETE ON Clients
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();

-- Intervenants
CREATE TRIGGER trigger_retirer_role_intervenant
AFTER DELETE ON Intervenants
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();

-- Personnel
CREATE TRIGGER trigger_retirer_role_abonne
AFTER DELETE ON Personnel
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();

-- CREATION --

-- Trigger Personnes
CREATE TRIGGER trigger_creer_utilisateur
AFTER INSERT ON Personnes
FOR EACH ROW
EXECUTE FUNCTION add_user();

-- UPDATE --

-- Personnes
CREATE TRIGGER trigger_modifier_utilisateur
AFTER UPDATE ON Personnes
FOR EACH ROW
EXECUTE FUNCTION update_user();
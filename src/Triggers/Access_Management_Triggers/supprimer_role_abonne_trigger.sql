-- Abonnes
CREATE TRIGGER trigger_retirer_role_abonne
AFTER DELETE ON Abonnes
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();
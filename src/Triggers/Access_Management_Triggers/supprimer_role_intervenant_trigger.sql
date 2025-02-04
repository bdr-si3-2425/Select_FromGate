-- Intervenants
CREATE TRIGGER trigger_retirer_role_intervenant
AFTER DELETE ON Intervenants
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();
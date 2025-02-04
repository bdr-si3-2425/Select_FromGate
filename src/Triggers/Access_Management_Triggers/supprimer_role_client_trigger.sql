-- Clients
CREATE TRIGGER trigger_retirer_role_client
AFTER DELETE ON Clients
FOR EACH ROW EXECUTE FUNCTION retirer_role_trigger();

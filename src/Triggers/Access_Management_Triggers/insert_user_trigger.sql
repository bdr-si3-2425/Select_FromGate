
-- Trigger associé
CREATE TRIGGER trigger_creer_utilisateur
AFTER INSERT ON Personnes
FOR EACH ROW
EXECUTE FUNCTION add_user();
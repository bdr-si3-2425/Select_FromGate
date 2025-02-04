-- Trigger associé
CREATE TRIGGER trigger_modifier_utilisateur
AFTER UPDATE ON Personnes
FOR EACH ROW
EXECUTE FUNCTION update_user();
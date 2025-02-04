-- Création du trigger sur la suppression d'une personne
CREATE TRIGGER trigger_supprimer_user
AFTER DELETE ON Personnes
FOR EACH ROW
EXECUTE FUNCTION supprimer_personne_trigger();

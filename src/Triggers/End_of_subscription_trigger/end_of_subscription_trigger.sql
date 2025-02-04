CREATE TRIGGER verif_end_of_subsription
	BEFORE DELETE ON Abonnes
	FOR EACH ROW
	EXECUTE FUNCTION verif_end_of_subsription_fn();
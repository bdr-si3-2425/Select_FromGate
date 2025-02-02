CREATE TRIGGER verif_book_borrowed_emprun
    BEFORE INSERT ON Prets
    FOR EACH ROW
    EXECUTE FUNCTION verif_book_borrowed_emprun_fn();

CREATE TRIGGER verif_book_reserved_prolongation
    BEFORE UPDATE ON prets
    FOR EACH ROW
    EXECUTE FUNCTION verif_book_reserved_prolongation_fn();

CREATE TRIGGER verif_end_of_subsription
	BEFORE DELETE ON Abonnes
	FOR EACH ROW
	EXECUTE FUNCTION verif_end_of_subsription_fn();
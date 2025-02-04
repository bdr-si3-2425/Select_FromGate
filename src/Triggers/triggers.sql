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

CREATE TRIGGER verify_maximum_participants_event
    BEFORE INSERT ON Participants
    FOR EACH ROW
    EXECUTE FUNCTION verify_maximum_participants_event();

CREATE TRIGGER decrement_number_participant
    BEFORE DELETE ON Participants
    FOR EACH ROW
    EXECUTE FUNCTION decrement_number_participant();
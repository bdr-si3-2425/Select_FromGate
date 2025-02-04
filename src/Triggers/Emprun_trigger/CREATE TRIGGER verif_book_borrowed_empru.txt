CREATE TRIGGER verif_book_borrowed_emprun
    BEFORE INSERT ON Prets
    FOR EACH ROW
    EXECUTE FUNCTION verif_book_borrowed_emprun_fn();
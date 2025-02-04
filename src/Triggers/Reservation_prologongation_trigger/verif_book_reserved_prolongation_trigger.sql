CREATE TRIGGER verif_book_reserved_prolongation
    BEFORE UPDATE ON prets
    FOR EACH ROW
    EXECUTE FUNCTION verif_book_reserved_prolongation_fn();

--------------------------------------------------------------------------------
-- EMPRUNTS
--------------------------------------------------------------------------------

-- NOTE : J'ai mis ce qu'a fait Mathias pour faciliter le futur merge.

-- CREATE TRIGGER verif_new_loan
--     BEFORE INSERT ON Prets
--     FOR EACH ROW
--     EXECUTE FUNCTION verif_book_borrowed_emprun_fn();

-- CREATE TRIGGER verif_loan_prolongation
--     BEFORE UPDATE ON prets
--     FOR EACH ROW
--     EXECUTE FUNCTION verif_book_reserved_prolongation_fn();


--------------------------------------------------------------------------------
-- RESERVATIONS
--------------------------------------------------------------------------------


CREATE TRIGGER verif_reservation_insert
    BEFORE INSERT ON Reservations
    FOR EACH ROW
    EXECUTE FUNCTION verif_reservation_insert_fn;

-- TODO : À implémenter si besoin

-- CREATE TRIGGER verif_reservation_update
--    BEFORE UPDATE ON Reservations
--    FOR EACH ROW
--    EXECUTE FUNCTION verif_reservation_update_fn();
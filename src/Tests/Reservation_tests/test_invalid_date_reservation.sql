TRUNCATE TABLE Prets, Reservations CASCADE;
TRUNCATE TABLE Penalites, Banissements, Banissements_Temporaires, Amendes CASCADE;
TRUNCATE TABLE Amendes_Reglements CASCADE;

-- Test : Insertion d'une reservation à une date ultérieur à la demande (donc incorrecte)
INSERT INTO Reservations (id_exemplaire, id_abonne, date_reservation) VALUES (2, 12, CURRENT_DATE - INTERVAL '10 days');

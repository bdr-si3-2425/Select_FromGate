-- Creation du trigger pour vérifier s'il est possible de faire un emprunt
CREATE TRIGGER verif_book_borrowed_emprun
BEFORE INSERT ON Prets
FOR EACH ROW
EXECUTE FUNCTION verif_book_borrowed_emprun();

CREATE TRIGGER verif_book_reserved_prolongation
BEFORE UPDATE ON Prets
FOR EACH ROW EXECUTE FUNCTION verif_book_reserved_prolongation();

CREATE TRIGGER prevent_invalid_reservation_update
BEFORE UPDATE OR DELETE ON Reservations
FOR EACH ROW
EXECUTE FUNCTION check_reservation_modification();

-- Permet de restreinte la modification de la table Personnes au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Personnes
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Clients au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Clients
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Abonnements au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Abonnements
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Abonnes au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Abonnes
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Bibliotheques au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Bibliotheques
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Personnels au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Personnels
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Intervernants au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Intervernants
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Evenements au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Evenements
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Ouvrages au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Ouvrages
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();

-- Permet de restreinte la modification de la table Exemplaires au personnel
CREATE TRIGGER enforce_personnel_role_restrictions
BEFORE UPDATE OR DELETE OR INSERT ON Exemplaires
FOR EACH ROW
EXECUTE FUNCTION enforce_personnel_role_restrictions();
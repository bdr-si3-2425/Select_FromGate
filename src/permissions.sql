-- Ajout des utilisateurs au rôle "client"
GRANT client TO client1, client2;

-- Ajout des utilisateurs au rôle "abonne"
GRANT abonne TO abonne1, abonne2;

-- Ajout des utilisateurs au rôle "personnel"
GRANT personnel TO personnel1, personnel2;

-- Ajout des utilisateurs au rôle "bibliothecaire"
GRANT bibliothecaire TO bibliothecaire1, bibliothecaire2;

-- Ajout des utilisateurs au rôle "intervenant"
GRANT intervenant TO intervenant1, intervenant2;

GRANT SELECT ON Exemplaires_Disponibles TO abonne;

GRANT SELECT ON Reservations_Bibliothecaire TO bibliothecaire;

REVOKE SELECT ON Reservations FROM abonne;

REVOKE SELECT ON Reservations FROM bibliothecaire;



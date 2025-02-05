-- Attribution des privilèges aux rôles

-- Attribution de tous les privilèges au directeur
GRANT ALL ON ALL TABLES IN SCHEMA public TO directeur;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO directeur;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO directeur;

-- Attribution des privlièges aux abonnes
GRANT SELECT ON Exemplaires TO abonne;
GRANT SELECT ON Evenements TO abonne;
GRANT SELECT, UPDATE ON Reservations TO abonne;
GRANT INSERT ON Participants TO client;
GRANT SELECT ON Penalites_Abonnes TO abonne;

-- Attribution des privlièges aux bibliothecaires
GRANT SELECT ON Vue_Bibliotheques_Bibliothecaires TO bibliothecaire;
GRANT SELECT ON Vue_Reservations_Bibliothecaires TO bibliothecaire;
GRANT SELECT ON Evenements, Collections TO bibliothecaire;
GRANT SELECT ON Vue_Prets_Bibliothecaires TO bibliothecaire;
GRANT SELECT, INSERT, UPDATE, DELETE ON Transferts, Clients, Abonnes, Ouvrages, Exemplaires, Codes_Postaux TO bibliothecaire;
GRANT SELECT, UPDATE ON Abonnes TO bibliothecaire;
GRANT SELECT ON Penalites, Amendes, Banissements, Banissements_Temporaires TO bibliothecaire;
GRANT UPDATE ON Reservations TO bibliothecaire;

-- Attribution des privlièges aux agents de sécurité
GRANT SELECT, UPDATE ON Penalites, Amendes, Banissements, Banissements_Temporaires TO agent_securite;

-- Attribution des privlièges aux techiniciens informatique
GRANT SELECT, UPDATE ON Bibliotheques, Personnels TO technicien_informatique;

-- Attribution des privlièges aux client;
GRANT SELECT ON Ouvrages, Evenements TO client;
GRANT INSERT ON Participants TO client;

-- Attribution des privilèges aux intervenants
GRANT SELECT ON Evenements TO intervenant;

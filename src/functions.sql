-- Fonction qui s'assure que l'abonne peut bien faire un emprun
CREATE OR REPLACE FUNCTION verif_book_borrowed_emprun() 
RETURNS TRIGGER AS
$$
BEGIN
    -- Vérifier si l'exemplaire n'est pas déjà emprunté sur la période demandée
    IF EXISTS (
        SELECT 1 FROM Prets 
        WHERE id_exemplaire = NEW.id_exemplaire 
        AND NEW.date_debut <= date_fin 
        AND NEW.date_fin >= date_debut
    ) THEN
        RAISE EXCEPTION 'L''ouvrage est déjà emprunté sur cette période';
    END IF;

    -- Vérifier si l'abonné(e) n'a pas atteint son maximum de livres empruntés
    IF (
        (SELECT abnmt.nombre_livres 
         FROM Abonnes AS abe 
         JOIN Abonnements AS abnmt ON abe.id_abonnement = abnmt.id_abonnement 
         WHERE abe.id_personne = NEW.id_abonne
        ) <= 
        (SELECT COUNT(*) 
         FROM Prets AS p 
         WHERE p.id_abonne = NEW.id_abonne 
         AND p.date_fin >= CURRENT_DATE -- Livres non encore rendus
        )
    ) THEN 
        RAISE EXCEPTION 'L''abonné(e) a déjà atteint le maximum de livres empruntables permis par son abonnement';
    END IF;

    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement temporaire)
    IF EXISTS (
        SELECT 1 
        FROM Penalites AS p 
        JOIN Banissements_Temporaires AS bt ON bt.id_penalite = p.id_penalite 
        WHERE p.id_personne = NEW.id_abonne
        AND bt.date_debut <= CURRENT_DATE 
        AND bt.date_fin >= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) est banni temporairement';
    END IF;
    
    -- Vérifier que l'abonné(e) n'est pas interdit d'emprunt (Banissement définitif)
    IF EXISTS (
        SELECT 1 
        FROM Penalites AS p 
        JOIN Banissements AS b ON b.id_penalite = p.id_penalite 
        WHERE p.id_personne = NEW.id_abonne
        AND b.date_debut <= CURRENT_DATE
    ) THEN
        RAISE EXCEPTION 'L''abonné(e) est banni définitivement';
    END IF;

    -- Si tout va bien, on permet l'insertion
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Fonction qui vérifie s'il est possible de faire un prolongation d'emprunt
CREATE OR REPLACE FUNCTION verif_book_reserved_prolongation()
RETURN TRIGGER AS 
$$
BEGIN
	-- Verifier si le livre n'est pas reservé sur la période de prolongation
    IF EXISTS (
        SELECT 1 FROM Reservation AS r 
        WHERE r.id_exemplaire = NEW.id_exemplaire
        AND r.date_expiration >= CURDATE()
        AND NEW.date_fin >= r.date_debut
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ouvrage est réservé";
    END IF;

	-- Vérifier que l'abonné(e) n'a pas atteint sa limite de renouvellement (3 fois max)
    IF NEW.compteur_renouvellement > 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'abonné(e) a déjà consommé ses 3 renouvellements sur ce prêt";
    END IF;
END;
$$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION check_reservation_modification() 
RETURNS TRIGGER AS $$
DECLARE
    user_library_id INTEGER;
BEGIN
    -- Récupérer la bibliothèque du bibliothécaire connecté
    SELECT id_biliotheque INTO user_library_id
    FROM Personnels
    WHERE id_personne = (SELECT id_personne FROM PERSONNE WHERE email = CURRENT_USER);

    -- Vérifier si la réservation appartient à la bibliothèque du bibliothécaire
    IF NOT EXISTS (
        SELECT 1 
        FROM Reservations r
        JOIN Exemplaires e ON r.id_exemplaire = e.id_exemplaire
        JOIN Bibliotheques b ON e.id_bibliotheque = b.id_bibliotheque
        WHERE r.id_reservation = OLD.id_reservation
        AND b.id_bibliotheque = user_library_id
    ) THEN
        RAISE EXCEPTION 'Modification/Suppression non autorisée : La réservation n''appartient pas à votre bibliothèque';
    END IF;

    RETURN OLD; -- Permet la suppression si l'utilisateur est bien autorisé
END;
$$ LANGUAGE plpgsql;



-- Fonction qui s'assure que l'utilisateur actuel est un/une bibliothécaire ou le directeur
CREATE OR REPLACE FUNCTION enforce_personnel_role_restrictions() 
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si l'utilisateur a le rôle 'personnel'
    IF NOT current_role = 'directeur'OR current_role = 'bibliothecaire' OR 'technicien_informatique' THEN
        RAISE EXCEPTION 'Accès refusé : Vous n êtes pas autorisé à modifier la table Personnes';
    END IF;

    -- Vérifier si l'utilisateur est dans la table Personnels
    IF NOT EXISTS (
        SELECT 1 FROM Personnels WHERE id_personne = (SELECT id_personne FROM Personne WHERE email = CURRENT_USER
    ) THEN
        RAISE EXCEPTION 'Accès refusé : Vous devez être enregistré dans la table Personnels pour modifier la table Personnes';
    END IF;

    RETURN NEW; -- Autorise l'opération si les deux conditions sont respectées
END;
$$ LANGUAGE plpgsql;


-- Create a function that drop all the triggers of the database
CREATE OR REPLACE FUNCTION drop_all_triggers()
RETURNS VOID AS $$
DECLARE
    r RECORD;
BEGIN
    -- Pour chaque trigger dans la base de données
    FOR r IN (SELECT tgname, tgrelid::regclass::text AS table_name
              FROM pg_trigger
              WHERE NOT tgisinternal) 
    LOOP
        -- Génère et exécute le DROP TRIGGER pour chaque trigger
        EXECUTE 'DROP TRIGGER IF EXISTS ' || r.tgname || ' ON ' || r.table_name;
    END LOOP;
END 
$$ LANGUAGE plpgsql;

Select drop_all_triggers()
DO $$ 
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
END $$;

DO $$ 
DECLARE
    r RECORD;
BEGIN
    -- Pour chaque table dans la base
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        -- Génère et exécute un DROP pour chaque table
        EXECUTE 'DROP TABLE IF EXISTS public.' || r.tablename || ' CASCADE';
    END LOOP;
END $$;
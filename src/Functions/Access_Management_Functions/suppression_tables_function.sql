-- Create a function that drop all the tables of the database
CREATE OR REPLACE FUNCTION drop_all_tables()
RETURNS VOID AS $$ 
DECLARE
    r RECORD;
BEGIN
    -- Pour chaque table dans la base
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        -- Génère et exécute un DROP pour chaque table
        EXECUTE 'DROP TABLE IF EXISTS public.' || r.tablename || ' CASCADE';
    END LOOP;
END
$$ LANGUAGE plpgsql;

Select drop_all_tables()
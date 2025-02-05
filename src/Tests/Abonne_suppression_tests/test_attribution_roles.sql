SELECT 
    r.rolname AS role_name, 
    r.rolsuper AS is_superuser, 
    r.rolcreaterole AS can_create_roles, 
    r.rolcreatedb AS can_create_db,
    ARRAY(SELECT b.rolname 
          FROM pg_auth_members m
          JOIN pg_roles b ON m.roleid = b.oid
          WHERE m.member = r.oid) AS member_of
FROM pg_roles r
ORDER BY role_name;

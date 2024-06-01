-- Create the user 
create user OGRBILSIS
  identified by ""
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant connect to OGRBILSIS;
grant dba to OGRBILSIS;
-- Grant/Revoke system privileges 
grant unlimited tablespace to OGRBILSIS;

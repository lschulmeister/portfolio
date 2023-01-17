-- Database: db_erp
-- Author:
CREATE USER user_erp WITH ENCRYPTED PASSWORD '3rP890afg';


CREATE DATABASE db_erp
    WITH OWNER = user_erp
        ENCODING = 'UTF8'
        LC_COLLATE = 'en_US.utf8'
        LC_CTYPE = 'en_US.utf8'
        TABLESPACE = pg_default
        CONNECTION LIMIT = -1
        IS_TEMPLATE = False;

GRANT ALL PRIVILEGES ON DATABASE db_erp TO user_erp;
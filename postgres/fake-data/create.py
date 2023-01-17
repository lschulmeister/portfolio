import sys
import os
import app.generate as gen
from dotenv import load_dotenv

v_m = sys.argv[1]

load_dotenv()
v_c = gen.pg_connect(os.getenv('DBHOST'), os.getenv('DBPORT'), os.getenv('DBUSER'), os.getenv('DBPWD'), os.getenv('DB'))

if v_m == 'database':
    l_db = ["table_create", "fn_create", "trg_create", "proc_create", "vw_create"]

    for s in l_db:
        v_isql = open("sql/{}.sql".format(s), encoding="UTF-8").read()

        gen.pg_insert(v_c, v_isql)

if v_m == 'fake_data':
    v_n = ''+sys.argv[2]+''
    v_l = ''+sys.argv[3]+''
    v_t = ''+sys.argv[4]+''
    gen.fake_data(v_c, int(v_n), v_l, v_t)
elif v_m == 'data_import':
    v_n = ''+sys.argv[2]+''
    v_t = ''+sys.argv[3]+''
    gen.data_import(v_c, v_n, v_t)
elif v_m == "payment":
    v_n = ''+sys.argv[2]+''
    try:
        v_t = ''+sys.argv[3]+''
    except:
        v_t = '0'
    gen.sp_payment(v_c, v_n, v_t)
elif v_m == 'reset':
    v_isql = open("sql/reset.sql", encoding="UTF-8").read()

    gen.pg_insert(v_c, v_isql)
else:
    print("Veja as opções em README.md")

import psycopg2
import datetime
import pandas as pd
from faker import Faker
 
def pg_connect(pg_host, pg_port, pg_user, pg_pwd, pg_db):
    postgres_str = ('host = {host} \
    port = {port} \
    dbname = {db} \
    user = {username} \
    password = {password} ') \
    .format(host=pg_host,
    port=pg_port,
    username=pg_user,
    password=pg_pwd,
    db=pg_db)

    conn = psycopg2.connect(postgres_str)    
    
    return conn

def pg_count(v_conn, v_tbl):

    cursor = v_conn.cursor()
    cursor.execute("SELECT COUNT(*) FROM {}".format(v_tbl))
    res = cursor.fetchone()

    return res[0]

def pg_insert(v_conn, v_sql):
    try:
        cursor = v_conn.cursor()
        cursor.execute("{}".format(v_sql))
        v_conn.commit()
        
    except (Exception, v_conn.DatabaseError) as error:        
        print(error)
        exit

def data_import(v_pgcon, v_file, v_sep):
    l_sql=[]
    df = pd.read_csv(v_file, sep=""+v_sep+"")

    for (_, c1, c2, c3, c4, c5, c6) in df.itertuples():
        l_sql.append("""CALL public.new_product('{}', {}, '{}', '{}', {}, '{}', null);""".format(c1,c2,c3,c4,c5,c6))
    
    v_isql="\n".join(l_sql)    

    pg_insert(v_pgcon, v_isql)

def fake_data(v_pgcon, v_num, v_lan, v_tbl):

    fake = Faker(['{}'.format(v_lan)])
    v_cus = pg_count(v_pgcon, "customers")
    v_emp = pg_count(v_pgcon, "employees")
    v_pro = pg_count(v_pgcon, "product")
    l_sql=[]

    for n in range(0, v_num):

        if v_tbl == 'employees':
            v_csql = """INSERT INTO public.employees(f_name, l_name, state, city)
            VALUES('{}','{}','{}','{}');""".format(fake.first_name().replace("'",""),fake.last_name().replace("'",""),fake.state().replace("'",""),fake.city().replace("'",""))

        if v_tbl == 'customers':
            v_csql = """INSERT INTO public.customers(cnpj, c_name, e_mail, phone, state, city, customer_address)
            VALUES ({}, '{}', '{}', '{}', '{}', '{}', '{}');""".format(fake.msisdn(),fake.company().replace("'",""),fake.email(),fake.phone_number(),fake.state().replace("'",""),fake.city().replace("'",""),fake.address().replace("\n"," ").replace("'",""))
        
        if v_tbl == 'orders':

            v_csql = """CALL public.new_order({}, {}, '{}', {}, {}, null, null);""".format(fake.random_int(1,v_cus),fake.random_int(1,v_emp),datetime.datetime.now(),fake.random_int(1,v_pro),fake.random_int(1,10))

        l_sql.append(v_csql)
        v_isql="\n".join(l_sql)

    pg_insert(v_pgcon, v_isql)

    #f = open("output.txt", "w")
    #f.write(v_isql)
    #f.close()

def sp_payment(v_pgcon, v_num, v_ndt):

    if v_ndt == "0":
        v_ndt = (datetime.datetime.now() - datetime.timedelta(days=1)).strftime("%Y-%m-%d")

    v_isql = """CALL public.payment('{}', '{}')""".format(v_num, v_ndt)
    pg_insert(v_pgcon, v_isql)

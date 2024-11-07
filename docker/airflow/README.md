# Airflow

Stack com celery executor, providers adicionais e conexão com Oracle Database.
Providers   |
------------|
apache-airflow-providers-microsoft-mssql |
apache-airflow-providers-apache-spark |
apache-airflow-providers-oracle |
apache-airflow-providers-trino

Gerar fernet_key e adicionar no docker-compose \
https://airflow.apache.org/docs/apache-airflow/stable/security/secrets/fernet.html

~~~cmd
AIRFLOW__CORE__FERNET_KEY: 'adicionar_fernet_key_aqui'
~~~

### Imagem

~~~cmd
docker build . -t lschulmeister/airflow:2.8.3-python3.10
~~~

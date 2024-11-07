FROM apache/airflow:2.8.3-python3.10
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  vim default-jdk\
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY script/oracle.sh /opt
RUN cd /opt \
  && mkdir oracle \
  && chmod +x oracle.sh \
  && sh oracle.sh \
  && rm -rf oracle.sh \
  && chmod -R 0777 oracle

USER airflow
RUN python -m pip install --upgrade pip \
  && pip install --no-cache-dir \
  psycopg-binary \
  pydrive \
  oauth2client \
  cx_Oracle \
  snowflake-connector-python \
  pyarrow \
  holidays \
  pydrive2 \
  apache-airflow-providers-microsoft-mssql \
  apache-airflow-providers-apache-spark \
  apache-airflow-providers-oracle \
  apache-airflow-providers-trino
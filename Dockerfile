FROM python:3.7

ARG AIRFLOW_VERSION=1.10.14
ARG AIRFLOW_USER_HOME=/usr/local/airflow
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}

COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

WORKDIR /project

COPY script/ /scripts

RUN pip install apache-airflow[postgres]==${AIRFLOW_VERSION} \
    && pip install SQLAlchemy==1.3.23 \
    && pip install markupsafe==2.0.1 \
    && pip install wtforms==2.3.3 \
    && pip install flask-bcrypt \
    && chmod +x /scripts/init.sh

# Запускаем sh скрипт
ENTRYPOINT ["/scripts/init.sh"]

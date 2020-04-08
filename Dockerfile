FROM apache/airflow:master

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
COPY airflow/requirements.txt /opt/airflow/requirements.txt
RUN pip install -r /opt/airflow/requirements.txt
#COPY datascience-framework/requirements.txt /opt/airflow/ds-requirements.txt
#RUN pip install -r /opt/airflow/ds-requirements.txt

# setup and build metrics dependency
# best would be to include this in requirements.txt
COPY metrics /opt/metrics
WORKDIR /opt/metrics/scripts
RUN pip install -e .
RUN chown -R airflow:airflow /opt/metrics

RUN echo "airflow ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/airflow

USER airflow
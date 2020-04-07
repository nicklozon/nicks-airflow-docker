FROM apache/airflow:master


USER root
RUN echo "deb http://ftp.us.debian.org/debian sid main" \
        > /etc/apt/sources.list.d/openjdk.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
      software-properties-common \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Stolen from https://github.com/apache/airflow/blob/master/Dockerfile.ci
RUN curl --fail --location https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" \
    && apt-get update \
    && apt-get -y install --no-install-recommends docker-ce \
    && apt-get autoremove -yqq --purge \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G docker airflow
RUN service docker start

RUN echo "airflow ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/airflow

USER airflow
RUN pip install docker --user
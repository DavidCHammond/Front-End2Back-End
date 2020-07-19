FROM puckel/docker-airflow:latest
USER root


# install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install --yes --no-install-recommends --no-install-suggests \
    curl \
    nano \
    make \
    libpq-dev \
    git && \
    apt-get install --yes python-pip && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install --yes python-dev \
    libssl-dev libcurl4-openssl-dev python-gpg liblzma-dev libsasl2-dev libkrb5-dev

COPY ./requirements.txt /mnt/requirements.txt
RUN pip install -r /mnt/requirements.txt
ENV AIRFLOW_HOME /opt/david
WORKDIR $AIRFLOW_HOME

COPY ./ $AIRFLOW_HOME/dags/

# copy the entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
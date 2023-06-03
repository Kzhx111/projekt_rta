FROM jupyter/pyspark-notebook

USER root

RUN apt-get update && \
    apt-get install -y wget git netcat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Tensorflow and pymongo
RUN pip install --no-cache tensorflow pymongo confluent_kafka

USER ${NB_UID}

WORKDIR /home/jovyan/notebooks

ADD notebooks /home/jovyan/notebooks/

EXPOSE 8888
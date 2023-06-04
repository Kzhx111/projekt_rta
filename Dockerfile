FROM jupyter/pyspark-notebook

USER root

# Start and enable SSH
#COPY entrypoint.sh ./

#RUN apt-get update \
#    && apt-get install -y --no-install-recommends dialog \
#    && apt-get install -y --no-install-recommends openssh-server \
#    && echo "root:Docker!" | chpasswd \
#    && chmod u+x ./entrypoint.sh
#COPY sshd_config /etc/ssh/

#ENTRYPOINT [ "./entrypoint.sh" ] 

RUN apt-get update && \
    apt-get install -y wget git netcat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache tensorflow pymongo confluent_kafka

USER ${NB_UID}

WORKDIR /home/jovyan/notebooks

ADD notebooks /home/jovyan/notebooks/

EXPOSE 8888 8889
# 2222 for SSH

# Below doen't work
CMD [ "broker kafka-topics --bootstrap-server broker:9092 --create --topic test" ]
from rucio/rucio-server:release-1.22.8.post1

RUN yum clean all && \
    rm -rf /var/cache/yum

RUN yum install git -y

RUN pip install configparser
RUN mkdir /scripts

WORKDIR /scripts

RUN git clone https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts.git

COPY ./scripts/* /scripts/
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

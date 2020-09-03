from rucio/rucio-server:release-1.23.2.post2

RUN yum clean all && \
    rm -rf /var/cache/yum

RUN yum install git -y

RUN pip install configparser
RUN mkdir /scripts

WORKDIR /scripts

RUN git clone https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts.git

COPY ./scripts/* /scripts/
COPY ./entrypoint.sh /entrypoint.sh
COPY ./rucio.cfg.escape.j2 /rucio.cfg.escape.j2

ENTRYPOINT ["/entrypoint.sh"]

FROM rucio/rucio-server:release-1.23.6

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

USER root
# EGI trust anchors
RUN curl -o /etc/yum.repos.d/EGI-trustanchors.repo http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo \
    && yum -y update

RUN yum -y install wget gfal2*
RUN yum -y install ca-certificates ca-policy-egi-core
# ESCAPE VOMS setup
RUN mkdir -p /etc/vomses \
    && wget https://indigo-iam.github.io/escape-docs/voms-config/voms-escape.cloud.cnaf.infn.it.vomses -O /etc/vomses/voms-escape.cloud.cnaf.infn.it.vomses
RUN mkdir -p /etc/grid-security/vomsdir/escape \
    && wget https://indigo-iam.github.io/escape-docs/voms-config/voms-escape.cloud.cnaf.infn.it.lsc -O /etc/grid-security/vomsdir/escape/voms-escape.cloud.cnaf.infn.it.lsc

ENTRYPOINT ["/entrypoint.sh"]

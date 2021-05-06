FROM rucio/rucio-server:release-1.25.4

# cleanup yum cache
RUN yum clean all && \
    rm -rf /var/cache/yum

# install useful tools
RUN yum -y install git htop

# create workdir
RUN mkdir /scripts
WORKDIR /scripts

# clone repos
RUN git clone https://github.com/ESCAPE-WP2/Utilities-and-Operations-Scripts.git
RUN git clone https://github.com/ESCAPE-WP2/fts-analysis-datalake.git

# install repos requirments
RUN pip install --upgrade pip
RUN pip install -r /scripts/Utilities-and-Operations-Scripts/gfal-sam-testing/requirements.txt
RUN pip install -r /scripts/fts-analysis-datalake/requirements.txt

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

# Required!
# RUN mkdir -p /etc/pki/tls/certs/
# COPY ./CERN-bundle.pem /etc/pki/tls/certs/CERN-bundle.pem

# Install latest kubectl
RUN curl -o /usr/bin/kubectl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

ENTRYPOINT ["/bin/bash"]

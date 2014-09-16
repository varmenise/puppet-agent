# Docker image for Puppet Agent

FROM varmenise/docker-sshd
MAINTAINER Valentina Armenise <varmenise@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-7-jdk \
    curl \
    ntp \
    ntpdate \
    git \
    puppet


ADD ./puppet.sh /usr/local/bin/puppet.sh
ADD ./puppet.conf /etc/puppet/puppet.conf
RUN chmod +x /usr/local/bin/puppet.sh

RUN git clone https://github.com/fbelzunc/tomcat7-module.git /etc/puppet/modules/tomcat7-module
RUN git clone https://github.com/fbelzunc/deploy-petclinic.git /etc/puppet/modules/deploy-petclinic

CMD ["/usr/local/bin/puppet.sh","bin/bash"]

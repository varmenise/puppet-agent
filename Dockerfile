FROM varmenise/jenkins-base
MAINTAINER Valentina Armenise <varmenise@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends puppet

# Add the jenkins user to the sudoers group
RUN echo "jenkins    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD ./puppet.sh /usr/local/bin/puppet.sh
ADD ./puppet.conf /etc/puppet/puppet.conf
RUN chmod +x /usr/local/bin/puppet.sh

#Clone modules
RUN git clone https://github.com/fbelzunc/tomcat7-module.git /etc/puppet/modules/tomcat7-module
RUN git clone https://github.com/fbelzunc/deploy-petclinic.git /etc/puppet/modules/deploy-petclinic

#Stop the daemon service
RUN service puppet stop

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

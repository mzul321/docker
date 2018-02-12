FROM evarga/jenkins-slave
#Getting image from evarga repo 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -qqy \
#    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables && \
    rm -rf /var/lib/apt/lists/*

RUN echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

ENV DOCKER_VERSION 1.8.1-0~trusty

# Install Docker from Docker Inc. repositories.
RUN apt-get update && apt-get install -y docker-engine=$DOCKER_VERSION && rm -rf /var/lib/apt/lists/*
ADD wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker
VOLUME /var/lib/docker

RUN apt-get update && apt-get install -y software-properties-common python-software-properties && add-apt-repository ppa:webupd8team/java && apt-get update 

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java8-installer  oracle-java8-set-default

RUN echo 'JAVA_HOME=/usr/lib/jvm/java-8-oracle' >> /etc/environment

# Make sure that the "jenkins" user from evarga's image is part of the "docker"
RUN usermod -a -G docker jenkins

#You can have your own user and add it here, change the permission as above 

#Just to make sure we have password less access from VM to docker

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDT4/OlCjMDacPyYvJfnBQhIRg4ldRZ7fxB7Eoa7sJgKQnV/qP2Gg29tPUb3g1k/xWmOoTOBi6XWMAaFACtYEy0vfMRkRhfEMpzmx0hSfi2jkssKJvei50wCe04t5KqY7xxgnMbRqf+XOnnQRjbwLFM9r1wgk4wR7HeE+D25hS19O7pKxAr8ByCmF3UQ4/zdvsA/gDky31E+mU01bGKgiNSBTZbXM1g48TnkvZuS/sN0uxznucx7Y61TeLz4r/nZiK18f0BNDj3AXTZQBgbwvYP0hYmf1/9ajl03fn4orjChHk58dcR8oA5VzV4rCVeu2VLEXjnoTYfuQhiD jenkins@7213637c0b2c" >> /home/jenkins/.ssh/authorized_keys

#making sure, it has sudo access (if you want)

RUN echo "jenkins  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#RUN mkdir /home/releasebot/

# place the jenkins slave startup script into the container

ADD slave-startup.sh /

# Expose the standard SSH port 
EXPOSE 22

CMD ["/slave-startup.sh"]

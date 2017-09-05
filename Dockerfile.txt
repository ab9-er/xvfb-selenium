FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y wget \
                       software-properties-common && \
    add-apt-repository -y ppa:jonathonf/python-3.6 && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list && \
    wget https://dl.google.com/linux/linux_signing_key.pub && \
    apt-key add linux_signing_key.pub && \
    apt-get update && \
    apt-get install -y curl \
                       bash \
                       sudo \
                       nano \
                       python3.6 \
                       python3-dev \
                       python3-cryptography \
                       python-selenium \
                       openssh-client \
                       libmemcached-dev \
                       libffi-dev \
                       psutils \
                       unzip \
                       automake \
                       net-tools \
                       git \
                       default-jdk \
                       google-chrome-stable && \
    curl https://bootstrap.pypa.io/get-pip.py | python3.6 && \
    git config --global user.email "test@test.ing" && \
    git config --global user.name "Test User" && \
    wget https://chromedriver.storage.googleapis.com/2.32/chromedriver_linux64.zip -O /tmp/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver_linux64.zip -d /usr/local/bin && \
    rm /tmp/*.zip

RUN pip3 install ipython \
                 selenium==3.5.0

ENTRYPOINT ["/bin/bash"]

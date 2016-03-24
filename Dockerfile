FROM alpine:3.3

USER root

#------------------
# Configure sources
#------------------
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories && \
        echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
        echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories &&  \
        echo "http://dl-2.alpinelinux.org/alpine/v3.2/main" >> /etc/apk/repositories

#-----------------
# Add packages
#-----------------
RUN apk update && \
        apk -U add \
        bash \
        dpkg \
        dpkg-dev \
        make \
        automake \
        autoconf \
        gcc \
        g++ \
        openssh-client \
        git \
        xvfb \
        dbus-x11 \
        ttf-noto-serif \
        libx11 \
        xorg-server \
        openjdk8-jre \
        firefox \
        python \
        py-pip \
        python-dev \
        libffi-dev \
        psutils \
        libmemcached-dev \
        libressl-dev \
        zlib-dev \
        linux-headers \
	chromium

#-----------------
# Install libraries & webdriver
#-----------------
RUN wget http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar -O /tmp/selenium-server-standalone-2.53.0.jar

#-----------------
# Set ENV and change mode
#-----------------
ENV TZ "Europe/Paris"
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0
ENV GEOMETRY "$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

RUN touch /var/log/selenium.log
RUN chmod +w /var/log/selenium.log

RUN echo $TZ > /etc/timezone
EXPOSE 4444
EXPOSE 80
#-----------------
# Run scripts
#-----------------
RUN mkdir -p /opt/bin
RUN touch /opt/bin/entry_point.sh

RUN chmod +x /tmp/selenium-server-standalone-2.53.0.jar
RUN chmod +x /opt/bin/entry_point.sh

RUN echo -e "function shutdown {\n\
kill -s SIGTERM $JAVA_PID\n\
wait $JAVA_PID\n\
}\n\n\
Xvfb $DISPLAY -screen 0 $GEOMETRY -nolisten tcp & XVFB_PID=$!\n\n\
java -jar /tmp/selenium-server-standalone-2.53.0.jar & JAVA_PID=$!\n\n\
trap shutdown SIGTERM SIGINT\n\
wait $JAVA_PID" > /opt/bin/entry_point.sh

ENTRYPOINT /bin/bash /opt/bin/entry_point.sh

# Customized Owasp ZAP Dockerfile with support for authentication

FROM owasp/zap2docker-stable

USER root

RUN mkdir /zap/wrk \
	&& cd /opt \
	&& wget -qO- -O geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-linux64.tar.gz \
	&& tar -xvzf geckodriver.tar.gz \
	&& chmod +x geckodriver \
	&& ln -s /opt/geckodriver /usr/bin/geckodriver \
	&& export PATH=$PATH:/usr/bin/geckodriver 

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 103.0.5060.53
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

ADD . /zap/
RUN chown -R zap:zap /zap/

USER zap

RUN pip install -r /zap/requirements.txt

VOLUME /zap/wrk
WORKDIR /zap

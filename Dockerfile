FROM circleci/openjdk:8-jdk-node

LABEL maintainer="Mark J. Becker"

ENV SONAR_SCANNER_VERSION=3.0.3.778-linux

WORKDIR /home/circleci

# Install wsk
RUN mkdir bin && \
    cd bin && \
    wget -nv https://openwhisk.ng.bluemix.net/cli/go/download/linux/amd64/OpenWhisk_CLI-linux.tgz && \
    tar -xvzf OpenWhisk_CLI-linux.tgz && \
    rm OpenWhisk_CLI-linux.tgz && \
    chmod +x wsk

# Install sonar scanner
RUN cd bin && \
    wget -nv https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    mv sonar-scanner-${SONAR_SCANNER_VERSION} sonar-scanner && \
    chmod +x sonar-scanner/bin/sonar-scanner

ENV PATH="${PATH}:/home/circleci/bin:/home/circleci/bin/sonar-scanner/bin"
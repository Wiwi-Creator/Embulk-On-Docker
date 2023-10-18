# EmbulkㄦJDK
FROM openjdk:8-jdk

# set working direction
RUN mkdir /app;

WORKDIR /app

COPY etc /app/etc

ENV LANG="C.UTF-8"\
    # Define Version
    EMBULK_DOWNLOAD_SERVER='https://dl.embulk.org' \
    EMBULK_VERSION='0.9.23' \
    GEMFILE_PATH='/app/etc'\
    PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common curl git libpq-dev libssl-dev build-essential;

RUN add-apt-repository ppa:deadsnakes/ppa; 

# install dev-base packages
RUN apt-get update && apt-get install -y --no-install-recommends openjdk-8-jre-headless=8u252-b09-1ubuntu1\
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
    add-apt-repository ppa:deadsnakes/ppa; 

RUN curl -o /usr/bin/embulk --create-dirs -L "$EMBULK_DOWNLOAD_SERVER/embulk-$EMBULK_VERSION.jar"; \
    chmod a+x /usr/bin/embulk; \
# install embulk-input-mongodb with custom gem
    embulk gem install -g $GEMFILE_PATH/GemFile; \
    gsutil cp -r gs://embulk-custom-plugin $GEMFILE_PATH; \
    embulk gem install --local $GEMFILE_PATH/embulk-custom-plugin/embulk-input-mongodb-0.8.1-java.gem; \
    embulk gem install --local $GEMFILE_PATH/embulk-custom-plugin/embulk-output-bigquery-0.6.7.gem; \
    curl -o /root/.embulk/lib/gems/gems/embulk-input-postgresql-0.13.0-java/postgresql-42.4.0.jar https://jdbc.postgresql.org/download/postgresql-42.4.0.jar; \
    rm -rf /var/lib/apt/lists/* && apt-get clean all;

# Keep Container Running
CMD ["bash", "-c", "while true; do sleep 3600; done"]

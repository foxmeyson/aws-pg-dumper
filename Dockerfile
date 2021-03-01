FROM ubuntu:18.04
LABEL maintainer="https://github.com/foxmeyson"

RUN apt-get update     \
    && apt-get install --no-install-recommends -y \
        apt-utils \
        ca-certificates \
        lsb-release \
        pigz \
        awscli \
        python3-pip \
        python3-setuptools \
        curl \
        jq \
        gnupg \
        gcc \
        libffi-dev \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir awscli --upgrade \
    && pip3 install --no-cache-dir gsutil --upgrade \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && cat /etc/apt/sources.list.d/pgdg.list \
    && curl --silent https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update \
    && apt-get install --no-install-recommends -y  \
        postgresql-client-13  \
        postgresql-client-12  \
        postgresql-client-11  \
        postgresql-client-10  \
        postgresql-client-9.6 \
        postgresql-client-9.5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY backup.sh .
COPY Dockerfile .
RUN chmod +x backup.sh

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENTRYPOINT ["/bin/bash"]
CMD ["backup.sh"]

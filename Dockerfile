FROM alpine:3.19
LABEL maintainer="https://github.com/foxmeyson"

# Install dependencies
RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
        ca-certificates \
        curl \
        jq \
        bash \
        gnupg \
        gcc \
        musl-dev \
        libffi-dev \
        python3 \
        py3-pip \
        pigz \
        aws-cli \
        tzdata \
        postgresql-client \
    && pip install --upgrade pip \
    && pip install --no-cache-dir awscli gsutil

# Set timezone
ENV TZ=Europe/Moscow
RUN cp /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Copy backup script
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

ENTRYPOINT ["/bin/bash"]
CMD ["/usr/local/bin/backup.sh"]

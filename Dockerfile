# First ARG before FROM
ARG LOGSTASH_VERSION

FROM docker.elastic.co/logstash/logstash:${LOGSTASH_VERSION}

ARG POSTGRES_DRIVER_VERSION
ENV POSTGRES_DRIVER_VERSION=${POSTGRES_DRIVER_VERSION}

USER root

# Install PostgreSQL JDBC driver with specified version
RUN echo "Installing PostgreSQL JDBC driver version: ${POSTGRES_DRIVER_VERSION}" && \
    curl -fL --retry 3 --retry-delay 3 --output /usr/share/logstash/logstash-core/lib/jars/postgresql.jar \
    https://jdbc.postgresql.org/download/postgresql-${POSTGRES_DRIVER_VERSION}.jar

# Ensure proper permissions
RUN chown logstash:root /usr/share/logstash/logstash-core/lib/jars/postgresql.jar

# Set environment variables for Java options and classpath
ENV LS_JAVA_OPTS="-Djava.class.path=/usr/share/logstash/logstash-core/lib/jars/postgresql.jar"

ENV POSTGRES_DRIVER_PATH=/opt/bitnami/logstash/plugins/postgresql.jar

# Switch back to logstash user
USER logstash

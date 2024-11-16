ARG LOGSTASH_VERSION
ARG POSTGRES_DRIVER_VERSION
FROM docker.elastic.co/logstash/logstash:${LOGSTASH_VERSION}

USER root

# Install PostgreSQL JDBC driver with specified version
RUN curl -L --output /usr/share/logstash/logstash-core/lib/jars/postgresql.jar \
    https://jdbc.postgresql.org/download/postgresql-${POSTGRES_DRIVER_VERSION}.jar

# Switch back to logstash user
USER logstash

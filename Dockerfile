ARG LOGSTASH_VERSION
ARG POSTGRES_DRIVER_VERSION
FROM docker.elastic.co/logstash/logstash:${LOGSTASH_VERSION}

USER root

# Install PostgreSQL JDBC driver with specified version
RUN curl -L --output /usr/share/logstash/logstash-core/lib/jars/postgresql.jar \
    https://jdbc.postgresql.org/download/postgresql-${POSTGRES_DRIVER_VERSION}.jar

# Ensure proper permissions
RUN chown logstash:root /usr/share/logstash/logstash-core/lib/jars/postgresql.jar

# Set environment variables for Java options and classpath
ENV LS_JAVA_OPTS="-Xms1g -Xmx1g -Djava.class.path=/usr/share/logstash/logstash-core/lib/jars/postgresql.jar"

# Switch back to logstash user
USER logstash

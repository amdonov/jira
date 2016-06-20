FROM alpine:3.3
ENV JAVA_HOME=/usr JIRA_HOME=/var/atlassian/application-data/jira
RUN apk --update add curl bash openjdk8-jre && rm -rf /var/cache/apk/*
RUN curl -k -o jira.tgz https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.1.7-jira-7.1.7.tar.gz && \
    tar xfz jira.tgz && \
    rm jira.tgz && \
    mkdir -p /opt/atlassian && mv atlassian* /opt/atlassian/jira && \
    rm /opt/atlassian/jira/bin/check-java.sh && \
    mkdir -p /var/atlassian/application-data/jira
# Allow jira to run as any user for OpenShift
RUN chmod -R 777 /opt/atlassian/jira/logs /opt/atlassian/jira/work /opt/atlassian/jira/temp /opt/atlassian/jira/conf /var/atlassian/application-data/jira
EXPOSE 8080
VOLUME /var/atlassian/application-data/jira
CMD /opt/atlassian/jira/bin/start-jira.sh -fg


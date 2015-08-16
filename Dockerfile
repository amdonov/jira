FROM debian:jessie
RUN apt-get update && apt-get install -y curl
COPY response.varfile /root/response.varfile
RUN curl -k -o jira.bin https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-6.4.10-x64.bin && chmod 755 jira.bin && ./jira.bin -q -varfile /root/response.varfile && rm jira.bin && /opt/atlassian/jira/bin/stop-jira.sh
USER jira
EXPOSE 8080
VOLUME /var/atlassian/application-data/jira
CMD /opt/atlassian/jira/bin/start-jira.sh -fg



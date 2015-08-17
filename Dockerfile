FROM debian:jessie
RUN apt-get update && apt-get install -y curl
COPY response.varfile /root/response.varfile
RUN curl -k -o jira.bin https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-6.4.10-x64.bin && chmod 755 jira.bin && ./jira.bin -q -varfile /root/response.varfile && rm jira.bin && pkill java
# Allow jira to run as any UID for Openshift
RUN chmod -R 777 /opt/atlassian/jira/logs /opt/atlassian/jira/work /opt/atlassian/jira/temp /opt/atlassian/jira/conf /var/atlassian/application-data/jira && echo "" > /opt/atlassian/jira/bin/user.sh
# Go ahead and set user even though it will be ignored in restricted context
USER 1000
EXPOSE 8080
VOLUME /var/atlassian/application-data/jira
CMD /opt/atlassian/jira/bin/start-jira.sh -fg

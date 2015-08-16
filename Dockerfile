FROM debian:jessie
RUN apt-get update && apt-get install -y curl
COPY response.varfile /root/response.varfile
USER 1000
EXPOSE 8081
VOLUME ["/var/atlassian/application-data/jira"]
CMD ["/opt/atlassian/jira/bin/start-jira.sh" "-fg"]



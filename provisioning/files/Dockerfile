FROM jenkins/ssh-agent:jdk11
RUN apt update && apt install curl -y
COPY jenkins_agent_create.sh /home/jenkins/jenkins_agent_create.sh
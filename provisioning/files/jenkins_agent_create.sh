#!/bin/bash

set -xe

MASTER_URL="http://172.168.0.2:8080/"
MASTER_USERNAME="test"
MASTER_PASSWORD="test"
NODE_NAME="bullseye"
NUM_EXECUTORS=2

# Download CLI jar from the master
curl ${MASTER_URL}/jnlpJars/jenkins-cli.jar -o ~jenkins/jenkins-cli.jar

# Create node according to parameters passed in
cat <<EOF | java -jar ~jenkins/jenkins-cli.jar -auth "${MASTER_USERNAME}:${MASTER_PASSWORD}" -s "${MASTER_URL}" create-node "${NODE_NAME}" |true
<slave>
  <name>${NODE_NAME}</name>
  <description></description>
  <remoteFS>/home/jenkins/agent</remoteFS>
  <numExecutors>${NUM_EXECUTORS}</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher">
    <workDirSettings>
      <disabled>false</disabled>
      <internalDir>remoting</internalDir>
      <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
    </workDirSettings>
  </launcher>
  <label></label>
  <nodeProperties/>
  <userId>${USER}</userId>
</slave>
EOF

curl ${MASTER_URL}/jnlpJars/agent.jar -o ~jenkins/agent.jar

# Run jnlp launcher
java -jar /usr/share/jenkins/slave.jar -jnlpUrl ${MASTER_URL}/computer/${NODE_NAME}/slave-agent.jnlp -jnlpCredentials "${MASTER_USERNAME}:${MASTER_PASSWORD}"
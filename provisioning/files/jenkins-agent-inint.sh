#!/bin/bash

set -xe

MASTER_URL="http://172.168.0.2:8080/"
MASTER_USERNAME="test"
MASTER_PASSWORD="test"
NODE_NAME="bullseye"
NUM_EXECUTORS=2

java -jar agent.jar -jnlpUrl ${MASTER_URL}/computer/bullseye/jenkins-agent.jnlp -secret $1 -workDir "/home/jenkins/agent"
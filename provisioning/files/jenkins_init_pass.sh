#!/bin/bash
echo "Vagrant initial password:"
sudo docker exec $(sudo docker ps -aqf "name=jenkins") cat /var/jenkins_home/secrets/initialAdminPassword
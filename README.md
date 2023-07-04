# yadro_task

### Vagrant 

You can change VM settings in config file `Vagrantfile`

For start and stop VM run commands in shell:

```
# Start VM 
$ vagrant up

# Kill VM 
$ vagrant destroy

# Run ansible provision
$ vagrant provision
```

### Jenkins

After Jenkins server installed you can find initial password by running command:

```
$  vagrant ssh -c 'sudo docker exec $(sudo docker ps -aqf "name=jenkins") cat /var/jenkins_home/secrets/initialAdminPassword'
```

And put it on page  http://localhost:8080/

Please add user test:test. Then you need to update Jenkins using web page and press restart option.

Jenkins restart in container didn`t work propertly so you need manualy start jenkins again by run command:

```
$ vagrant ssh -c 'sudo make up'
```

#### Agent

```
root@61902c9b7f80:/home/jenkins# ./jenkins_agent_create.sh 
+ MASTER_URL=http://172.168.0.2:8080/
+ MASTER_USERNAME=test
+ MASTER_PASSWORD=test
+ NODE_NAME=bullseye
+ NUM_EXECUTORS=2
+ curl http://172.168.0.2:8080//jnlpJars/jenkins-cli.jar -o /home/jenkins/jenkins-cli.jar
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 3487k  100 3487k    0     0   340M      0 --:--:-- --:--:-- --:--:--  378M
+ cat
+ java -jar /home/jenkins/jenkins-cli.jar -auth test:test -s http://172.168.0.2:8080/ create-node bullseye
+ true
root@61902c9b7f80:/home/jenkins# java -jar agent.jar -jnlpUrl http://172.168.0.2:8080/computer/bullseye/jenkins-agent.jnlp -secret 0f41920988688bb35f28c8f1f1582dc816a6ebd58076cf1e62c639895ca10655 -workDir "/home/jenkins/agent"
Jul 04, 2023 11:12:15 AM org.jenkinsci.remoting.engine.WorkDirManager initializeWorkDir
INFO: Using /home/jenkins/agent/remoting as a remoting work directory
Jul 04, 2023 11:12:15 AM org.jenkinsci.remoting.engine.WorkDirManager setupLogging
INFO: Both error and output logs will be printed to /home/jenkins/agent/remoting
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main createEngine
INFO: Setting up agent: bullseye
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main$CuiListener <init>
INFO: Jenkins agent is running in headless mode.
Jul 04, 2023 11:12:15 AM hudson.remoting.Engine startEngine
INFO: Using Remoting version: 4.13.3
Jul 04, 2023 11:12:15 AM org.jenkinsci.remoting.engine.WorkDirManager initializeWorkDir
INFO: Using /home/jenkins/agent/remoting as a remoting work directory
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Locating server among [http://172.168.0.2:8080/]
Jul 04, 2023 11:12:15 AM org.jenkinsci.remoting.engine.JnlpAgentEndpointResolver resolve
INFO: Remoting server accepts the following protocols: [JNLP4-connect, Ping]
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Agent discovery successful
  Agent address: 172.168.0.2
  Agent port:    50000
  Identity:      1c:f6:bb:cf:78:8d:ad:e0:30:b0:01:02:3a:0f:c4:2f
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Handshaking
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Connecting to 172.168.0.2:50000
Jul 04, 2023 11:12:15 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Trying protocol: JNLP4-connect
Jul 04, 2023 11:12:15 AM org.jenkinsci.remoting.protocol.impl.BIONetworkLayer$Reader run
INFO: Waiting for ProtocolStack to start.
Jul 04, 2023 11:12:16 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Remote identity confirmed: 1c:f6:bb:cf:78:8d:ad:e0:30:b0:01:02:3a:0f:c4:2f
Jul 04, 2023 11:12:16 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Connected
```

vagrant ssh -c 'sudo docker exec -ti $(sudo docker ps -aqf "name=agent") java -jar agent.jar -jnlpUrl http://172.168.0.2:8080/computer/bullseye/jenkins-agent.jnlp -secret 0f41920988688bb35f28c8f1f1582dc816a6ebd58076cf1e62c639895ca10655 -workDir "/home/jenkins/agent"'
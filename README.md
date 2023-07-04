# yadro_task

### Vagrant 

You can change VM settings in config file `Vagrantfile` for example NET_CARD_NAME `config.vm.network "public_network" , bridge: "NET_CARD_NAME"`

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

Please add user test:test. You can update Jenkins using web page and press restart option.

If Jenkins restart in container didn`t work propertly so you need manualy start jenkins again by run command:

```
$ vagrant ssh -c 'sudo make up'
```

On page Instance Configuration, setup `Jenkins URL:￼http://172.168.0.2:8080/`

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
...
Jul 04, 2023 11:12:16 AM hudson.remoting.jnlp.Main$CuiListener status
INFO: Connected
```
vagrant ssh -c 'sudo docker exec -ti $(sudo docker ps -aqf "name=agent") ./jenkins_agent_create.sh'
vagrant ssh -c 'sudo docker exec -ti $(sudo docker ps -aqf "name=agent") ./jenkins_agent_init.sh SECRET_FOR_AGENT'
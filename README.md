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

If Jenkins in container didn`t restart propertly  you can manualy start jenkins again by run command:

```
$ vagrant ssh -c 'sudo make up'
```

On page Instance Configuration, setup `Jenkins URL:￼http://172.168.0.2:8080/`

#### Agent

vagrant ssh -c 'sudo docker exec -ti $(sudo docker ps -aqf "name=agent") ./jenkins_agent_create.sh'

On the page 

vagrant ssh -c 'sudo docker exec -ti $(sudo docker ps -aqf "name=agent") ./jenkins_agent_init.sh SECRET_FOR_AGENT'
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
$  vagrant ssh -c 'sudo docker exec $(sudo docker ps -q | head -1) cat /var/jenkins_home/secrets/initialAdminPassword'
```

And put it on page  http://localhost:8080/

Please add user test:test. Then you need to update Jenkins using web page and press restart option.

Jenkins restart in container didn`t work propertly so you need manualy start jenkins again by run command:

```
$ vagrant ssh -c 'sudo make up'
```
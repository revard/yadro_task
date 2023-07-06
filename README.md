# Yadro task

## VM with Jenkins server and registred agent

Brief description of this project:

1. Instal VM by Vagrant.
2. Deploy VM server by ansible playbooks using Vagrant.
    - Packages updating
    - Python 3 installation
    - Docker installation and change default networ to 10.00.1
    - Jenkins server deployment (manual setup)
3. Run registered jenkins agent by ansible playbook.

### Vagrant 

You can change VM settings in config file `Vagrantfile` for example NET_CARD_NAME `config.vm.network "public_network" , bridge: "NET_CARD_NAME"`

To start and stop VM run commands in shell:

```
# Start VM 
$ vagrant up

# Kill VM 
$ vagrant destroy

# Run ansible provision
$ vagrant provision

# SSH login to VM
$ vagrant ssh
```

### Jenkins

After Jenkins server installed you can find initial password in bottom of screen or by running command:

```
$  vagrant ssh -c 'sudo docker exec $(sudo docker ps -aqf "name=jenkins") cat /var/jenkins_home/secrets/initialAdminPassword'
```

And put it on page  http://localhost:8080/

Please add user test:test. You can update Jenkins using web page and press restart option.

If Jenkins in container didn`t restart propertly  you can manualy start jenkins by run command:

```
$ vagrant ssh -c 'sudo make up'
```

On page Instance Configuration, setup `Jenkins URL:￼http://172.168.0.2:8080/`

#### Agent

After Jenkins server configuring please run ansible playbook to start registered jenkins agent:

```
./provisioning/files/vg_run_jenkins_agent.sh
```

You can check agent status on http://localhost:8080/computer/bullseye/

## Jenkins file for packaging python project

Here python test project https://github.com/revard/pkg_py_proj/ and Jenkins file - https://github.com/revard/pkg_py_proj/blob/main/Jenkinsfile

---

## TODO

1. Rewrite with roles
2. Jenkins automation install 


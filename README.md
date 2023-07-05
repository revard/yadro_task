# Yadro task

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
```

### Jenkins

After Jenkins server installed you can find initial password by running command:

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

After configuring Jenkins run ansible playbook for start registered jenkins agent. Please write real user name.


```
$ PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ANSIBLE_HOST_KEY_CHECKING=false ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o ControlMaster=auto -o ControlPersist=60s'  ansible-playbook --connection=ssh --timeout=30 --limit="default" --inventory-file=/home/[!!!USER_NAME!!!]/yadro_task/.vagrant/provisioners/ansible/inventory -v provisioning/jenkins-client.yml
```

### TODO

1. Rewrite roles
2. Jenkins automation install 
#!/bin/bash

source `which util.sh`

backtotop
desc "Dont check ssh-keyscan -H 192.168.122.1 >> ~/.ssh/known_hosts"
run "export KVM_CONNECTION_URL=qemu+ssh://root@192.168.122.1/system"

backtotop
desc "Check we have access to it "
run "ssh root@192.168.122.1 hostname"

# docker machine

backtotop
desc "Create a docker-machine with this kvm"
run "docker-machine create -d kvm --kvm-connection-url qemu+ssh://root@192.168.122.1/system magico"

backtotop
desc "Check vm is there"
run "virsh -c qemu+ssh://root@192.168.122.1/system list"

backtotop
desc "Access this vm"
run "docker-machine ssh magico hostname"

# clean up 
backtotop
desc "Delete this vm"
run "docker-machine kill magico"

# Minishift 

backtotop
desc "Set the remote url through an environment variable"
run "export KVM_CONNECTION_URL=qemu+ssh://root@192.168.122.1/system"

backtotop
desc "Prevent minishift from checking kvm stuff"
run "minishift config set warn-check-kvm-driver true"

backtotop
desc "Create a minishift environment"
run "minishift start --memory 6144 --disk-size 20000"

backtotop
desc "Check vm is there"
run "virsh -c qemu+ssh://root@192.168.122.1/system list"

backtotop
desc "Access this vm"
run "docker-machine ssh minishift hostname"

backtotop
desc "Set openshift environment"
run "minishift oc-env"

backtotop
desc "Test openshift environment"
run "oc get pod"

# clean up 
backtotop
desc "Delete this vm"
run "minishift delete"

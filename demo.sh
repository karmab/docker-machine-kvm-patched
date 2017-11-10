#!/bin/bash

source `which util.sh`

backtotop
desc "Accept ssh host key of the remote hypervisor"
run "ssh-keyscan -H 192.168.122.1 >> ~/.ssh/known_hosts"

backtotop
desc "Check we have access to it"
run "ssh root@192.168.122.1 hostname"

backtotop
desc "Make sure there s no boot2docker.iso available so it gets created"
run "ssh root@192.168.122.1 rm -rf /var/lib/libvirt/images/boot2docker.iso"

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
run "docker-machine rm -f magico"

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
run "minishift ssh hostname"

backtotop
desc "Set openshift environment"
run "eval $(minishift oc-env)"

backtotop
desc "Login openshift environment"
run "oc login -u system:admin"

backtotop
desc "Check pods"
run "oc get pod --all-namespaces"

# clean up 
backtotop
desc "Delete this vm"
run "minishift delete --force"

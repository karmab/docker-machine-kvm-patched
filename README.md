## about this repo

this repo is only meant to hold my binary of docker-machine-driver-kvm with support for remote host.

details [here](https://github.com/dhiltgen/docker-machine-kvm/pull/63)

## basic testing

```
docker-machine create -d kvm --kvm-connection-url qemu+ssh://root@192.168.1.6/system magico
```
you can  also use *KVM\_CONNECTION\_URL* env variable instead

## minishift 

we omit the kvm checks and provide the libvirt URI as an environment variable

```
export KVM_CONNECTION_URL=qemu+ssh://root@192.168.122.1/system
minishift config set warn-check-kvm-driver true
minishift start --memory 6144 --disk-size 20000
```

###  minishift centos image  

one ugly hack would be to use the *KVM\_BOOT2DOCKER\_URL* which works for provisioning of the vm, but not for full setup...

would rather need to:

 - detect boot2docker is not used, but centos
 - provide correct setup 
 - do the same for minikube custom iso

```
export KVM_CONNECTION_URL=qemu+ssh://root@192.168.122.1/system
export KVM_BOOT2DOCKER_URL=https://github.com/minishift/minishift-centos-iso/releases/download/v1.3.0/minishift-centos7.iso
docker-machine create -d kvm magico
```

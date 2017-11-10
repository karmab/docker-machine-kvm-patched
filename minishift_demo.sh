export MINISHIFT_VERSION="1.8.0"
export DOCKER_MACHINE_VERSION="0.13.0"
yum -y install libvirt-libs libvirt-client
echo 'export PATH=/usr/local/bin:$PATH' >> /root/.bashrc
export PATH=/usr/local/bin:$PATH
curl -L https://github.com/minishift/minishift/releases/download/v$MINISHIFT_VERSION/minishift-$MINISHIFT_VERSION-linux-amd64.tgz > /root/minishift-$MINISHIFT_VERSION-linux-amd64.tgz
tar zxvf /root/minishift-$MINISHIFT_VERSION-linux-amd64.tgz
mv minishift-$MINISHIFT_VERSION-linux-amd64/minishift /usr/bin/
chmod u+x /usr/bin/minishift
curl -L https://github.com/docker/machine/releases/download/v$DOCKER_MACHINE_VERSION/docker-machine-`uname -s`-`uname -m` >  /usr/bin/docker-machine
chmod u+x /usr/bin/docker-machine
curl -L https://github.com/karmab/docker-machine-kvm-patched/raw/master/docker-machine-driver-kvm-centos7 > /usr/bin/docker-machine-driver-kvm
chmod u+x /usr/bin/docker-machine-driver-kvm

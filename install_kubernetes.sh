#!/bin/bash

set -e

reset=$(tput sgr0)
green=$(tput setaf 76)
blue=$(tput setaf 25)
red=$(tput setaf 1)

info() {
    printf "${blue}➜ %s${reset}\n" "$@"
}
error() {
    printf "${red}➜ %s${reset}\n" "$@"
}
success() {
    printf "${green}✔ %s${reset}\n" "$@"
}

install_prepare(){
#    setenforce 0

    rm -rf /etc/yum.repos.d/virt7-docker-common-release.repo

echo "[virt7-docker-common-release]
name=virt7-docker-common-release
baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
gpgcheck=0" >> /etc/yum.repos.d/virt7-docker-common-release.repo

    yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd flannel
}


check_user(){
    root=$(id -u)
    if [ "$root" -ne 0 ] ;then
        error "must run as root"
        exit 1
    fi
}


kube::master_up(){
    MASTER_IP=`ifconfig eth0 | grep inet | grep netmask | grep -v "127.0.0.1" | awk '{print $2}'`

    install_prepare

    for FILE in /etc/kubernetes/config /etc/etcd/etcd.conf /etc/kubernetes/apiserver /etc/sysconfig/flanneld; do
        info "delete $FILE"
        rm -rf $FILE
    done

    info "create config"
    echo -e 'KUBE_LOGTOSTDERR="--logtostderr=true"\nKUBE_LOG_LEVEL="--v=0"\nKUBE_ALLOW_PRIV="--allow-privileged=false"\nKUBE_MASTER="--master=http://'${MASTER_IP}':8080"' >> /etc/kubernetes/config
    echo -e 'ETCD_NAME=default\nETCD_DATA_DIR="/var/lib/etcd/default.etcd"\nETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"\nETCD_ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379"' >> /etc/etcd/etcd.conf
    echo -e 'KUBE_API_ADDRESS="--address=0.0.0.0"\nKUBE_API_PORT="--port=8080"\nKUBELET_PORT="--kubelet-port=10250"\nKUBE_ETCD_SERVERS="--etcd-servers=http://localhost:2379"\nKUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"\nKUBE_API_ARGS=""' >> /etc/kubernetes/apiserver
    echo -e 'FLANNEL_ETCD_ENDPOINTS="http://localhost:2379"\nFLANNEL_ETCD_PREFIX="/kube-centos/network"' >>  /etc/sysconfig/flanneld

    info "start etcd"
    systemctl start etcd
    etcdctl mkdir /kube-centos/network || echo "dir already exist"
    etcdctl mk /kube-centos/network/config "{ \"Network\": \"172.30.0.0/16\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }" ||  echo "key already exist"

    info "start service..."
    for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler flanneld; do
	    systemctl restart $SERVICES
	    systemctl enable $SERVICES
	    systemctl status $SERVICES
    done

    info "config kubectl..."
    kubectl config set-cluster default-cluster --server=http://localhost:8080
    kubectl config set-context default-context --cluster=default-cluster --user=default-admin
    kubectl config use-context default-context

    success "master install success"
}


kube::node_up(){
    if [ ! -n "$1" ] ;then
        error "please input master ip"
    fi

    CLIENT_IP=`ifconfig eth0 | grep inet | grep netmask | grep -v "127.0.0.1" | awk '{print $2}'`

    info "node [$CLIENT_IP] join to master [$1]"

    install_prepare

    for FILE in /etc/kubernetes/config /etc/kubernetes/kubelet /etc/sysconfig/flanneld ; do
        info "delete $FILE"
        rm -rf $FILE
    done

    echo -e 'KUBE_LOGTOSTDERR="--logtostderr=true"\nKUBE_LOG_LEVEL="--v=0"\nKUBE_ALLOW_PRIV="--allow-privileged=false"\nKUBE_MASTER="--master=http://'${CLIENT_IP}':8080"' >> /etc/kubernetes/config
    echo -e 'KUBELET_ADDRESS="--address=0.0.0.0"\nKUBELET_PORT="--port=10250"\nKUBELET_HOSTNAME="--hostname-override='${CLIENT_IP}'"\nKUBELET_API_SERVER="--api-servers=http://'$1':8080"\nKUBELET_ARGS=""' >> /etc/kubernetes/kubelet
    echo -e 'FLANNEL_ETCD_ENDPOINTS="http://'$1':2379"\nFLANNEL_ETCD_PREFIX="/kube-centos/network"' >> /etc/sysconfig/flanneld

    for SERVICES in kube-proxy kubelet flanneld docker; do
        systemctl restart $SERVICES
        systemctl enable $SERVICES
        systemctl status $SERVICES
    done

    info "config kubectl..."
    kubectl config set-cluster default-cluster --server=http://$1:8080
    kubectl config set-context default-context --cluster=default-cluster --user=default-admin
    kubectl config use-context default-context

    info "use docker booster by Daocloud"
    curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://4f4db0a7.m.daocloud.io
    systemctl restart docker

    info "pull image"
    docker pull docker.io/mritd/pause-amd64
    docker tag docker.io/mritd/pause-amd64 gcr.io/google_containers/pause-amd64:3.0
    docker tag gcr.io/google_containers/pause-amd64:3.0 gcr.io/google_containers/pause-amd64

    success "node install success"
}


kube::tear_down()
{
    for FILE in /etc/kubernetes/config /etc/etcd/etcd.conf /etc/kubernetes/apiserver /etc/sysconfig/flanneld; do
        info "delete $FILE"
        rm -rf $FILE
    done

    systemctl stop kubelet.service

    info "delete docker container"
    docker ps -aq|xargs -I '{}' docker stop {}
    docker ps -aq|xargs -I '{}' docker rm {}

    df |grep /var/lib/kubelet|awk '{ print $6 }'|xargs -I '{}' umount {}
    rm -rf /var/lib/kubelet && rm -rf /etc/kubernetes/ && rm -rf /var/lib/etcd

    info "remove package"
    yum remove -y docker kubernetes etcd flannel
    ip link del flannel.1
}


main(){
    check_user
    case $1 in
    "m" | "master" )
        kube::master_up
        ;;
    "j" | "node" )
        shift
        kube::node_up $@
        ;;
    "d" | "down" )
        kube::tear_down
        ;;
    *)
        echo "usage: $0 m[master] | j[join] master_ip | d[down] "
        echo "       $0 master to setup master "
        echo "       $0 node   to join master with token "
        echo "       $0 down   to tear all down ,inlude all data! so becarefull"
        echo "       unkown command $0 $@"
        ;;
    esac
}

main $@

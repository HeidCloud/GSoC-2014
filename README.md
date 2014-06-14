# CLOUDSTACK-6114

## Introduction

The follow project aims to simplify getting a full Apache Cloudstack environment running on your machine. This may be done for development or testing purposes.

The included VagrantFile will give you:

 - Management
     - NFS Server
     - MySQL Server
     - Router

 - XenServer 6.2

## Getting started

1. Ensure your system has `git` installed.

1. Clone the repository:

```bash
git clone https://github.com/imduffy15/GSoC-2014.git
```

1. Download and Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

1. Download and install [Vagrant](https://www.vagrantup.com/downloads.html)

1. Ensure all Vagrant Plugins are installed:

```bash
cd /path/to/cloned/repo
sh scripts/vagrant_prep.sh
```

1. Start MySQL, NFS, Gateway and Xenserver Boxes


```
cd /path/to/cloned/repo/vagrant
vagrant up
```

## Common Issues

- 'Cannot forward the specified ports on this VM': There could be MySQL or some other
  service running on the host OS causing vagrant to fail setting up local port forwarding.

## Cloudstack

### Compiling

From the root directory of this repo:

```
cd cloudstack
wget http://download.cloud.com.s3.amazonaws.com/tools/vhd-util -P scripts/vm/hypervisor/xenserver/
chmod +x scripts/vm/hypervisor/xenserver/vhd-util
mvn -P developer,systemvm clean install -DskipTests=true
```

### Starting

From the `cloudstack` directory of this repo:

#### Deploy Database

```
mvn -P developer -pl developer,tools/devcloud -Ddeploydb
```

#### Starting Cloudstack

```
mvn -pl :cloud-client-ui jetty:run
```

### Deploying

From the `cloudstack` directory of this repo:

### Install Marvin

```
pip install tools/marvin/dist/Marvin-0.1.0.tar.gz
```

#### Deploy devcloud.cfg

```
python tools/marvin/marvin/deployDataCenter.py -i ../devcloud.cfg 
```


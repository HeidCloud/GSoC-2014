# CLOUDSTACK-6114

## Introduction

The follow project aims to simplify getting a full Apache Cloudstack environment running on your machine.

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

### Start the vagrant boxes


```bash
cd /path/to/GSoC-2014/repo/vagrant
vagrant up
```

*** Common issues: ***

- 'Cannot forward the specified ports on this VM': There could be MySQL or some other
  service running on the host OS causing vagrant to fail setting up local port forwarding.


### Start Cloudstack

1. Clone the Cloudstack Repository:

	```
	git clone https://github.com/apache/cloudstack.git
	```

*** Note: ***

Personally I prefer to use the 4.3 codebase rather than master. If you wish to do the same:	

```
git reset --hard 0810029
```

1. Download vhd-util:

	```bash
	cd /path/to/cloudstack/repo
	wget http://download.cloud.com.s3.amazonaws.com/tools/vhd-util -P scripts/vm/hypervisor/xenserver/
	chmod +x scripts/vm/hypervisor/xenserver/vhd-util
	```

1. Compile Cloudstack:

	```bash
	cd /path/to/cloudstack/repo
	mvn -P developer,systemvm clean install -DskipTests=true
	```
	
1. Deploy Cloudstack Database:

	```bash
	cd /path/to/cloudstack/repo
	mvn -P developer -pl developer,tools/devcloud -Ddeploydb
	```

1. Start Cloudstack:

	```bash
	cd /path/to/cloudstack/repo
	mvn -pl :cloud-client-ui jetty:run
	```

1. Install Marvin:

	```
	cd /path/to/cloudstack/repo
	pip install tools/marvin/dist/Marvin-0.1.0.tar.gz
	```

1. Deploy devcloud.cfg

	```
	python /path/to/cloudstack/repo/tools/marvin/marvin/deployDataCenter.py -i /path/to/GSoC-2014/repo/configurations/devcloud.cfg 
	```


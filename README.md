# Rough usage....

## Start MySQL, NFS, Gateway and Xenserver Boxes

From the root directory of this repo:

```
cd MySql_NFS_XenServer
vagrant up
```

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

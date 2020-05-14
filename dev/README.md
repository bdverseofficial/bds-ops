# Scripts for developpment purpose

In a developement environement, usually you can use those script to prepare your machine. 
For the back infrastructure we strongly advise to use a Linux OS.

## Linux Deployment

### CLone the repo

```shell
git clone https://github.com/bdverseofficial/bds-ops.git
```

### Install the back infrastructure

- First ensure you have docker installed and working
- Ensure your current user could use docker
- execute docker-base.sh, the script will ask your root password for enabl;ing monitoring on docker
- configure Couchbase by using the url: http://IP:8091 or execute docker-initcb.sh for a default configuration
    - Create your administrator password
    - All the config files assumed the password will be password, if you chnage this one, change the global.conf.json and metricbeat.docker.yml file.
    - Ensure to activate the Data, Query, Analytics, Index service
    - Create 2 buckets: BDS (Recommanded 128MB), VAR (Recommanded 1024MB).
- execute docker-initbeat.sh

### Install the BDS server for a test platform

We are providing a sample of docker script to start a BDS server for test. we strongly advise to use a Linux OS.

- First ensure you have docker installed and working
- Ensure your current user could use docker
- Ensure the global.conf.json is correct for your environnement. The one provided will assume the BDS server is on the same machine than the back infratsructure.
- execute docker-bds.sh
- Configure the server by going on http://IP:9080
    - Create the administrator password
    - Log on the BDS server


### back infrastructure details

#### Script: docker-back.sh

The script will create a folder in your home directory named bds. The script will copy there all the config files, and start all the container by mounting thie bds folder for various usage.

The script will:
- Remove all old container
- Copy config files to the bds home folder
- Create docker for ElasticSearch
- Create docker for Kibana
- Create docker for MetricBeat
- Create docker for FileBeat
- Create docker for Couchbase

#### Script: docker-initbeat.sh

- Init FileBeat for Kibana
- Init MetricBeat for Kibana

#### Script: docker-initcb.sh

- Init the cluster with username Administrator and password Password
- Create the BDS bucket with 256MB
- Creaye the VAR bucket with 1024MB

### Bds Server details

#### Script: docker-bds.sh

The script will create a folder in your home directory named bds. The script will copy there all the config files, and start all the container by mounting thie bds folder for various usage.
- ~/bds/server/certificates: for storing your certificate, by default expecting a file named certificate.pfx (Optionnal if https is false in global.conf.json)
- ~/bds/server/plugins: for pushing your own custom plugins in the server. Each plugins must be in a different folder.
- ~/bds/server/data: for pushing data during the initialisation of a plugins or a client application.

The script will:
- Remove all old container
- Copy config files to the bds home folder
- Create docker for Bds Server

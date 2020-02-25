docker stop es
docker rm es
docker stop kibana
docker rm kibana
docker stop apm
docker rm apm
docker stop metricbeat
docker rm metricbeat
docker stop filebeat
docker rm filebeat
docker stop couchbase
docker rm couchbase

mkdir -p ~/bds/couchbase/data

mkdir -p ~/bds/elasticsearch
mkdir -p ~/bds/elasticsearch/data
cp ./back-config/elasticsearch.docker.yml ~/bds/elasticsearch/

mkdir -p ~/bds/kibana
cp ./back-config/kibana.docker.yml ~/bds/kibana/

mkdir -p ~/bds/apm
cp ./back-config/apm-server.docker.yml ~/bds/apm/

mkdir -p ~/bds/metricbeat
cp ./back-config/metricbeat.docker.yml ~/bds/metricbeat/

mkdir -p ~/bds/filebeat
cp ./back-config/filebeat.docker.yml ~/bds/filebeat/

docker run -d --restart unless-stopped --name es \
-p 9200:9200 -p 9300:9300 \
-v ~/bds/elasticsearch/data:/usr/share/elasticsearch/data \
-v ~/bds/elasticsearch/elasticsearch.docker.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
docker.elastic.co/elasticsearch/elasticsearch:7.5.2

docker run -d --restart unless-stopped --name kibana \
-v ~/bds/kibana/kibana.docker.yml:/usr/share/kibana/config/kibana.yml \
-p 5601:5601 \
docker.elastic.co/kibana/kibana:7.5.2

docker run -d --restart unless-stopped --name apm \
-v ~/bds/apm/apm-server.docker.yml:/usr/share/apm-server/apm-server.yml \
-p 8200:8200 \
docker.elastic.co/apm/apm-server:7.5.2 -strict.perms=false

sudo docker run -d --restart unless-stopped --name=filebeat --user=root \
  -v ~/bds/filebeat/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro \
  -v /var/lib/docker/containers:/var/lib/docker/containers:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --network host \
  docker.elastic.co/beats/filebeat:7.5.2 filebeat -e -strict.perms=false  

sudo docker run -d --restart unless-stopped --name=metricbeat --user=root \
  -v ~/bds/metricbeat/metricbeat.docker.yml:/usr/share/metricbeat/metricbeat.yml:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro \
  -v /proc:/hostfs/proc:ro \
  -v /:/hostfs:ro \
  --network host \
  docker.elastic.co/beats/metricbeat:7.5.2 metricbeat -e -system.hostfs=/hostfs -strict.perms=false 

docker run -d --restart unless-stopped --name couchbase \
-v ~/bds/couchbase/var:/opt/couchbase/var \
-p 8091-8096:8091-8096 -p 11210-11211:11210-11211 \
couchbase:6.5.0 


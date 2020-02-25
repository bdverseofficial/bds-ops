docker stop metricbeat-init
docker stop filebeat-init

docker rm metricbeat-init
docker rm filebeat-init

docker run \
--name metricbeat-init \
docker.elastic.co/beats/metricbeat:7.5.2 \
setup -E setup.kibana.host=172.17.0.1:5601 \
-E output.elasticsearch.hosts=["172.17.0.1:9200"]  

docker run \
--name filebeat-init \
docker.elastic.co/beats/filebeat:7.5.2 \
setup -E setup.kibana.host=172.17.0.1:5601 \
-E output.elasticsearch.hosts=["172.17.0.1:9200"]  

docker stop metricbeat-init
docker stop filebeat-init

docker rm metricbeat-init
docker rm filebeat-init
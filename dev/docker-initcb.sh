docker exec couchbase \
/opt/couchbase/bin/couchbase-cli cluster-init \
--cluster localhost \
--cluster-username Administrator \
--cluster-password password \
--cluster-ramsize 1280 \
--cluster-name BDS \
--cluster-index-ramsize 512 \
--cluster-analytics-ramsize 1024 \
--index-storage-setting memopt \
--services data,index,query,analytics

docker exec couchbase \
/opt/couchbase/bin/couchbase-cli bucket-create \
--cluster localhost \
--bucket-type couchbase \
--username Administrator \
--password password \
--bucket BDS \
--bucket-ramsize 256

docker exec couchbase \
/opt/couchbase/bin/couchbase-cli bucket-create \
--cluster localhost \
--bucket-type couchbase \
--username Administrator \
--password password \
--bucket VAR \
--bucket-ramsize 1024

docker stop bds
docker rm bds

mkdir -p ~/bds/server/certificates
mkdir -p ~/bds/server/plugins
mkdir -p ~/bds/server/data
mkdir -p ~/bds/html/cms
mkdir -p ~/bds/html/assets

mkdir -p ~/bds/server/config
cp ./bds-config/global.conf.json ~/bds/server/config/

docker pull bdverseofficial/bds

docker run -d --restart unless-stopped --name bds \
-p 49080:49080 \
-p 9080:9080 \
-p 9443:9443 \
-v ~/bds/server/config:/app/config \
-v ~/bds/server/certificates:/app/certificates \
-v ~/bds/server/plugins:/app/thirdpartyplugins \
-v ~/bds/server/data:/app/thirdpartydata \
-v ~/bds/html/assets:/app/assets \
-v ~/bds/html/cms:/app/cms \
bdverseofficial/bds
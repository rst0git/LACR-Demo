#!/bin/bash
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.4.1/elasticsearch-2.4.1.deb
sudo dpkg -i elasticsearch-2.4.1.deb
sudo service elasticsearch start
clear
echo "--------------------------------------------------"
echo "Elasticsearch is running on http://localhost:9200"
echo "Config file: /etc/elasticsearch/elasticsearch.yml"
echo "--------------------------------------------------"
echo "curl localhost:9200"
curl localhost:9200
